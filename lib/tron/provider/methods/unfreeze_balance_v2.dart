import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/balance/unfreez_balance_v2_contract.dart';
import 'package:on_chain/tron/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Unstake some TRX staked in Stake2.0, release the corresponding amount of bandwidth or energy, and voting rights (TP)
/// [developers.tron.network](https://developers.tron.network/reference/unfreezebalancev2-1).
class TronRequestUnfreezeBalanceV2
    extends TVMRequestParam<ParsedContractRequest, Map<String, dynamic>> {
  factory TronRequestUnfreezeBalanceV2.fromContract(
      UnfreezeBalanceV2Contract contract,
      {int? permissionId}) {
    return TronRequestUnfreezeBalanceV2(
        ownerAddress: contract.ownerAddress,
        unfreezeBalance: contract.unfreezeBalance,
        resource: contract.resource?.name,
        permissionId: permissionId);
  }
  TronRequestUnfreezeBalanceV2(
      {required this.ownerAddress,
      required this.unfreezeBalance,
      required this.resource,
      this.permissionId,
      this.visible = true});

  /// Owner address,
  final TronAddress ownerAddress;

  /// The amount of TRX to unstake, in sun
  final BigInt unfreezeBalance;

  /// Resource type: 'BANDWIDTH' or 'ENERGY'
  final String? resource;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/unfreezebalancev2
  @override
  TronHTTPMethods get method => TronHTTPMethods.unfreezebalancev2;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "unfreeze_balance": unfreezeBalance,
      "resource": resource,
      "Permission_id": permissionId,
      "visible": visible
    };
  }

  @override
  ParsedContractRequest onResonse(result) {
    return ParsedContractRequest.fromJson(result);
  }

  @override
  String toString() {
    return "TronRequestUnfreezeBalanceV2{${toJson()}}";
  }
}
