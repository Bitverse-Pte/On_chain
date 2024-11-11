import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// 计算 8 字节指令标识符
Uint8List getInstructionIdentifier(String instructionName) {
  // 计算指令名称的 SHA-256 哈希值
  var bytes = utf8.encode(instructionName);
  var digest = sha256.convert(bytes);

  // 返回前 8 字节
  return Uint8List.fromList(digest.bytes.sublist(0, 8));
}

void main() {
  ///此处需要加上global这个namespace, 其实可以通过IDL获取到
  String instructionName = "global:get_balance_by_address"; // 指令名称
  Uint8List instructionId = getInstructionIdentifier(instructionName);

  print(instructionId); // 打印 8 字节指令标识符
  print(instructionId.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join()); // 打印十六进制格式
}