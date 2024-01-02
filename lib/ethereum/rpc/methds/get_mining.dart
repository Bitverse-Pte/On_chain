import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns true if client is actively mining new blocks.
/// This can only return true for proof-of-work networks and may not be available in some clients since The Merge.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_mining)
class RPCGetMining extends ETHRPCRequest<bool> {
  RPCGetMining();

  /// eth_mining
  @override
  EthereumMethods get method => EthereumMethods.getMining;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return "RPCGetMining{${toJson()}}";
  }
}
