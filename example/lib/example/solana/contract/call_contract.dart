import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/solana/service_example/service_example.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
  String walletKey = "";

  Mnemonic walletMnemonic = Mnemonic.fromString(walletKey);

  List<int> seed = Bip39SeedGenerator(walletMnemonic).generate();

  Bip32Slip10Ed25519 hdWallet = Bip32Slip10Ed25519.fromSeed(seed);

  final hdWalletDerivePath = hdWallet.derivePath("m/44'/501'/0'/0'");

  /// Derive private key from seed
  final ownerPrivateKey = SolanaPrivateKey.fromSeed(hdWalletDerivePath.privateKey.raw);

  String publicKeyHex = BytesUtils.toHexString(ownerPrivateKey.publicKey().toBytes());
  List<int> publicKeyBytes = BytesUtils.fromHexString(publicKeyHex);
  final pubKey = SolanaPublicKey.fromBytes(publicKeyBytes);
  print(pubKey.toAddress().address);

  print(publicKeyHex);

  /// Derive public key from private key
  SolAddress owner = ownerPrivateKey.publicKey().toAddress();

  ///此处通过claculate_instruction计算出来instruction
  final instruction = CustomProgram(
    keys: [owner.toSignerAndWritable()],
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
