import 'package:flutter/material.dart';
import 'package:tortvezu/constants.dart';
import 'package:tortvezu/moduls/networking.dart';
import 'package:tortvezu/moduls/data_modul_class.dart';
import 'package:tortvezu/moduls/action_modul_class.dart';

class ReregistrationScreen1 extends StatefulWidget {
  const ReregistrationScreen1({Key? key}) : super(key: key);

  @override
  State<ReregistrationScreen1> createState() => _ReregistrationScreen1State();
}

class _ReregistrationScreen1State extends State<ReregistrationScreen1> {

  final myControllerPH = TextEditingController();
  final myControllerCod = TextEditingController();

  Color colorText = kTextColor2;

  NetworkPost networkPost = NetworkPost();

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    myControllerPH.addListener(_updateDataOrder);
    myControllerCod.addListener(_updateDataOrder);
  }

  void tapField () {
     if (myControllerPH.text.length == 18) {
      print(myControllerPH.text.length);
      colorText = kTextColorGREENSEA;
     }
     else {
       colorText = kTextColor2;
     }
  }

  void _updateDataOrder() {
     print('Second text field: ${myControllerPH.text}');
     tapField;
  }

  void GetCallCode  () async  {
    //var duration = new Duration(seconds: 3);
    String p = '{"user":"dimashiryev", "pass":"tuzvyc-4Zywgu-syddub","to":"79950010000"}';
    print(p);
    var CodeData = await greenCallList(p);//; networkPost.postData(kServiceKatalogData, '{"id_user": 1}');
    print(CodeData);
    print('Даные католога из сервиса');
    GreenCall  greenCall = GreenCall.fromJson(CodeData);
    print(greenCall.code);
    //print(actualProductCatalog.KATALOG?[0].PRODUCT?[0].PRODUCT_NAME);
    // Navigator.pushReplacement(context, MaterialPageRoute(
    //     builder: (context) => KatologScreen()
    // )
    //);

  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          tapField();
        },
      child:  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        //leading: Icon(Icons.person_outline),
        title:
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('Регистрация', style: kLabeleB20),
            ]
        ),
        //Image.asset('image/logo_shev.png', height: 20,),

      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            const Text('Номер телефона', style: kLabele15),
            const SizedBox(height: 30.0,),
            SizedBox(height: 60.0,
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                child: TextField(
                  showCursor: true,
                  textAlign: TextAlign.center,
                  inputFormatters: [maskPhoneNumber],
                  controller: myControllerPH,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: colorText, fontSize: 30.0),
                  decoration: InputDecoration(
                      fillColor: Color(0xFFF2F2F2),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        borderSide: BorderSide(width: 0.0,color: Colors.black12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(width: 0.0, color: Colors.green.shade100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(width: 0.0,color: Colors.green),
                      ),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: '+7 (999) 123-12-12',
                      hintStyle: kLabele20Grey ,
                      suffixStyle: const TextStyle(color: Colors.green)),
                ),),),
             TextButton(
                 onPressed: ()  {
                    GetCallCode();
                 }, child: Text('Далее'))
          ],
        )
      ),
    );
  }
}
