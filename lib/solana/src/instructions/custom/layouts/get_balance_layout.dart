import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/custom/instruction/custom_program_instruction.dart';

/// 实现参考: SPLTokenBurnLayout
class GetBalanceLayout extends ProgramLayout {
  /// Constructs an SPLTokenBurnLayout instance.
  GetBalanceLayout();

  /// StructLayout structure for SPLTokenBurnLayout.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
  ]);

  /// Gets the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final CustomProgramInstruction instruction = CustomProgramInstruction.getBalance;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
