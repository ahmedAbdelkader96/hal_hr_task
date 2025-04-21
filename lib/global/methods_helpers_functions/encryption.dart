import 'package:encrypt/encrypt.dart' as enc;
import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task/global/methods_helpers_functions/constants.dart';

class EncryptionUtils {
  static IV iv = IV.fromLength(
    16,
  ); // Consider generating a new IV for each encryption
  static enc.Key key = enc.Key.fromBase64(Constants.encKey);
  static Encrypter encrypter = Encrypter(AES(key));

  static String encryptAES(String text) {
    final iv = IV.fromLength(16);
    final encrypted = encrypter.encrypt(text, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  static String decryptAES(String encrypted) {
    final parts = encrypted.split(':');
    final iv = IV.fromBase64(parts[0]);
    final encryptedText = parts[1];

    // Decrypt using the extracted IV
    return encrypter.decrypt64(encryptedText, iv: iv);
  }
}
