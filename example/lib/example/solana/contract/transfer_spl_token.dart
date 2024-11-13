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

  /// Derive public key from private key
  SolAddress owner = ownerPrivateKey.publicKey().toAddress();

  ///尝试获取下owner的Associate Token Account
  final ownerAssociatedTokenAccount = AssociatedTokenAccountProgramUtils.associatedTokenAccount(
    mint: SolAddress('4Udf1RGxKvwG7VqhMDCr3pBiHgy6ZvB2YNTi6CbTDerB'),
    owner: owner,
  );

  print(ownerAssociatedTokenAccount.address);

  SolAddress receiver = SolAddress("AcMwjMtrNiY5t29gF4MrUUDNXMRYVVPRYUgStSNYodUr");

  final receiverAssociatedTokenAccount = AssociatedTokenAccountProgramUtils.associatedTokenAccount(
    mint: SolAddress('4Udf1RGxKvwG7VqhMDCr3pBiHgy6ZvB2YNTi6CbTDerB'),
    owner: receiver,
  );

  RPCHttpService service = RPCHttpService("https://rpc.ankr.com/solana_devnet");
  final rpc = SolanaRPC(service);

  ///接收地址的address已经创建, 幂等控制, 如果已经存在账户, 忽略, 否则创建
  final createAssociatedTokenAccountProgram = AssociatedTokenAccountProgram.associatedTokenAccountIdempotent(
    payer: owner,
    associatedToken: receiverAssociatedTokenAccount.address,
    owner: receiver,
    mint: SolAddress('4Udf1RGxKvwG7VqhMDCr3pBiHgy6ZvB2YNTi6CbTDerB'),
  );

  final rb = await rpc.request(const SolanaRPCGetLatestBlockhash());
  SolanaTransaction createAccountTransaction = SolanaTransaction(
    payerKey: owner,
    instructions: [createAssociatedTokenAccountProgram],
    recentBlockhash: rb.blockhash,
  );
  createAccountTransaction.sign([ownerPrivateKey]);
  String hash = await rpc.request(
    SolanaRPCSendTransaction(
      encodedTransaction: createAccountTransaction.serializeString(),
    ),
  );
  print(hash);

  print(receiverAssociatedTokenAccount.address);

  final blockHash = await rpc.request(const SolanaRPCGetLatestBlockhash());

  BigInt amount = BigInt.from(99999921);

  final transferInstruction = SPLTokenProgram.transfer(
    source: ownerAssociatedTokenAccount.address,
    destination: receiverAssociatedTokenAccount.address,
    owner: owner,
    layout: SPLTokenTransferLayout(amount: amount),
  );

  /// Construct a Solana transaction with the transfer instruction.
  final transaction = SolanaTransaction(
      instructions: [transferInstruction],
      recentBlockhash: blockHash.blockhash,
      payerKey: owner,
      type: TransactionType.v0);

  /// Sign the transaction with the owner's private key.
  final ownerSignature = ownerPrivateKey.sign(transaction.serializeMessage());
  transaction.addSignature(owner, ownerSignature);

  /// Serialize the transaction.
  final serializedTransaction = transaction.serializeString();

  /// Send the transaction to the Solana network.
  hash = await rpc.request(SolanaRPCSendTransaction(encodedTransaction: serializedTransaction));
  print('transaction hash: $hash');
}
