import 'package:flutter/material.dart';
import 'package:tortvezu/constants.dart';
import 'package:tortvezu/screens/katolog_screen.dart';
import 'katolog_screen.dart';
import 'package:tortvezu/moduls/action_modul_class.dart';
import 'package:tortvezu/moduls/data_modul_class.dart';


class DetailProductScreen extends StatefulWidget {
  DetailProductScreen({required this.numberGroup, required this.numberProuct}); //2
  late int numberProuct; //1
  late int numberGroup; //1

  @override
  _DetailProductScreen createState() => _DetailProductScreen();
}

class _DetailProductScreen extends State<DetailProductScreen> {
  int currentPage = 2;
  late ActualProductCatalog arrayProduct;
  OperatioOnKatalog operatioOnKatalog = OperatioOnKatalog();
  OperationOnCard operationOnCard = OperationOnCard();

  late ActualKatalog actualKatalogData;

   String? groupName;
   String? productName;
   String? imagePath;
   String? textProduct;
   String? countPorc;
   String? countShuger;
   String? countOnSclad;
   String? priceProduct;
   int?    idProduct;
   String? formName;

  // void _onItemTapped(int index) {
  //   print('Нажата плашка нижнего бара $index');
  //   currentPage = index;
  //   ActionRouteButtomScreen(context, index);
  // }


  @override
  void initState() {
    super.initState();
    getActualKatologProduct();
  }



  void getActualKatologProduct () async {
    actualKatalogData = operatioOnKatalog.returnActualCatalog();
    //[Обновление переменных в форме]
    groupName = actualKatalogData.KATALOG?[widget.numberGroup].PRODUCT_GROUP ?? 'no data';
    productName = actualKatalogData.KATALOG?[widget.numberGroup].PRODUCT?[widget.numberProuct].PRODUCT_NAME ?? 'no data';
    imagePath = actualKatalogData.KATALOG?[widget.numberGroup].PRODUCT?[widget.numberProuct].IMAGE_PATH ?? 'https://shi-ku.ru/img/tortvezu/product/duna1_1.png';
    textProduct = actualKatalogData.KATALOG?[widget.numberGroup].PRODUCT?[widget.numberProuct].TEXT_PRODUCT ?? '';
    countPorc = actualKatalogData.KATALOG?[widget.numberGroup].PRODUCT?[widget.numberProuct].COUNT_PORC.toString() ?? '';
    countShuger = actualKatalogData.KATALOG?[widget.numberGroup].PRODUCT?[widget.numberProuct].COUNT_SHUGER.toString() ?? '';
    countOnSclad = actualKatalogData.KATALOG?[widget.numberGroup].PRODUCT?[widget.numberProuct].COUNT_ON_SKLAD.toString() ?? '0';
    priceProduct = actualKatalogData.KATALOG?[widget.numberGroup].PRODUCT?[widget.numberProuct].PRICE_PRODUCT.toString() ?? '0';
    idProduct = actualKatalogData.KATALOG?[widget.numberGroup].PRODUCT?[widget.numberProuct].ID ?? 0;
    formName = actualKatalogData.KATALOG?[widget.numberGroup].PRODUCT?[widget.numberProuct].FORM_NAME.toString() ?? '0';
  }

  Icon iconsList (int cnt, Icon nameIcon) {
    return Icon(Icons.add);
  }

    @override
    Widget build(BuildContext context) {

      return Scaffold(
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


        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Expanded(child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5.0, right: 5, top: 40, bottom: 5),
                    height: 30.0,
                    child: Text(
                        '$groupName . $productName' , style: kLabele15),
                  ),

                  Container(height: 320.0,
                    margin: const EdgeInsets.only(left: 10.0, right: 10, top: 0, bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      // borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(5),
                      //     topRight: Radius.circular(5),
                      //     bottomLeft: Radius.circular(5),
                      //     bottomRight: Radius.circular(5)
                      // ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(kImageFolder+'$imagePath', fit: BoxFit.fill,)
                        ]
                    ),
                  ),
                   ],
              )),

            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Column(
                children: [
                  Row (
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: countOnSclad != '0' ? Colors.green.shade300 : Colors.deepOrangeAccent.shade200,
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        margin: const EdgeInsets.only(left: 20.0, right: 0, top: 0, bottom: 0),
                        child: Text(countOnSclad != '0' ? 'в наличии' : 'под заказ', style: TextStyle(
                            color: Colors.white
                        ),),
                      ),
                    ],
                  ),
                  Row (
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 0, top: 10, bottom: 0),
                        child: Text('$productName', style: kLabeleB15Red,),
                      )
                    ],
                  ),
                  Row (
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 0, top: 2, bottom: 0),
                        child: Text('форма: $formName', style: TextStyle(fontSize: 12.0, color: Colors.indigo),),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  Row (
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left:20.0, right: 10.0),
                          child: Text('$textProduct', maxLines: 4, overflow: TextOverflow.ellipsis, style: kLabele12),
                        )
                      )
                    ],
                  ),
                  const SizedBox(height: 15.0,),
                  Row (
                    children: [
                       Container(
                         padding: EdgeInsets.only(left:20.0, right: 10.0,  top:5),
                         child: Text('Кол-во порций: $countPorc', style: kLabele15,),
                      )
                    ],
                  ),
                  Row (
                    children: [
                      Container(
                      padding: EdgeInsets.only(left:20.0, right: 10.0, top:5),
                      child: Text('Сахар: $countShuger', style: kLabele15,),
                      )
                    ],
                  ),
                  Row (
                    children: [
                      Container(
                          padding: EdgeInsets.only(left:20.0, right: 10.0,  top:25),
                          child: Text('$priceProduct ₽/шт', style: kLabeleB20W,)
                      )
                    ],
                  ),


                  const SizedBox(height: 55.0,),
                  Container(height: 35.0,
                    margin: const EdgeInsets.only(left: 35.0, right: 35, top: 15, bottom: 0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: () {
                            operationOnCard.cardOperation(CardData(idProduct!, '$productName', '$textProduct', 1, int.parse(priceProduct!), 1, formName!),'+');
                            showDialog<String>( //todo{окно диалого нужно вынести в отдельный модуль}
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Заказ', style: TextStyle(fontSize: 15, color: Colors.green ),),
                                content: const Text('Продукт добавлен в заказ'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => ActionRouteButtomScreen(context, 1),
                                    child: const Text('В корзину'),
                                  ),
                                  TextButton(
                                    onPressed: () => ActionRouteButtomScreen(context, 0),
                                    child: const Text('Продолжить'),
                                  ),

                                ],
                              ),
                            );

                            },
                            child: const Text('В корзину', style: kLabele15,),
                          )
                        ]
                    ),
                  ),
                  ]
                  ),
                  ),

              ],
            ))


                     ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   backgroundColor: kTextColor2,
        //   unselectedItemColor: Colors.grey,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home_outlined),
        //       label: 'Каталог',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.shopping_cart),
        //       label: 'Корзина',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.chat),
        //       label: 'Чат',
        //     ),
        //   ],
        //   currentIndex: currentPage,
        //   selectedItemColor: kMainBackGroundColor,
        //   onTap: _onItemTapped,
        // ),
      );
  }

}