import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/interest_bearing_mint.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetInterestBearingMintConfigState
    extends SolanaRPCRequest<InterestBearingMintConfigState?> {
  const SolanaRPCGetInterestBearingMintConfigState({
    required this.account,
    Commitment? commitment,
    MinContextSlot? minContextSlot,
  }) : super(commitment: commitment, minContextSlot: minContextSlot);

  @override
  String get method => SolanaRPCMethods.getAccountInfo.value;
  final SolAddress account;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        SolanaRPCEncoding.base64.toJson(),
        minContextSlot?.toJson()
      ])
    ];
  }

  @override
  InterestBearingMintConfigState? onResponse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return InterestBearingMintConfigState.fromAccountBytes(
        accountInfo.toBytesData());
  }
}
