import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';

/// Unstake the TRX staked during Stake1.0, release the obtained bandwidth or energy and TP.
/// This operation will cause automatically cancel all votes.
class UnfreezeBalanceContract extends TronBaseContract {
  /// Create a new [UnfreezeBalanceContract] instance by parsing a JSON map.
  factory UnfreezeBalanceContract.fromJson(Map<String, dynamic> json) {
    return UnfreezeBalanceContract(
      ownerAddress: TronAddress(json["owner_address"]),
      resource: ResourceCode.fromName(json["resource"]),
      receiverAddress: json["receiver_address"] == null
          ? null
          : TronAddress(json["receiver_address"]),
    );
  }

  /// Create a new [UnfreezeBalanceContract] instance with specified parameters.
  UnfreezeBalanceContract(
      {required this.ownerAddress, this.resource, this.receiverAddress});

  /// Transaction initiator address
  final TronAddress ownerAddress;

  /// Resource type
  final ResourceCode? resource;

  /// Resource receiver address
  final TronAddress? receiverAddress;

  @override
  List<int> get fieldIds => [1, 10, 15];

  @override
  List get values =>
      [ownerAddress, resource?.value == 0 ? null : resource, receiverAddress];

  /// Convert the [UnfreezeBalanceContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "resource": resource?.name,
      "receiver_address": receiverAddress?.toString(),
    };
  }

  /// Convert the [UnfreezeBalanceContract] object to its string representation.
  @override
  String toString() {
    return "UnfreezeBalanceContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.unfreezeBalanceContract;
}
