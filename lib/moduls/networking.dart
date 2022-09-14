import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    http.Response respons =  await http.get(Uri.parse(url));
    if (respons.statusCode == 200) {
      String data = respons.body;
      // print(data);
      var decodeData = jsonDecode(data);
      return decodeData;
    } else {
      print(respons.statusCode);
    }
  }
}

class NetworkPost {
  Future postData(String serviceName, String postJson) async {
    http.Response respons =  await http.post(Uri.parse(serviceName),
      body: postJson,
    );
    if (respons.statusCode == 200) {
      String data = respons.body;
      print('Информация на сервер отравлена и получена успешно');
      print (postJson);
      var decodeData = jsonDecode(data);
      return decodeData;
    } else {
      print(respons.statusCode);
    }
  }
}



