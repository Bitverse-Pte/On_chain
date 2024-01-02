import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
  /// intialize private key, address, receiver and ....
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  final ownerPrivateKey = TronPrivateKey.fromBytes(bip44.privateKey.raw);
  final ownerPublicKey = ownerPrivateKey.publicKey();
  final ownerAddress = ownerPublicKey.toAddress();
  final accountForCreate = TronAddress("TWaU4mkdUSeCbsLawmkC9oYfWo29bCc179");

  /// intialize shasta http provider to send and receive requests
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

  /// create contract
  final transferContract = AccountCreateContract(
      ownerAddress: ownerAddress,
      accountAddress: accountForCreate,
      type: AccountType.assetIssue);

  /// validate transacation and got required data like block hash and ....
  final request = await rpc
      .request(TronRequestCreateAccount.fromContract(transferContract));

  /// An error has occurred with the request, and we need to investigate the issue to determine what is happening.
  if (!request.isSuccess) {
    /// print(request.error);
    return;
  }

  /// get transactionRaw from response and make sure set fee limit
  final rawTr = request.transactionRaw!
      .copyWith(data: utf8.encode("https://github.com/mrtnetwork"));

  /// txID
  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = ownerPrivateKey.sign(rawTr.toBuffer());

  /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: transaction.toHex));

  /// https://shasta.tronscan.org/#/transaction/953f3d52c8d4acd07cc9883a4ea8819f21e4ceb20a42164cdd37e23432c8dd8c
}
