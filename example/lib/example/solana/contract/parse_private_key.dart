import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/solana/service_example/service_example.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
  String walletKey = "";
  // String walletKey = "e6292218996b000e47430408ac8ba0c35c02a9d0db5342562c2d2ef7d56dfe3fc5cbe7a1816e33a027dbdf7271cfbae3fcf31f713975429006e84a127ce9d8cb";

  final data = Base58Decoder.decode(walletKey);
  final privateKey = SolanaPrivateKey.fromBytes(data);
  print(privateKey);

  // String walletKey = "gasp become thing view slow uncover derive private media bounce lunch network";
  //
  // Mnemonic walletMnemonic = Mnemonic.fromString(walletKey);
  //
  // List<int> seed = Bip39SeedGenerator(walletMnemonic).generate();
  //
  // Bip32Slip10Ed25519 hdWallet = Bip32Slip10Ed25519.fromSeed(seed);
  //
  // final hdWalletDerivePath = hdWallet.derivePath("m/44'/501'/0'/0'");
  //
  // /// Derive private key from seed
  // final ownerPrivateKey = SolanaPrivateKey.fromSeed(hdWalletDerivePath.privateKey.raw);
  //
  // /// Derive public key from private key
  // SolAddress owner = ownerPrivateKey.publicKey().toAddress();
  //
  // print(owner.address);
}
