import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/solana/service_example/service_example.dart';
import 'package:on_chain/on_chain.dart';
import 'package:retry/retry.dart';

void main() async {
  String walletKey = "";

  Mnemonic walletMnemonic = Mnemonic.fromString(walletKey);

  List<int> seed = Bip39SeedGenerator(walletMnemonic).generate();

  Bip32Slip10Ed25519 hdWallet = Bip32Slip10Ed25519.fromSeed(seed);

  final hdWalletDerivePath = hdWallet.derivePath("m/44'/501'/0'/0'");

  /// Derive private key from seed
  final ownerPrivateKey = SolanaPrivateKey.fromSeed(hdWalletDerivePath.privateKey.raw);

  print(ownerPrivateKey.toHex());

  String publicKeyHex = BytesUtils.toHexString(ownerPrivateKey.publicKey().toBytes());
  List<int> publicKeyBytes = BytesUtils.fromHexString(publicKeyHex);
  final pubKey = SolanaPublicKey.fromBytes(publicKeyBytes);
  print(pubKey.toAddress().address);

  print(publicKeyHex);

  /// Derive public key from private key
  SolAddress owner = ownerPrivateKey.publicKey().toAddress();

  RPCHttpService service = RPCHttpService("https://rpc.ankr.com/solana_devnet");
  final rpc = SolanaRPC(service);

  VersionedTransactionResponse rawTransaction = await rpc.request(SolanaRPCGetTransaction(transactionSignature: 'D13jTJYXoQBcRY9AfT5xRtsew7ENgCkNs6mwwwAcUCp4ZZCEM7YwZ7en4tVsoDa7Gu75Jjj2FgLXNUz8Zmgedff'));

  print(rawTransaction);

  ///此处通过claculate_instruction计算出来instruction
  // await getBalance(owner, ownerPrivateKey);

  ///此处通过claculate_instruction计算出来instruction
  // await getBalanceByAddress(owner, ownerPrivateKey);

  // await getTransaction("5eZQ79RXH567hqnF6W3iqhd5XYYVG6GerttFZUDu1qomoF4bhRsLpMcpQe1iNtSMQnq9K1upGTUNuowdDAspAiwv");
}

Future<void> getBalance(SolAddress owner, SolanaPrivateKey ownerPrivateKey) async {
  final instruction = CustomProgram(
    keys: [
      owner.toSignerAndWritable(),
      SystemProgramConst.programId.toReadOnly(),
    ],
    programId: SolAddress('GMq4fZi2nikRsE2izHjGAQSTNVXkxskxvCtikxG1PuS3'),
    layout: GetBalanceLayout(),
  );

  RPCHttpService service = RPCHttpService("https://rpc.ankr.com/solana_devnet");
  final rpc = SolanaRPC(service);

  final blockHash = await rpc.request(const SolanaRPCGetLatestBlockhash());

  final transaction = SolanaTransaction(
    payerKey: owner,
    instructions: [instruction],
    recentBlockhash: blockHash.blockhash,
  );

  final ownerSignature = ownerPrivateKey.sign(transaction.serializeMessage());
  transaction.addSignature(owner, ownerSignature);

  /// Serialize the transaction.
  final serializedTransaction = transaction.serializeString();

  /// Send the transaction to the Solana network.
  String hash = await rpc.request(SolanaRPCSendTransaction(encodedTransaction: serializedTransaction));

  print('transaction hash: $hash');
}

Future<void> getBalanceByAddress(SolAddress owner, SolanaPrivateKey ownerPrivateKey) async {
  final instruction = CustomProgram(
    keys: [
      owner.toSignerAndWritable(),
      //需要加上programId, 否则会出现Not enough account keys for instruction
      SystemProgramConst.programId.toReadOnly(),
    ],
    programId: SolAddress('C91zGKQExvqvSg9pgQVf8JALt2QYeTpZY82gGnnTWSZM'),
    layout: GetBalanceByAddressLayout(targetAccount: owner),
  );

  RPCHttpService service = RPCHttpService("https://rpc.ankr.com/solana_devnet");
  final rpc = SolanaRPC(service);

  final blockHash = await rpc.request(const SolanaRPCGetLatestBlockhash());

  final transaction = SolanaTransaction(
    payerKey: owner,
    instructions: [instruction],
    recentBlockhash: blockHash.blockhash,
  );

  final ownerSignature = ownerPrivateKey.sign(transaction.serializeMessage());
  transaction.addSignature(owner, ownerSignature);

  print(transaction.message);

  // /// Serialize the transaction.
  // final serializedTransaction = transaction.serializeString();
  //
  // /// Send the transaction to the Solana network.
  // String hash = await rpc.request(SolanaRPCSendTransaction(encodedTransaction: serializedTransaction));
  //
  // print('transaction hash: $hash');
  //
  // final r = RetryOptions(maxAttempts: 15, maxDelay: const Duration(seconds: 1));
  // final response = await r.retry(
  //   () async {
  //     try {
  //       VersionedTransactionResponse response = await rpc.request(SolanaRPCGetTransaction(transactionSignature: '123123123'));
  //       return response;
  //     } catch (e) {
  //       throw Exception(e.toString());
  //     }
  //   },
  //   // Retry on SocketException or TimeoutException
  //   retryIf: (e) => e is Exception,
  // );
  //
  // print(response);
}

Future<void> getTransaction(String hash) async {
  RPCHttpService service = RPCHttpService("https://rpc.ankr.com/solana_devnet");
  final rpc = SolanaRPC(service);

  VersionedTransactionResponse transactionResult =
      await rpc.request(SolanaRPCGetTransaction(transactionSignature: hash));

  print(transactionResult);
}
