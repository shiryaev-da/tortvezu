import 'package:flutter/material.dart';
import 'package:tortvezu/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'katolog_screen.dart';
import 'package:tortvezu/moduls/networking.dart';
import 'package:tortvezu/moduls/data_modul_class.dart';
import 'package:tortvezu/moduls/action_modul_class.dart';
import 'package:tortvezu/screens/registration_form1_screen.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class StartScreen extends StatefulWidget{
  @override
  _StartScreen createState() => _StartScreen();
}

class _StartScreen extends State<StartScreen>{
  int heigth = 120;
  String UUID = '?';
  NetworkPost networkPost = NetworkPost();

  @override
  void initState() {
    super.initState();
    AuthUser();
    //GetActualKatalog();
  }


  //todo{Процедура аутентификации пользователся переходами на соответствующие формы}

  void AuthUser  () async  {
    //var duration = new Duration(seconds: 3);
    List<String?> deviceId = await getDeviceIdentifier();
    UUID =  deviceId[0]!;
    try {
      var vUserData = await postAuthUser('[{"phoneNumber":"9950010000","deviceId":"$UUID", "typeAction":1}]'); //; networkPost.postData(kServiceKatalogData, '{"id_user": 1}');
      UserData userData = UserData.fromJson(vUserData);
      userDataCash.add(userData);
      print ( userDataCash[0].id);
      userDataCash[0].id  > 0 ? GetActualKatalog() : registration();
    } on Exception catch(_) {
      print('Пользователь не идентифицирован');
      print(userDataCash.length);
      GetActualKatalog();
    }
  }

  void registration () {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => ReregistrationScreen1()
    )
    );
  }

  void GetActualKatalog  () async  {
    //var duration = new Duration(seconds: 3);
    var katalogData = await getKatologData('{"id_user": 1}');//; networkPost.postData(kServiceKatalogData, '{"id_user": 1}');
    print('Даные католога из сервиса');
    //print(katalogData);
    ActualKatalog actualProductCatalog = ActualKatalog.fromJson(katalogData);

    OperatioOnKatalog operatioOnKatalog = OperatioOnKatalog();
    operatioOnKatalog.refreshKatalogData(actualProductCatalog);

    print(operatioOnKatalog.returnActualCatalog());
    //print(actualProductCatalog.KATALOG?[0].PRODUCT?[0].PRODUCT_NAME);
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => KatologScreen()
    )
    );

  }
  void route(katalogData) {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => KatologScreen()
    )
    );
  }
  void routeReg () {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => ReregistrationScreen1()
    )
    );
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF0A0E21),
      //   title: const Text('SHEVckakes'),
      // ),
      body: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('ТОРТ', style: kLabeleB40Red),
                Text('ВЕЗУ', style: kLabeleB40),
              ]
            ),
            const SizedBox(height: 10.0),
            const Text('Елена Ширяева', style: kLabele15),
            const SizedBox(height: 20.0,),
               const SpinKitCircle (
               color: kBottomContainerColor,
               size: 30.0,
             ),
            //TextButton(onPressed: RedirectScreenNoData, child: Text('Далее'))
          ],
                ),);

  }

}

