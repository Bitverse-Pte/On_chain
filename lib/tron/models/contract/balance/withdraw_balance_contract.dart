import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';

class WithdrawBalanceContract extends TronBaseContract {
  /// Create a new [WithdrawBalanceContract] instance by parsing a JSON map.
  factory WithdrawBalanceContract.fromJson(Map<String, dynamic> json) {
    return WithdrawBalanceContract(
      ownerAddress: TronAddress(json["owner_address"]),
    );
  }

  /// Create a new [WithdrawBalanceContract] instance with specified parameters.
  WithdrawBalanceContract({required this.ownerAddress});
  final TronAddress ownerAddress;

  @override
  List<int> get fieldIds => [1];

  @override
  List get values => [ownerAddress];

  /// Convert the [WithdrawBalanceContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {"owner_address": ownerAddress};
  }

  /// Convert the [WithdrawBalanceContract] object to its string representation.
  @override
  String toString() {
    return 'WithdrawBalanceContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.withdrawBalanceContract;
}
