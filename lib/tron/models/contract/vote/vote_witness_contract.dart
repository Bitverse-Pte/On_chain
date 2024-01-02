import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';

import 'package:on_chain/tron/models/contract/vote/vote_witness_contract_vote.dart';

class VoteWitnessContract extends TronBaseContract {
  /// Create a new [VoteWitnessContract] instance by parsing a JSON map.
  factory VoteWitnessContract.fromJson(Map<String, dynamic> json) {
    final ownerAddress = TronAddress(json['owner_address']);
    final votes = (json['votes'] as List?)
        ?.map((vote) => VoteWitnessContractVote.fromJson(vote))
        .toList();
    final support = json['support'];

    return VoteWitnessContract(
      ownerAddress: ownerAddress,
      votes: votes,
      support: support,
    );
  }

  /// Create a new [VoteWitnessContract] instance with specified parameters.
  VoteWitnessContract(
      {required this.ownerAddress,
      List<VoteWitnessContractVote>? votes,
      this.support})
      : votes = votes == null
            ? null
            : List<VoteWitnessContractVote>.unmodifiable(votes);
  final TronAddress ownerAddress;
  final List<VoteWitnessContractVote>? votes;
  final bool? support;

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  List get values => [ownerAddress, votes, support];

  /// Convert the [VoteWitnessContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "votes": votes?.map((vote) => vote.toJson()).toList(),
      "support": support,
    };
  }

  /// Convert the [VoteWitnessContract] object to its string representation.
  @override
  String toString() {
    return "VoteWitnessContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.voteWitnessContract;
}
