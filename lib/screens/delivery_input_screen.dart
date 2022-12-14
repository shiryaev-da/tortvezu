import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tortvezu/constants.dart';
import 'package:tortvezu/cards/reuseble_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tortvezu/moduls/data_modul_class.dart';
import 'package:tortvezu/moduls/action_modul_class.dart';
import 'package:tortvezu/moduls/networking.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class DeliveryInputScreen extends StatefulWidget {
  const DeliveryInputScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryInputScreen> createState() => _DeliveryInputScreenState();
}

class _DeliveryInputScreenState extends State<DeliveryInputScreen> {

  NetworkPost networkPost = NetworkPost();
  int logicSelectDate = 0;
  final myControlleriO = TextEditingController();
  final myControllerphoneNumberGot = TextEditingController();
  final myControllerdeliveryDate = TextEditingController();
  final myControllerTimeFrom = TextEditingController();
  final myControllerTimeTo = TextEditingController();
  final myControllerTownName = TextEditingController();
  final myControllerAreaName = TextEditingController();
  final myControllerStreetName = TextEditingController();
  final myControllerHouseNumber = TextEditingController();
  final myControllerPartHouseNumber = TextEditingController();
  final myControllerDoorNumber = TextEditingController();
  final myControllerFloorNumber = TextEditingController();
  final myControllerDoorKey = TextEditingController();
  final myControllerCommentToDelivery = TextEditingController();
  final myControllerAppNumber = TextEditingController();

  OperationOnDelivery operationOnDelivery = OperationOnDelivery();
  final deliveryData = DeliveryData(tempNumberOrder, '?', '10:00', '18:00', '_phoneNumberGot', '_iO', '_townName', '_areaName', '_streetName', '_houseNumber', '_partHouseNumber', '_doorNumber', '_floorNumber', '_doorKey', '_commentToDelivery','0');

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myControlleriO.addListener(_updateDataOrder);
    myControllerphoneNumberGot.addListener(_updateDataOrder);
    myControllerdeliveryDate.addListener(_updateDataOrder);
    myControllerTimeFrom.addListener(_updateDataOrder);
    myControllerTimeTo.addListener(_updateDataOrder);
    myControllerTownName.addListener(_updateDataOrder);
    myControllerAreaName.addListener(_updateDataOrder);
    myControllerStreetName.addListener(_updateDataOrder);
    myControllerHouseNumber.addListener(_updateDataOrder);
    myControllerPartHouseNumber.addListener(_updateDataOrder);
    myControllerDoorNumber.addListener(_updateDataOrder);
    myControllerFloorNumber.addListener(_updateDataOrder);
    myControllerDoorKey.addListener(_updateDataOrder);
    myControllerCommentToDelivery.addListener(_updateDataOrder);
    myControllerAppNumber.addListener(_updateDataOrder);
  }

  Future <void> InsertDeliveryData  () async  {
    print (jsonEncode(dataDelivery));
    var arrayDataAnswers = await  networkPost.postData(kServiceInsertDeliveryData , jsonEncode(dataDelivery));
      AnswersCartData answersCartData = AnswersCartData.fromJson(arrayDataAnswers);
   // print(answersCartData.numberOrder!);
    tempNumberOrder = answersCartData.numberOrder!;
    print('?????????????????? ?? ???????????????? ?????????????? ??????????????????. ?????????? ???????????? $tempNumberOrder');

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myControlleriO.dispose();
    myControllerphoneNumberGot.dispose();
    myControllerdeliveryDate.dispose();
    myControllerTimeFrom.dispose();
    myControllerTimeTo.dispose();
    myControllerTownName.dispose();
    myControllerAreaName.dispose();
    myControllerStreetName.dispose();
    myControllerHouseNumber.dispose();
    myControllerPartHouseNumber.dispose();
    myControllerDoorNumber.dispose();
    myControllerFloorNumber.dispose();
    myControllerDoorKey.dispose();
    myControllerCommentToDelivery.dispose();
    myControllerAppNumber.dispose();
    super.dispose();
  }

  void _updateDataOrder() {
    print('Second text field: ${myControlleriO.text}');
    deliveryData.iO = myControlleriO.text; //[?????? ????????????????????, ??????????????????????]

   // print(dataDelivery[0].iO);
    deliveryData.phoneNumberGot = myControllerphoneNumberGot.text;      //[?????????? ???????????????? ????????????????????]

    deliveryData.idOrder = tempNumberOrder;               //[?????????? ???????????? ???? ?????????????????? ???????????? ]
    deliveryData.deliveryDate = myControllerdeliveryDate.text; //[???????? ????????????????]
    //
    deliveryData.timeFrom = myControllerTimeFrom.text;           //[???????? ????????????????]
    deliveryData.timeTo = myControllerTimeTo.text;             //[???????? ????????????????]
    //
    deliveryData.townName = myControllerTownName.text;           //[???????????????????????? ?????????????????????? ????????????]
    deliveryData.areaName = myControllerAreaName.text;           //[???????????????????????? ??????????????]
    deliveryData.streetName = myControllerStreetName.text;         //[???????????????????????? ??????????, ??????????????????, ???????????????? ?? ??.??.]
    deliveryData.houseNumber = myControllerHouseNumber.text;        //[?????????? ????????]
    deliveryData.appNumber = myControllerAppNumber.text;        //[?????????? ????????]
    deliveryData.partHouseNumber = '0';    //[?????????? ????????, ??????????????]
    deliveryData.doorNumber = myControllerDoorNumber.text;         //[?????????? ????????????????]
    deliveryData.floorNumber = myControllerFloorNumber.text;        //[????????]
    deliveryData.doorKey = myControllerDoorKey.text;            //[??????????????]
    deliveryData.commentToDelivery = myControllerCommentToDelivery.text;  //?????????????????????? ?????????????? ????????????????
    operationOnDelivery.updateDeliveryData(deliveryData);
  }

  @override
  Widget build(BuildContext context) {

    //myControllerdeliveryDate.text = DateFormat('dd.MM.yyyy').format(DateTime.now());
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          /* light theme settings */
        ),
        darkTheme: ThemeData(
          brightness: Brightness.light,
          /* dark theme settings */
        ),
         localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ru', ''), // English, no country code
          //Locale('es', ''), // Spanish, no country code
        ],

        home: Scaffold(

      backgroundColor: kMainBackGroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: kMainBackGroundColor,
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('????????????????', style: kLabeleB15Red,),
              titlePadding: EdgeInsetsDirectional.all(5.0),
              background: SvgPicture.asset('image/profile/delivery_truck.svg'),
            ),
          ),
          SliverList( // ???????????????????? ?? ????????????????????
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: kMainBackGroundColor,
                  height: 150.0,
                  child:  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('????????', style: kLabeleB15Red,),
                      ),
                      Padding(
                            padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                            child: Text('?????????? ???????????????? ???????????????????? ????????????', style: kLabele12,),
                            ),
                      SizedBox(height: 40.0,
                            child: Padding(
                            padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                            child: TextField(
                              inputFormatters: [maskPhoneNumber],
                              controller: myControllerphoneNumberGot,
                                  keyboardType: TextInputType.number,
                                    style: kTextBox14,
                              decoration: InputDecoration(
                          fillColor: Color(0xFFF2F2F2),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(width: 0.5,color: Colors.black12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(width: 0.5, color: Colors.green.shade100),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(width: 0.5,color: Colors.green),
                          ),
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                                 hintText: '+7 (999) 123-12-12',
                                  hintStyle: kLabele12Grey ,
                          suffixStyle: const TextStyle(color: Colors.green)),
                        ),),),
                      Padding(
                            padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                            child: Text('?????? ????????????????????', style: kLabele12, ),
                            ),
                      SizedBox(height: 40.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: myControlleriO,
                            style: kTextBox14,
                            decoration: InputDecoration(
                                fillColor: Color(0xFFF2F2F2),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                  borderSide: BorderSide(width: 0.5,color: Colors.black12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                  borderSide: BorderSide(width: 0.5, color: Colors.green.shade100),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                  borderSide: BorderSide(width: 0.5,color: Colors.green),
                                ),
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.teal)),
                                hintText: '??????????',
                                hintStyle: kLabele12Grey ,
                                suffixStyle: const TextStyle(color: Colors.green)),
                          ),),),
                  ],),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList( // ???????????????????? ?? ????????????????????
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: kMainBackGroundColor,
                  height: 210.0,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
                        child: Text('??????????', style: kLabeleB15Red,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('???????? ????????????????', style: kLabele12,),
                      ),
                      SizedBox(height: 40.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  locale: const Locale("ru","RU"),
                                  context: context, initialDate: logicSelectDate == 0 ? DateTime.now() : DateFormat('dd.MM.yyyy').parse(myControllerdeliveryDate.text), //actualKatalogData.KATALOG!.length >4 ? actualKatalogData.KATALOG![4].PRODUCT_GROUP! : '???????????? 5'
                                  firstDate: DateTime(2021), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2030),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: kTextColorEMERALD, // <-- SEE HERE
                                          onPrimary: Colors.white, // <-- SEE HERE
                                          onSurface: kTextColorGREENSEA, // <-- SEE HERE
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary: kTextColorBELIZEHOLE, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  }

                              );
                              if(pickedDate != null ){
                                //print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate = DateFormat('dd.MM.yyyy').format(pickedDate);
                                print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  myControllerdeliveryDate.text = formattedDate; //set output date to TextField value.
                                  logicSelectDate=1;
                                  print('Format controller ${ myControllerdeliveryDate.text.substring(0,10)}');
                                  print( DateFormat('dd.MM.yyyy').format(DateTime.now()).toString().substring(0,10));
                                  //print(DateFormat('dd.MM.yyyy').parse(DateTime.now().toString()));
                                });
                              }else{
                                print("???????? ???? ??????????????");
                                logicSelectDate=0;
                              }
                            },
                            //inputFormatters: [maskDate],
                            controller: myControllerdeliveryDate,
                            keyboardType: TextInputType.number,
                            style: kTextBox14,
                            decoration: textFieldInput('01.12.2022', kLabele12Grey),
                          ),),),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('?????????? ??:', style: kLabele12, ),
                      ),
                      SizedBox(height: 40.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            inputFormatters: [maskHouarMinute],
                            controller: myControllerTimeFrom,
                            keyboardType: TextInputType.number,
                            style: kTextBox14,
                            decoration: textFieldInput('12:00', kLabele12Grey),
                          ),),),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('?????????? ????:', style: kLabele12, ),
                      ),
                      SizedBox(height: 40.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            inputFormatters: [maskHouarMinute],
                            controller: myControllerTimeTo,
                            keyboardType: TextInputType.number,
                            style: kTextBox14,
                            decoration: textFieldInput('13:30', kLabele12Grey),
                          ),),),
                    ],),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList( // ???????????????????? ?? ????????????????????
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: kMainBackGroundColor,
                  height: 550.0,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
                        child: Text('????????', style: kLabeleB15Red,),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('??????????', style: kLabele12,),
                      ),
                      SizedBox(height: 40.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            controller: myControllerTownName,
                            textCapitalization: TextCapitalization.sentences,
                            //keyboardType: TextInputType.number,
                            style: kTextBox14,
                            decoration: textFieldInput('??????????????????????', kLabele12Grey),
                          ),),),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('??????????', style: kLabele12, ),
                      ),
                      SizedBox(height: 40.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: myControllerStreetName,
                            style: kTextBox14,
                            decoration: textFieldInput('????????????', kLabele12Grey),
                          ),),),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('?????????? ????????', style: kLabele12, ),
                      ),
                      SizedBox(height: 40.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            controller: myControllerHouseNumber,
                            style:  kTextBox14,
                            decoration: textFieldInput('123', kLabele12Grey),
                          ),),),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('?????????? ????????????????', style: kLabele12, ),
                      ),
                      SizedBox(height: 40.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            controller: myControllerAppNumber,
                            style:  kTextBox14,
                            decoration: textFieldInput('55', kLabele12Grey),
                          ),),),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('??????????????', style: kLabele12, ),
                      ),
                      SizedBox(height: 40.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            controller: myControllerDoorNumber,
                            style: kTextBox14,
                            decoration: textFieldInput('2', kLabele12Grey),
                          ),),),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('????????', style: kLabele12, ),
                      ),
                      SizedBox(height: 40.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            controller: myControllerFloorNumber,
                            style: kTextBox14,
                            decoration: textFieldInput('11', kLabele12Grey),
                          ),),),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('??????????????', style: kLabele12, ),
                      ),
                      SizedBox(height: 40.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            controller: myControllerDoorKey,
                            style: kTextBox14,
                            decoration: textFieldInput('#123#', kLabele12Grey),
                          ),),),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                        child: Text('?????????????????????? ?????? ??????????????', style: kLabele12, ),
                      ),
                      SizedBox(height: 80.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: myControllerCommentToDelivery,
                            style: kTextBox14,
                            decoration: textFieldInput('???????????????????? ?????? ??????????????', kLabele12Grey),
                          ),),),
                    ],),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList( // ???????????????????? ?? ????????????????????
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  //color: kMainBackGroundColor,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  height: 50.0,
                  child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: TextButton(onPressed: () async {{
                            //todo{ 1. ???????????????? ???????????? ?????????????????? ???????????????????? ????????????. 2. ???????????? ???????????????? ???? ???????????? ???????????????????? ?? ???????????? ?? ?????????????????? ???????????????????? ?? ????????????????}
                            //todo{?????????????? ?????????????? await}
                            await InsertDeliveryData();
                            showDialog<String>( //todo{???????? ?????????????? ?????????? ?????????????? ?? ?????????????????? ????????????}
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title:  Text('?????????? ????????????: $tempNumberOrder', style: TextStyle(fontSize: 15, color: Colors.green ),),
                                content:  const Text('?????????? ?????????????? ??????????????????????!\n\n?? ?????????????????? ?????????? ?? ???????? ???????????????? ???????????????? ?????? ?????????????????? ?????????????? ????????????.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>  ActionRouteButtomScreen(context, 0) ,
                                    child: const Text('????'),
                                  )
                                ],
                              ),
                            );

                          };},
                              child:  Text('???????????????? ??????????', style: kLabele15,)

                          ),
                        ),
                      ]
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverAppBar(
            backgroundColor: kMainBackGroundColor,
            pinned: true,
            expandedHeight: 40.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('????????????????', style: kLabeleB15Red,),
              titlePadding: EdgeInsetsDirectional.all(1.0),
              background: SvgPicture.asset('image/profile/delivery_truck.svg'),
            ),
          ),
        ],
      )

        )
    );
  }
}
