import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class CustomProgramInstruction implements ProgramLayoutInstruction {
  @override
  final List<int> instruction;

  @override
  final String name;

  const CustomProgramInstruction(this.instruction, this.name);

  static const CustomProgramInstruction getBalance =
      CustomProgramInstruction([5, 173, 180, 151, 243, 81, 233, 55], "get_balance");

  static const CustomProgramInstruction getBalanceByAddress =
  CustomProgramInstruction([154, 66, 243, 109, 199, 31, 182, 244], "get_balance_by_address");

  static const List<CustomProgramInstruction> values = [
    getBalance,
  ];

  static CustomProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.instruction == value);
    } on StateError {
      return null;
    }
  }

  @override
  String get programName => "CustomProgram";

  @override
  SolAddress get programAddress => throw UnimplementedError();
}
