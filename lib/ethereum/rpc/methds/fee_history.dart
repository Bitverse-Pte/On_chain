import 'package:on_chain/ethereum/models/block_tag.dart';
import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';
import 'package:on_chain/ethereum/models/fee_history.dart';

class RPCGetFeeHistory extends ETHRPCRequest<FeeHistory?> {
  RPCGetFeeHistory(
      {required this.blockCount,
      required BlockTagOrNumber newestBlock,
      required this.rewardPercentiles})
      : super(blockNumber: newestBlock);

  /// eth_feeHistory
  @override
  EthereumMethods get method => EthereumMethods.getFeeHistory;
  final int blockCount;
  final List<double> rewardPercentiles;
  @override
  List<dynamic> toJson() {
    return [
      "0x${blockCount.toRadixString(16)}",
      blockNumber,
      rewardPercentiles
    ];
  }

  @override
  FeeHistory? onResonse(result) {
    if (result == null || result['gasUsedRatio'] == null) return null;
    return FeeHistory.fromJson(result);
  }
}
