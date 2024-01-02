import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class VoteWitnessContractVote extends TronProtocolBufferImpl {
  /// Create a new [VoteWitnessContractVote] instance by parsing a JSON map.
  factory VoteWitnessContractVote.fromJson(Map<String, dynamic> json) {
    final voteAddress = TronAddress(json['vote_address']);
    final voteCount = BigintUtils.parse(json['vote_count']);

    return VoteWitnessContractVote(
      voteAddress: voteAddress,
      voteCount: voteCount,
    );
  }

  /// Create a new [VoteWitnessContractVote] instance with specified parameters.
  VoteWitnessContractVote({required this.voteAddress, required this.voteCount});
  final TronAddress voteAddress;
  final BigInt voteCount;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [voteAddress, voteCount];

  /// Convert the [VoteWitnessContractVote] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "vote_address": voteAddress.toString(),
      "vote_count": voteCount.toString(),
    };
  }

  /// Convert the [VoteWitnessContractVote] object to its string representation.
  @override
  String toString() {
    return "VoteWitnessContractVote{${toJson()}}";
  }
}
