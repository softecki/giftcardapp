import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class ApiCrypto {
  // Laravel .env values (must match exactly)
  static const _apiKey = 'E9A3F7B2C5D8A1E4F6B9C0D3A7E2F4B8';
  static const _apiIv = '4F7B2A9C1E6D3B8A';

  static final _fullKeyHash = sha256.convert(utf8.encode(_apiKey)).bytes;
  static final _fullIvHash = sha256.convert(utf8.encode(_apiIv)).bytes;

  static final Key key = Key(Uint8List.fromList(_fullKeyHash.sublist(0, 32)));
  static final IV iv = IV(Uint8List.fromList(_fullIvHash.sublist(0, 16)));

  /// Encrypts a request Map into a Base64 string
  static String encryptRequest(Map<String, dynamic> data) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final jsonStr = jsonEncode(data);
    final encrypted = encrypter.encrypt(jsonStr, iv: iv);
    return base64Encode(encrypted.bytes); // Match PHP base64_encode
  }

  /// Decrypts a Base64 response string into a Map
  static Map<String, dynamic> decryptResponse(String encrypted) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted =
    encrypter.decrypt(Encrypted(base64Decode(encrypted)), iv: iv);
    return jsonDecode(decrypted);
  }
}
