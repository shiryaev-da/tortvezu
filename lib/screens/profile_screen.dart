import 'package:flutter/material.dart';
import 'package:tortvezu/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tortvezu/screens/katolog_screen.dart';
import 'package:tortvezu/moduls/data_modul_class.dart';

class FrofileScreen extends StatefulWidget {
  const FrofileScreen({Key? key}) : super(key: key);

  @override
  State<FrofileScreen> createState() => _FrofileScreenState();
}





class _FrofileScreenState extends State<FrofileScreen> {
  String uName = '';
  String phoneNumber = '';
  String email = '';
  int logUserData = 0;

  void initState() {
    super.initState();
    regreshUserData();
    //GetActualKatalog();
  }

 void  regreshUserData () {
    try {
      if (userDataCash.isNotEmpty) {
        uName = userDataCash[0].firstName;
        phoneNumber = userDataCash[0].phoneNumber;
        email = userDataCash[0].email;
        logUserData = userDataCash[0].id;
        print(logUserData);
      };
    } on Exception catch(_) {
      print('Инофрмация пользователя отсутствуе');
    }
 }

  @override
  Widget build(BuildContext context) {
    return logUserData == 0 ?

            Container(
            child: Text('Пользователь не зарегистрирован'),
          )

        :Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        height: 40.0,
        width: 40.0,
        child: FittedBox(
          child:  FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => KatologScreen()
              )
              );
            },
            backgroundColor: kMainBackGroundColor,
            child: Icon(Icons.arrow_back_ios ),
            highlightElevation: 10.0,
          ),
        ),
      ),
      backgroundColor: kMainBackGroundColor,
      body:  SafeArea(
         child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
            CircleAvatar(
              radius: 50.0,
              child: SvgPicture.asset('image/profile/profile_pic_no_face.svg'),
              backgroundColor: Colors.green[100],
              //backgroundImage:  SvgPicture('image/profile/profile_pic_no_face.svg') // AssetImage('image/profile/profile_pic_no_face.svg'),
            ),
            Text(
              uName,
              style: const TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 20.0,
                  color: kTextColor1,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
           const Text(
              'Кол-во бонусов: 500',
              style: TextStyle(
                  fontFamily: 'LuckiestGuy',
                  fontSize: 15.0,
                  color: kTextColor1,
                  letterSpacing: 2.5),
            ),
          const  SizedBox(height: 10.0,
              width: 150.0,
              child: Divider(
                color: Colors.white,
              ),
            ),
            Card(
              color: kMainBackGroundColor,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Center(
                child: ListTile(
                  leading: Icon(Icons.phone, color: kTextColor2),
                  title: Text(
                    phoneNumber,
                    style: const TextStyle(
                        color:  kTextColor1,
                        fontSize: 15.0,
                        fontFamily: 'LuckiestGuy'),
                  ),
                ),
              ),
            ),
            Card(
              color: kMainBackGroundColor,
              margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.email, color: kTextColor2),
                title: Text(
                  email,
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'LuckiestGuy',
                      color: kTextColor1,
                      letterSpacing: 2.0),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
