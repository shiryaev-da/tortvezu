import 'package:flutter/material.dart';

import 'package:tortvezu/constants.dart';
import 'package:tortvezu/screens/katolog_screen.dart';
import 'package:tortvezu/cards/reuseble_card.dart';
import 'package:tortvezu/moduls/data_modul_class.dart';
import 'package:tortvezu/moduls/action_modul_class.dart';

class OrederListScreen extends StatefulWidget {
  const OrederListScreen({Key? key}) : super(key: key);

  @override
  State<OrederListScreen> createState() => _OrederListScreenState();
}






class _OrederListScreenState extends State<OrederListScreen> {

  List<OrderData> arrayName = [OrderData(1, 'STATUS_NAME','DATE_ORDER', 123, [OrderProduct(1, '12',2,12, 12)] ,[OrderDelivery('','','','','','','','','','','','')] )];
  OperatioOnOrderListHistory operatioOnOrderListHistory = OperatioOnOrderListHistory();


  @override
  void initState() {
    super.initState();
    refreshWidget();
  }

  refreshWidget() {
    setState(() {
      arrayName = operatioOnOrderListHistory.returnOrderListHistory();
      print('Обновление формы 1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(


        home:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade100,
            centerTitle: true,
            //leading: Icon(Icons.person_outline),
            title:
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('ТОРТ', style: kLabeleB20Red),
                  Text('ВЕЗУ', style: kLabeleB20),
                ]
            ),
            //Image.asset('image/logo_shev.png', height: 20,),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: kTextColor1,),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => KatologScreen(),)
                    );
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.person_outline, color: kTextColor1),
              ),
            ],
          ),
          body: arrayName[0].ORDER_ID == 1 ? const NoHistoryOrder() :
          Container(
            child: Center(
                child:
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:
                  [
                     Expanded(
                        child: ScrollCardOrderHistory(
                            arrayOrder: arrayName
                       ),
                      ),

                  ],
                )

            ),
          ),

        ),
    );
  }
}


