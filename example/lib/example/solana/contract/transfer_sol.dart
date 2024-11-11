import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/solana/service_example/service_example.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
  int nowInMilliseconds = DateTime.now().millisecondsSinceEpoch;

  String walletKey = "gasp become thing view slow uncover derive private media bounce lunch network";

  Mnemonic walletMnemonic = Mnemonic.fromString(walletKey);

  List<int> seed = Bip39SeedGenerator(walletMnemonic).generate();

  Bip32Slip10Ed25519 hdWallet = Bip32Slip10Ed25519.fromSeed(seed);

  final hdWalletDerivePath = hdWallet.derivePath("m/44'/501'/0'/0'");

  /// Derive private key from seed
  final ownerPrivateKey = SolanaPrivateKey.fromSeed(hdWalletDerivePath.privateKey.raw);

  /// Derive public key from private key
  SolAddress owner = ownerPrivateKey.publicKey().toAddress();

  /// Define the recipient's address.
  final receiver = SolAddress("HMTnASQCMg9NghvVuJPXLwHeBZA1Dn2txELSaCcXEqdu");

  RPCHttpService service = RPCHttpService("https://rpc.ankr.com/solana_devnet");
  final rpc = SolanaRPC(service);

  /// Retrieve the latest block hash.
  final blockHash = await rpc.request(const SolanaRPCGetLatestBlockhash());

  /// Create a transfer instruction to move funds from the owner to the receiver.
  final transferInstruction = SystemProgram.transfer(
    from: owner,
    layout: SystemTransferLayout(lamports: SolanaUtils.toLamports("0.002")),
    to: receiver,
  );

  final limitInstruction = ComputeBudgetProgram.setComputeUnitLimit(
    layout: ComputeBudgetSetComputeUnitLimitLayout(units: 300000),
  );

  final budgetInstruction = ComputeBudgetProgram.setComputeUnitPrice(
    layout: ComputeBudgetSetComputeUnitPriceLayout(microLamports: BigInt.from(3)),
  );

  /// Construct a Solana transaction with the transfer instruction.
  final transaction = SolanaTransaction(
    instructions: [transferInstruction],
    // instructions: [transferInstruction, budgetInstruction],
    // instructions: [transferInstruction, limitInstruction],
    // instructions: [transferInstruction, limitInstruction, budgetInstruction],
    recentBlockhash: blockHash.blockhash,
    payerKey: owner,
    type: TransactionType.v0,
  );

  /// Sign the transaction with the owner's private key.
  final ownerSignature = ownerPrivateKey.sign(transaction.serializeMessage());
  transaction.addSignature(owner, ownerSignature);

  /// Serialize the transaction.
  final serializedTransaction = transaction.serializeString();

  // SolanaRPCSimulateTransaction simulateTransaction = SolanaRPCSimulateTransaction(
  //   encodedTransaction: serializedTransaction,
  // );
  //
  // final response = await rpc.request(simulateTransaction);
  //
  // print(response);

  final fee = await rpc.request(
    SolanaRPCGetFeeForMessage(
      encodedMessage: transaction.serializeMessageString(encoding: TransactionSerializeEncoding.base64),
    ),
  );
  print(fee);

  double timeCost = (DateTime.now().millisecondsSinceEpoch - nowInMilliseconds) / 1000;

  print('time cost of key generation: $timeCost');

  nowInMilliseconds = DateTime.now().millisecondsSinceEpoch;

  /// Send the transaction to the Solana network.
  final hash = await rpc.request(SolanaRPCSendTransaction(encodedTransaction: serializedTransaction));
  print('transaction hash: $hash');

  timeCost = (DateTime.now().millisecondsSinceEpoch - nowInMilliseconds) / 1000;
  print('time cost of SOL transaction: $timeCost');
}
