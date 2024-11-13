import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/solana/service_example/service_example.dart';
import 'package:on_chain/on_chain.dart';
import 'package:retry/retry.dart';

void main() async {
  // String walletKey = "";
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
  // String publicKeyHex = BytesUtils.toHexString(ownerPrivateKey.publicKey().toBytes());
  // List<int> publicKeyBytes = BytesUtils.fromHexString(publicKeyHex);
  // final pubKey = SolanaPublicKey.fromBytes(publicKeyBytes);
  // print(pubKey.toAddress().address);
  //
  // print(publicKeyHex);
  //
  // /// Derive public key from private key
  // SolAddress owner = ownerPrivateKey.publicKey().toAddress();

  String transaction = 'AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAQAIFtSYyW772UsKM7D7VZGUrnnI3LNIXdLhotvQqetEG5ywBUJMnirsWcmYbu0aIqEdNhrOZlZzHtLB0fj73conmlwLSAdPdbjqMGnJ7T8GvDIZeCrkzY5cnTdJglaxmEudUBMkCL79219714Y/Zl9kXLs6b7zswGGPZEpNj2iqsYwxIvhqGz8RhfdtjcuWsTcqxvwDtOGXs0PiUYNt0/PdeixHEZHqoi6gTHGD4GqGfJuN3LSDqrqxW1D/gU6lJjtL6U+GQBhElAzPc4jBeGVim/dXwwfc5Ply3nLTBFQPOw3UWO9nf7VjXmRzcktw4WtkBVQDTqR6HHs/zYiFPEFdMlRbisgc9eVamy7jB6L2rVPImQtt36HNxFXp/RiluJCJYnCYm1Is2XU/mqPrZV4QqWn44Ly2zBbjStal212jvP/zgknA1TbcmJw/Mz7TOzQCNVwaQvSq9pNfO3qqkIbahUmK2gevrgyJhJOFaINxuRUp8N40uGV20E0GOhr5nfd5fefK/MvY2p7wS7QMdU37O1nJ28Q5cDpF+6pfuCi1+ZYW8cjn/46924xn8ceUy3+7QJbcDZAdLVPsZ0LaxHu8ISMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMGRm/lIRcy/+ytunLDm+e8jOW7xfcSayxDmzpAAAAABHnVW/IxwG7udMVuzmgVB/2xst6j9I5RArHNola8E48FSlNamSkhBk0k6HFg2jh8fDW13bySu4HkH6hAQQVEjQbd9uHXZaGT2cvhRs7reawctIXtX1s3kTqM9YV+/wCpOriQP7c1yrHGfFmvSFft9hsK+DKlCnxZ4yGRng7IqbyMlyWPTiSJ8bs9ECkUjg2DC1oTmdr/EIQEjnvY2+n4WbQ/+if11/ZKdMCbHylYed5LCas238ndUUsyGqezjOXob69yl6wXwFs7pytC7jVUDwp6rcpRLqYNE9wrrrBotSQIDwAFAsBcFQAPAAkDBBcBAAAAAAAUBgABACQOEgEBDgIAAQwCAAAAQEIPAAAAAAASAQEBERQGAAQAKA4SAQEQRBITAAEHAgQkKBAQFRAjGSMWGAcNJSQXIxMSEicjDAgKECMiIyAfDQspJSEjExISJyMeBRAmEhIRExspKAscAhoGCQMdLsEgmzNB1pyBBAMAAAAmZAABJmQBAi8BAGQCA0BCDwAAAAAAcDIDAAAAAABkAAASAwEAAAEJAzKrSrrn+2iYMxFntJwzPIHbAF4krB+Y6yvXyy0atXWIBGtsYmQFZlJoX2rliVaWwcAWVtbrMPPhA+Jz1LBlO/zkjT8m9qnKXpRB1gSkoaOiAQO3WuorH/fdHo83uiPoBLOyZ0Yd0KOTeF6RtPiCQ8z6NQXOx83KxgHI';

  final result = SolanaTransaction.deserialize(base64.decoder.convert(transaction));

  print(result);

}

