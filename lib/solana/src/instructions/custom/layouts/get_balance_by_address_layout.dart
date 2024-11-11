import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/custom/instruction/custom_program_instruction.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// 实现参考: SPLTokenBurnLayout
class GetBalanceByAddressLayout extends ProgramLayout {
  final SolAddress targetAccount;

  /// Constructs an SPLTokenBurnLayout instance.
  GetBalanceByAddressLayout({
    required this.targetAccount,
  });

  /// StructLayout structure for SPLTokenBurnLayout.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    SolanaLayoutUtils.publicKey("target_account"),
  ]);

  /// Gets the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final CustomProgramInstruction instruction = CustomProgramInstruction.getBalanceByAddress;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {"target_account": targetAccount};
  }
}
