// import 'package:tortvezu/moduls/networking.dart';
// import 'package:web_ffi/web_ffi.dart';
import 'package:flutter/material.dart';
import 'package:tortvezu/constants.dart';
import 'package:tortvezu/cards/reuseble_card.dart';
import 'package:tortvezu/moduls/data_modul_class.dart';
// import 'detail_product_screen.dart';
// import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
// import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:tortvezu/moduls/action_modul_class.dart';

class KatologScreen extends StatefulWidget{
  // KatologScreen({this.arrayJsonKatalog}); //2
  // final arrayJsonKatalog; //1
  @override
  _KatologScreen createState() => _KatologScreen();
}

class _KatologScreen extends State<KatologScreen>{

  int currentPage = 0;
  final List<ProductDataWidget> arrayName = [];
  OperatioOnKatalog operatioOnKatalog = OperatioOnKatalog();
  late ActualKatalog actualKatalogData;

  @override
  void initState() {
    super.initState();
    // arrayName.add(ProductDataWidget(1, 'https://shi-ku.ru/img/tortvezu/product/duna1_1.png', '"Лайм"', 'Вкуснейший торт с неповторимым вкусом лайм'));
   // arrayName.add(ProductDataWidget(2, 'https://shi-ku.ru/img/tortvezu/product/duna1_1.png', '"Клубника-Кокос"', 'Вкуснейший торт с неповторимым вкусом клубники'));
   // arrayName.add(ProductDataWidget(3, 'https://shi-ku.ru/img/tortvezu/product/duna1_1.png', '"Манго-Маракуйя"', 'Вкуснейший торт с неповторимым вкусом манго'));
   // arrayName.add(ProductDataWidget(4, 'https://shi-ku.ru/img/tortvezu/product/duna1_1.png', '"Лайм"', 'Вкуснейший торт с неповторимым вкусом лайм'));
    getActualKatologProduct();
  }


  void getActualKatologProduct () async {
   actualKatalogData = operatioOnKatalog.returnActualCatalog();
    }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }



  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final viewPadding = MediaQuery.of(context).viewPadding;
    // double barHeight;
    // double barHeightWithNotch = 67;
    // double arcHeightWithNotch = 67;

    void _onItemTapped(int index) {
       print('Нажата плашка нижнего бара $index');
       currentPage = index;
       ActionRouteButtomScreen(context, index);
      }
//TODO{меню нужно вынести в отдельный модуль}
      String _value = "";
      List <PopupItem> _list = [
        PopupItem(1,"Профиль"),
        PopupItem(2,"Заказы"),
        PopupItem(3,"Доставка"),
        PopupItem(4,"Четвертый элемент")
      ];

    // if (size.height > 700) {
    //   barHeight = 70;
    // } else {
    //   barHeight = size.height * 0.1;
    // }
    //
    // if (viewPadding.bottom > 0) {
    //   barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
    //   arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    // }

    return DefaultTabController(
      length: 5, //Кол-во элементов
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade100,
            centerTitle: true,
            //leading: Icon(Icons.person_outline),
            title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                  Text('ТОРТ', style: kLabeleB20Red),
                  Text('ВЕЗУ', style: kLabeleB20),
                  ]),
            bottom:  PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    labelColor: kTextColor1,
                    unselectedLabelColor: Color(0xFF3b3d5d),
                    indicatorColor: kBottomContainerColor,
                    tabs:  [
                      Tab(
                        child:  Text(actualKatalogData.KATALOG!.length >0 ? actualKatalogData.KATALOG![0].PRODUCT_GROUP! : 'группа 1'),
                      ),
                      Tab(
                        child: Text(actualKatalogData.KATALOG!.length >1 ? actualKatalogData.KATALOG![1].PRODUCT_GROUP! : 'группа 2'),
                      ),
                      Tab(
                        child:Text(actualKatalogData.KATALOG!.length >2 ? actualKatalogData.KATALOG![2].PRODUCT_GROUP! : 'группа 3'),
                      ),
                      Tab(
                        child:Text(actualKatalogData.KATALOG!.length >3 ? actualKatalogData.KATALOG![3].PRODUCT_GROUP! : 'группа 4'),
                      ),
                      Tab(
                        child:Text(actualKatalogData.KATALOG!.length >4 ? actualKatalogData.KATALOG![4].PRODUCT_GROUP! : 'группа 5'),
                      )
                    ]),
                preferredSize: Size.fromHeight(30.0)),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.home_outlined, color: Colors.white60),
                  onPressed: () {
                    // Navigator.pushReplacement(context, MaterialPageRoute(
                    //   builder: (context) => KatologScreen(),
                    // )
                    // );
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),

            actions: [
              PopupMenuButton(
                  color: kMainBackGroundColor,
                  elevation: 20,
                  icon: Icon(Icons.account_circle_outlined , color: kTextColor1,),
                  enabled: true,
                  onSelected: (result) {
                    setState(() {
                      print(result);
                      ActionRouteTopMenu(context, result as int);
                      //_value = value;
                    });
                  },
                  itemBuilder:(context) {
                    return _list.map((PopupItem choice) {
                      return PopupMenuItem(
                        value: choice.value,
                        child: Text(choice.name, style: kLabele15,),
                        //onTap: () =>  ActionRouteTopMenu(context, choice.value),
                      );
                    }).toList();
                  }
              )
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Center(
                  child:
                  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:
                    [
                      Expanded(
                          child: ScrollCardWidget(
                            arrayProduct: actualKatalogData.KATALOG![0],
                            numberGroup: 0,
                            widgetInTop: ScrollImageWidget(
                              imageName1: 'image/top_baner/tort_1.png',
                              imageName2: 'image/top_baner/tort_2.png',
                              imageName3: 'image/top_baner/tort_3.png',
                               // countImage: 3
                            ),
                            countChild: actualKatalogData.KATALOG![0].PRODUCT!.length,
                          )),
                    ],
                  )

                ),
              ),
              Container(
                child: Center(
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:
                      [
                        Expanded(
                            child: ScrollCardWidget(
                              arrayProduct: actualKatalogData.KATALOG![1],
                              numberGroup: 1,
                              widgetInTop: ScrollImageWidget(
                                imageName1: 'image/top_baner/tort_1.png',
                                imageName2: 'image/top_baner/tort_2.png',
                                imageName3: 'image/top_baner/tort_3.png',
                                // countImage: 3
                              ),
                              countChild: actualKatalogData.KATALOG![1].PRODUCT!.length,
                            )),
                      ],
                    )

                ),
              ),
              Container(
                child: const Center(
                  child: Text('Тарты и тарталетки',style: TextStyle(color: kTextColor1)),
                ),
              ),
              Container(
                child: const Center(
                  child: Text('Шоколадные конфеты',style: TextStyle(color: kTextColor1)),
                ),
              ),
              Container(
                child: const Center(
                  child: Text('Драже', style: TextStyle(color: kTextColor1)),
                ),
              ),
            ],
          ),
        //
 bottomNavigationBar: BottomNavigationBar(
   backgroundColor: kTextColor2,
   unselectedItemColor: Colors.grey,
   items: const <BottomNavigationBarItem>[
     BottomNavigationBarItem(
       icon: Icon(Icons.home_outlined),
       label: 'Каталог'
     ),
     BottomNavigationBarItem(
       icon: Icon(Icons.shopping_cart),
       label: 'Корзина'
     ),
     BottomNavigationBarItem(
       icon: Icon(Icons.chat),
       label: 'Лента'
     ),
   ],
   currentIndex: currentPage,
   selectedItemColor: kMainBackGroundColor,
   onTap: _onItemTapped,
 ),


 // ButtomTapWidget(
 // barHeight1: 80.0,
 // arcHeight1: 60.0,
 // itemTextOff1: 0,
 // itemTextOn1: 0,
 // numberPage: currentPage,
 // buttonPress: (index) {
 //  print('Page changed buttom: $index');
 // ActionRouteButtomScreen(context, index);
 //  },
 //  ),
      ),
    );
  }

}




