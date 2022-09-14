import 'dart:convert';

//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:tortvezu/constants.dart';
import 'package:tortvezu/moduls/networking.dart';
import 'package:tortvezu/cards/reuseble_card.dart';
import 'package:tortvezu/moduls/data_modul_class.dart';
import 'package:tortvezu/moduls/action_modul_class.dart';
import 'package:tortvezu/screens/katolog_screen.dart';
//import 'package:tortvezu/screens/order_list_screen.dart';



class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}



class _CartScreenState extends State<CartScreen> {
  NetworkPost networkPost = NetworkPost();

  List<CardData> arrayName = [];
  List<AnswersCartData> arrayCartAnswers = [];
  OperationOnCard operationOnCard = OperationOnCard();
  int  currentPage = 1;
  int numberOrderReturn = 0;


  void _onItemTapped(int index) {
    print('Нажата плашка нижнего бара $index');
    currentPage = index;
    ActionRouteButtomScreen(context, index);
  }
  //operationOnCard.CardAdd(CardData(3, 'Манго-Маракуйя', 'Вкуснейший торт с неповторимым вкусом клубники', 1, 3000));


  @override
  void initState() {
    super.initState();
    //OperationOnCard operationOnCard = OperationOnCard();
    // arrayName.add(CardData(1, 'Лайм', 'Вкуснейший торт с неповторимым вкусом лайм', 1, 1200));
    // arrayName.add(CardData(2, 'Клубника-Кокос', 'Вкуснейший торт с неповторимым вкусом клубники', 2, 2500));
    // arrayName.add(CardData(3, 'Манго-Маракуйя', 'Вкуснейший торт с неповторимым вкусом клубники', 1, 3000));
    //operationOnCard.CardAdd(CardData(3, 'Манго-Маракуйя', 'Вкуснейший торт с неповторимым вкусом клубники', 1, 3000,1));
    arrayName = operationOnCard.returnCardArray();
  }

  Future <void> InsertOrder  () async  {
    var arrayCartAnswers = await  networkPost.postData(kServiceInsertOrder , jsonEncode(arrayName));
    AnswersCartData answersCartData = AnswersCartData.fromJson(arrayCartAnswers);

    //todo{сделать нормальную процедуру очистки корзины}
    operationOnCard.cardOperation(CardData(1, '_nameProduct', '_propertyTextProduct', 1, 1, 1, '_nameForm' ), '0');

    numberOrderReturn = answersCartData.numberOrder!;
    tempNumberOrder = 0;
    tempNumberOrder = numberOrderReturn;
    print('Номер заказа $numberOrderReturn');



    //todo{сообщение, что заказ принят. номер заказа. С вами свяжется менеджерт для уточнения деталей задаказа.}


  }



  // void _onItemTapped() {
  //
  //    arrayName =  operationOnCard.returnCardArray();
  //    print(arrayName.length);
  //
  // }

  void refresh(dynamic childValue) {
    setState(() {
      print('выполнена родительская функция из детской');
    });
  }

refreshWidget() {
    setState(() {
      arrayName =  operationOnCard.returnCardArray();
      print('Обновление формы 1');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => KatologScreen(),
                )
                );
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: const [
          Padding(
            padding:  EdgeInsets.only(right: 10.0),
            child: Icon(Icons.person_outline, color: kTextColor1),
          ),
        ],
      ),
      body:  cardDataCash.isEmpty ?  const NoCardData() :
      Container(
        child: Center(
            child:
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children:
              [
                Expanded(
                      child: CardCardWidget(
                      arrayProduct: arrayName,
                      countChild: arrayName.length,
                      refreshWidget: refreshWidget,
                    ),
                ),
                IntrinsicHeight(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(
                              children: [
                                Container(height: 50.0,
                              margin: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                              ),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:   [
                                          Text(operationOnCard.totalPriceCard().toString() + ' ₽' , style: kLabele15), // Общая сумма заказа
                                        ]
                                    ),
                                   ),
                                Container(height: 10.0, color: Colors.white),
                              ]),
                        ),
                        Expanded(child: Column(
                            children: [
                              Container(height: 50.0,
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                      TextButton(onPressed: () async {{
                                        //todo{ 1. добавить диалог уточнения завершения заказа. 2. сервис отправки на сервер информации о заказе и получения информации о принятии}
                                        //todo{сделать функцию await}
                                        await InsertOrder();
                                        showDialog<String>( //todo{окно диалого нужно вынести в отдельный модуль}
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title:  Text('Номер заказа: $numberOrderReturn', style: TextStyle(fontSize: 15, color: Colors.green ),),
                                            content:  const Text('Заказ успешно сформирован! Осталось заполнить информацию по доставке.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>  ActionRouteButtomScreen(context, 3),
                                                child: const Text('Продолжить'),
                                              )
                                            ],
                                          ),
                                        );
                                        jsonEncode(arrayName);
                                        print(jsonEncode(arrayName));
                                      };},
                                           child:  Text('Оформить заказ', style: kLabele15,)

                                          )
                                      ]
                                  ),
                                  ),
                              Container(height: 10.0, color: Colors.white),
                            ]),
                        ),
        ]),
                )
              ],
            )

        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kTextColor2,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Лента',
          ),
        ],
        currentIndex: currentPage,
        selectedItemColor: kMainBackGroundColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
