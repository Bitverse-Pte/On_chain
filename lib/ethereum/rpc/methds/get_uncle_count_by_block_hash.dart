import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns the number of uncles in a block from a block matching the given block hash.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getUncleCountByBlockHash)
class RPCGetGetUncleCountByBlockHash extends ETHRPCRequest<int> {
  RPCGetGetUncleCountByBlockHash({
    required this.blockHash,
  });

  /// eth_getUncleCountByBlockHash
  @override
  EthereumMethods get method => EthereumMethods.getUncleCountByBlockHash;

  /// hash of a block
  final String blockHash;

  @override
  List<dynamic> toJson() {
    return [blockHash];
  }

  @override
  int onResonse(result) {
    return ETHRPCRequest.onIntResponse(result);
  }

  @override
  String toString() {
    return "RPCGetGetUncleCountByBlockHash{${toJson()}}";
  }
}
