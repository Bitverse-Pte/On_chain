import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class MarketCancelOrderContract extends TronBaseContract {
  /// Create a new [MarketCancelOrderContract] instance by parsing a JSON map.
  factory MarketCancelOrderContract.fromJson(Map<String, dynamic> json) {
    return MarketCancelOrderContract(
      ownerAddress: TronAddress(json["owner_address"]),
      orderId: BytesUtils.tryFromHexString(json["order_id"]),
    );
  }

  /// Create a new [MarketCancelOrderContract] instance with specified parameters.
  MarketCancelOrderContract({required this.ownerAddress, List<int>? orderId})
      : orderId = BytesUtils.tryToBytes(orderId, unmodifiable: true);

  /// Account address
  final TronAddress ownerAddress;
  final List<int>? orderId;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [ownerAddress, orderId];

  /// Convert the [MarketCancelOrderContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "order_id": BytesUtils.tryToHexString(orderId)
    };
  }

  /// Convert the [MarketCancelOrderContract] object to its string representation.
  @override
  String toString() {
    return "MarketCancelOrderContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.marketCancelOrderContract;
}
