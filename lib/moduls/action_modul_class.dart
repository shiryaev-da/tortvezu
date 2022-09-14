import 'package:flutter/material.dart';
import 'package:tortvezu/screens/katolog_screen.dart';
import 'package:tortvezu/screens/detail_product_screen.dart';
import 'package:tortvezu/screens/cart_screen.dart';
import 'package:tortvezu/screens/post_screen.dart';
import 'package:tortvezu/moduls/networking.dart';
import 'package:tortvezu/constants.dart';
import 'package:tortvezu/screens/profile_screen.dart';
import 'package:tortvezu/screens/order_list_screen.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:tortvezu/screens/delivery_input_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tortvezu/moduls/data_modul_class.dart';
import 'package:crypto/crypto.dart';
import 'package:gainer_crypto/gainer_crypto.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:cryptography/cryptography.dart' as cryptography;


//import 'package:encrypt/encrypt.dart';
//Определение UUID устройства


Future <List<String>> getDeviceIdentifier() async {
  String deviceIdentifier = "unknown";
  String namePlatform = "unknown";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceIdentifier = androidInfo.androidId!;
    namePlatform = androidInfo.version.baseOS!;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceIdentifier = iosInfo.identifierForVendor!;
    namePlatform = iosInfo.name!;
  } else if (kIsWeb) {
    // The web doesnt have a device UID, so use a combination fingerprint as an example
    WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
    deviceIdentifier = webInfo.vendor! + webInfo.userAgent! + webInfo.hardwareConcurrency.toString();
    namePlatform = 'Web';
  } else if (Platform.isLinux) {
    LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
    deviceIdentifier = linuxInfo.machineId!;
    namePlatform = linuxInfo.version!;
  }
  return [deviceIdentifier, namePlatform];
}




//Событие перехода между экранами в нижнем баре
void ActionRouteButtomScreen (BuildContext context ,int numberscreen) async {
  switch (numberscreen) {
    case 0:
      Navigator.pushReplacement(context,MaterialPageRoute(
          builder: (context) => KatologScreen()
      ),
          // PageRouteBuilder(
          //   pageBuilder: (context, animation1, animation2) => ScrollScreen(),
          //   transitionDuration: Duration.zero,
          //   reverseTransitionDuration: Duration.zero,
          // ),
      );
      break;
    case 1:
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) =>  CartScreen()
      ),
      );
      break;
    case 2:
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => PostScreen()
      )
      );
      break;
    case 3:
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => DeliveryInputScreen()
      )
      );
      break;
  }
}

void ActionRouteTopMenu (BuildContext context ,int numberscreen) async {
  switch (numberscreen) {
    case 1:
      Navigator.pushReplacement(context,MaterialPageRoute(
          builder: (context) => FrofileScreen()
      ),
        // PageRouteBuilder(
        //   pageBuilder: (context, animation1, animation2) => ScrollScreen(),
        //   transitionDuration: Duration.zero,
        //   reverseTransitionDuration: Duration.zero,
        // ),
      );
      break;
    case 2: ///Переход на экран с историей заказов
      OperatioOnOrderListHistory operatioOnOrderListHistory =OperatioOnOrderListHistory();
      await operatioOnOrderListHistory.getOrderListHistory();
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) =>  OrederListScreen()
      ),
      );
      break;
    case 3:
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => DeliveryInputScreen()
      )
      );
      break;
  }
}


// Сервисы с фикс параметрами
//Актуальный католог пользователя
Future<dynamic> getKatologData (String jsonData) async {
  NetworkPost networkPost = NetworkPost();
  var DataKatolog = await networkPost.postData(kServiceKatalogData, jsonData);
  return DataKatolog;
}

//Аутентификация пользователя. при удачной аутентификации возвращается информация по пользователю
Future<dynamic> postAuthUser (String jsonData) async {
  NetworkPost networkPost = NetworkPost();
  var DataUser = await networkPost.postData(kServiceAuthUser, jsonData);
  return DataUser;
}

//Сервис отправки информации по доставке
Future<dynamic> postDeliveryData (String jsonData) async {
  NetworkPost networkPost = NetworkPost();
  var DataDelivery = await networkPost.postData(kServiceInsertDeliveryData, jsonData);
  return DataDelivery;
}


//Сервис получения информации по истории заказов и их статусов
Future<dynamic> postOrderList (String jsonData) async {
  NetworkPost networkPost = NetworkPost();
  var OrderList = await networkPost.postData(kServiceOrderHistoryList, jsonData);
  return OrderList;
}

//Сервис подтверждения номера телефона
Future<dynamic> greenCallList (String jsonData) async {
  NetworkPost networkPost = NetworkPost();
  var CallData = await networkPost.postData(greenUrl, jsonData);
  print(greenUrl);
  print(CallData);
  return CallData;
}

//
//  hashShaDes (String vType, String vKey, String vText )  {
//   var key = utf8.encode(vKey);
//   var bytes = utf8.encode(vText);
//   var hmacMd5 = Hmac(md5, key); // HMAC-SHA256
//   var digest = hmacMd5.convert(bytes);
//   print("HMAC digest as bytes: ${digest.bytes}");
//   print("HMAC digest as hex string: $digest");
//   return digest;
// }

// hashCrypto (/*String vType, String vKey, String vText*/ )  {
//   const inputText = '79950010000';
//
//   // Make a key of Type GRKey
//   GRKey key = grKeyFromUtf8(cryptoKey);
//   String encrypted = grEncrypt64AES(input: inputText, key: key);
//   String decrypted = grDecrypt64AES(inputBase64: encrypted, key: key);
//   print(key.length);
//
//   encrypted = grEncrypt64AES(
//       input: inputText,
//       key: key,
//      //  iv: iv,
//       mode: GRAESMode.cbc,
//       padding: GRPadding.pkcs7,
//       repeat: 0);
//   decrypted = grDecrypt64AES(
//       //inputBase64: encrypted,
//       inputBase64: encrypted,
//       key: key,
//      // iv: iv,
//       mode: GRAESMode.cbc,
//       padding: GRPadding.pkcs7,
//       repeat: 0);
//
//   print(encrypted);
//   print(decrypted);
//
//  // print(grIVFromLength(16));
//  print(base64.encode(utf8.encode('79950010000')));
//  print(base64.decode('U0hJUllBRVYgRE1JVFJZ'));
//   print(utf8.decode(base64.decode('U0hJUllBRVYgRE1JVFJZ')));
// }
//
//
// hashCrypto2 (/*String vType, String vKey, String vText*/ )  {
//   final plainText = '79950010000';
//   final key = encrypt.Key.fromUtf8('my 32 length key...............1');
//   final iv = encrypt.IV.fromLength(16);
//
//   final encrypter = encrypt.Encrypter(encrypt.AES(key));
//
//   final encrypted = encrypter.encrypt(plainText, iv: iv);
//   final decrypted = encrypter.decrypt(encrypted, iv: iv);
//
//   print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
//   print(encrypted.base64);
// }
//
// Future<void> main1() async {
//   final message = '123123123123';
//
//   // AES-CBC with 128 bit keys and HMAC-SHA256 authentication.
//   final algorithm = cryptography.AesCbc.with256bits(
//     macAlgorithm: cryptography.Hmac.sha256(),
//   );
//   final secretKey = await algorithm.newSecretKey();
//   final nonce = algorithm.newNonce();
//
//   // Encrypt
//   final secretBox = await algorithm.encrypt(
//     message,
//     secretKey: secretKey,
//   );
//   print('Nonce: ${secretBox.nonce}');
//   print('Ciphertext: ${secretBox.cipherText}');
//   print('MAC: ${secretBox.mac.bytes}');
//
//   // Decrypt
//   final clearText = await algorithm.encrypt(
//     secretBox,
//     secretKey: secretKey,
//   );
//   print('Cleartext: $clearText');
// }
