import 'package:tortvezu/screens/detail_product_screen.dart';
import 'package:web_ffi/web_ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tortvezu/constants.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:tortvezu/moduls/data_modul_class.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Карточка продукта в катологе

class ReusebleCardProduct extends StatelessWidget {
  OperationOnCard operationOnCard = OperationOnCard();
  ReusebleCardProduct({required this.colour, required this.onPress, required this.productName, required this.nameImage, required this.propertyTextProduct,
  required this.priceProduct, required this.idProduct, required this.countPorc, required this.formName
  });

  final Color colour;
  final VoidCallback onPress;
  final String productName;
  final String propertyTextProduct;
  final String nameImage;
  final String priceProduct;
  final int idProduct;
  final int countPorc;
  final String formName;


  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        
        onTap: onPress,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                  AspectRatio(aspectRatio: 100/100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage (
                                        fit: BoxFit.fitWidth,
                                        alignment: FractionalOffset.topCenter,
                                         image: NetworkImage(nameImage),
                                         //Image.network(nameImage, fit: BoxFit.contain, )
                                      )
                                    ),
                                  )
                                  )

                                ]

                        )),
                        ] // asset(nameImage, fit: BoxFit.contain, ), ]
                 )),

                  Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                        Text(productName, style:  kLabeleB15Red ),
                        Text('в форме: ' + formName, style: TextStyle( fontSize: 10.0, color: Colors.indigo) ),
                        Text(propertyTextProduct, style: kLabele10,),
                        ]),),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(height: 35.0, color: Colors.white), // тут кол-во порций. шоколад, фрукты
                                Container(height: 25.0,
                                  margin: const EdgeInsets.only(left: 35.0, right: 35, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        Text(priceProduct+' ₽/шт', style: kLabele15), // Общая сумма заказа
                                      ]
                                  ),
                                )

                              ]),
                        ),
                        //const SizedBox(height: 35.0,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(height: 35.0,
                                margin: const EdgeInsets.only(left: 35.0, right: 35, top: 0, bottom: 0),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      TextButton(onPressed: () {
                                        operationOnCard.cardOperation(CardData(idProduct, '$productName', '$propertyTextProduct', 1, int.parse(priceProduct), countPorc, formName),'+');
                                        print('Добавлен продук в корзину');
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text('Заказ', style: TextStyle(fontSize: 15, color: Colors.green ),),
                                            content: const Text('Продукт добавлен в заказ'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'OK'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                        child: Text('в корзину', style: kLabele15,),
                                      )
                                    ]
                                ),
                              ),
                            ],
                          )
                         )

                      ]
                  )),
              ]
              ))
            ],
          )
        ),);
  }
}

// Карточка продукта в корзине

class ReusebleCardProductCard extends StatelessWidget {
  ReusebleCardProductCard({required this.colour, required this.onPress, required this.productNumber,  required this.productName,   required this.propertyTextProduct,
              required this.countProduct, required this.priceProduct
              , required this.countPorc
              , required this.onPressRefresh
              , required this.formName
  });

final Color colour;
final VoidCallback onPress;
final Function() onPressRefresh;
final String productName;
final String propertyTextProduct;
final int countProduct;
final int priceProduct;
final int productNumber;
final int countPorc;
final String formName;

//price
//countBy

  OperationOnCard operationOnCard = OperationOnCard();

@override
Widget build(BuildContext context) {

  return
    GestureDetector(

      onTap: onPress,
      child: Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Column (
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: 18.0, child: Text(productName, style: TextStyle(color: kBottomContainerColor, fontSize: 16.0, backgroundColor: Colors.grey.shade100)),
                                  ),
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  Container(
                                    height: 25.0, child: Text('форма: '+formName, style: TextStyle(color: kTextColor1, fontSize: 12.0, backgroundColor: Colors.grey.shade100)),
                                  ),
                                  SizedBox(height: 1.0,)
                                    ]
                              )),
                              Expanded(child: Column (
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                     child: Text(priceProduct.toString() + ' ₽', style: TextStyle(color: kTextColor1, fontSize: 16.0,))
                                    )
                                  ]
                              ))
                                      ]
                                      )),
                          Expanded(child: Row (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: Column(
                                children: [
                                  Container(


                                  child:  Text(propertyTextProduct, style: TextStyle(color: kTextColor1, fontSize: 10.0))

                                  ),
                                ],
                              )),
                              //Действия по добавлению/ удалению кол-ва товаров в корзине
                              Expanded(child: Column(
                                children: [
                                  Expanded(child: Row (
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:  [
                                      TextButton(onPressed: () {
                                        operationOnCard.cardOperation(CardData(productNumber, '$productName', '$propertyTextProduct', 1, priceProduct, countPorc, formName),'-');
                                        onPressRefresh();
                                        }, child: Icon(Icons.remove_circle_outlined, size: 22.0, color: Colors.grey)),
                                      SizedBox(width: 15.0,),
                                      Text(countProduct.toString(), style: TextStyle(color: kTextColor1),),
                                      SizedBox(width: 15.0,),
                                      TextButton(onPressed: ()  {
                                        operationOnCard.cardOperation(CardData(productNumber, '$productName', '$propertyTextProduct', 1, priceProduct, countPorc, formName),'+');
                                        onPressRefresh();
                                        }, child: Icon(Icons.add_circle, size: 22.0, color: Colors.green)),
                                    ],
                                  ))
                                ],
                              )),
                              //Text(propertyTextProduct, style: TextStyle(color: kTextColor1, fontSize: 10.0))
                            ],
                          )),

                        ]
                    )),
                  ]
              )),
            ],

          )
      ),);
}
}


// Страница с катологом
class ScrollCardWidget extends StatelessWidget {
  ScrollCardWidget({ required this.numberGroup, required this.countChild, required this.widgetInTop,
    required this.arrayProduct,
  });

  final Widget widgetInTop;
 // final Widget widgetIn;
  final int countChild;
  final int numberGroup;
  final ActualCatalog arrayProduct;

  @override
  Widget build(BuildContext context) {
    return
      CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
           SliverAppBar(
           pinned: false,
           expandedHeight: 240.0,
           backgroundColor: Colors.white,
               flexibleSpace: widgetInTop
                           ),

          SliverFixedExtentList(
              delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  color: Colors.grey.shade50,
                  alignment: Alignment.center,
                 // child: widgetIn,
                  child: ReusebleCardProduct(
                    colour: kMainBackGroundColor,
                    idProduct: arrayProduct.PRODUCT![index].ID!,
                    productName: arrayProduct.PRODUCT![index].PRODUCT_NAME!,
                    propertyTextProduct: arrayProduct.PRODUCT![index].TEXT_PRODUCT!,
                    nameImage: kImageFolder+arrayProduct.PRODUCT![index].IMAGE_PATH!,
                    priceProduct: arrayProduct.PRODUCT![index].PRICE_PRODUCT!,
                    countPorc: arrayProduct.PRODUCT![index].COUNT_PORC!,
                    formName: arrayProduct.PRODUCT![index].FORM_NAME!,
                    onPress: () {
                        print('$index');
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => DetailProductScreen(numberGroup: numberGroup, numberProuct: index)
                        )
                        );
                    },
                  ),

                );
              }, childCount: arrayProduct.PRODUCT?.length),
              itemExtent: 230),// высота плашки
          SliverAppBar(
            pinned: false,
            expandedHeight: 180.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
                background: SvgPicture.asset('image/profile/birthday_cake.svg')  
              //Image.network("http://b-ssl.duitang.com/uploads/blog/201312/04/20131204184148_hhXUT.jpeg",fit: BoxFit.cover,),
            ),
          ),
        ],
      );
  }
}

// Страница с историей заказов

// Страница с катологом
class ScrollCardOrderHistory extends StatelessWidget {
  ScrollCardOrderHistory({
    required this.arrayOrder,
   // required this.countChild
  });


  final List<OrderData> arrayOrder;
//  final int countChild;

  @override
  Widget build(BuildContext context) {
    return
      CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [

          SliverFixedExtentList(
              delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  color: Colors.grey.shade50,
                  alignment: Alignment.center,
                  // child: widgetIn,
                  child: ReusebleCardOrder(
                    ORDER_ID: arrayOrder[index].ORDER_ID!,
                    STATUS_NAME: arrayOrder[index].STATUS_NAME!,
                    DATE_ORDER: arrayOrder[index].DATE_ORDER!,
                    PRODUCT: arrayOrder[index].PRODUCT,
                    TOTAL_PRICE: arrayOrder[index].TOTAL_PRICE,
                    //DELIVERY: arrayOrder.ORDER_DATA![0].DELIVERY!
                    // colour: kMainBackGroundColor,
                    // idProduct: arrayProduct.PRODUCT![index].ID!,
                    // productName: arrayProduct.PRODUCT![index].PRODUCT_NAME!,
                    // propertyTextProduct: arrayProduct.PRODUCT![index].TEXT_PRODUCT!,
                    // nameImage: kImageFolder+arrayProduct.PRODUCT![index].IMAGE_PATH!,
                    // priceProduct: arrayProduct.PRODUCT![index].PRICE_PRODUCT!,
                    // countPorc: arrayProduct.PRODUCT![index].COUNT_PORC!,
                    // formName: arrayProduct.PRODUCT![index].FORM_NAME!,
                    // onPress: () {
                    //   print('$index');
                    //   Navigator.pushReplacement(context, MaterialPageRoute(
                    //       builder: (context) => DetailProductScreen(numberGroup: numberGroup, numberProuct: index)
                    //   )
                    //   );
                    // },
                  ),

                );
              }, childCount: arrayOrder.length),
              itemExtent: 130),// высота плашки
        ],
      );
  }
}

// Сама карточка в истории заказа

class ReusebleCardOrder extends StatelessWidget {
  //OperationOnCard operationOnCard = OperationOnCard();
  ReusebleCardOrder({

    required this.ORDER_ID, required this.STATUS_NAME, required this.DATE_ORDER, required this.TOTAL_PRICE, required this.PRODUCT,//required this.DELIVERY

  });

  final int ORDER_ID;
  final String? STATUS_NAME;
  final String? DATE_ORDER;
  final int? TOTAL_PRICE;
  final List<OrderProduct>? PRODUCT;



  //final List<OrderDelivery>?  DELIVERY;

  @override
  Widget build(BuildContext context) {

    return
      GestureDetector(

        //onTap: onPress,
        child: Container(
            margin: const EdgeInsets.only( left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('№: $ORDER_ID', style:  kLabeleB15Green),
                                        ],
                                      ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text('Статус:', style:   kLabele12),
                                          ],
                                        ),
                                        Column(
                                            children: [
                                              Text( '$STATUS_NAME', style:   kLabele12),
                                            ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text('Дата формирования:', style:   kLabele12),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text( '$DATE_ORDER', style:   kLabele12),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text('Кол-во позиций в заказе:', style:   kLabele12),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text( '${PRODUCT!.length}', style: kLabele12),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text('Стоимость: ', style:   kLabele12),
                                          ],
                                        ),
                                        Column(
                                          children: [

                                            Text( '$TOTAL_PRICE', style: kLabeleB15Green),
                                          ],
                                        ),
                                      ],
                                    ),



                                  ]),),
                            // Expanded(
                            //   child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Container(height: 35.0, color: Colors.white), // тут кол-во порций. шоколад, фрукты
                            //         Container(height: 25.0,
                            //           margin: const EdgeInsets.only(left: 35.0, right: 35, top: 5, bottom: 5),
                            //           decoration: BoxDecoration(
                            //             color: Colors.blue.shade100,
                            //             borderRadius: BorderRadius.circular(10.0),
                            //           ),
                            //           child: Row(
                            //               mainAxisAlignment: MainAxisAlignment.center,
                            //               children:  [
                            //                 Text(' ₽/шт', style: kLabele15), // Общая сумма заказа
                            //               ]
                            //           ),
                            //         )
                            //
                            //       ]),
                            // ),
                            //const SizedBox(height: 35.0,),
                            // Expanded(
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.end,
                            //       children: [
                            //         Container(height: 35.0,
                            //           margin: const EdgeInsets.only(left: 35.0, right: 35, top: 0, bottom: 0),
                            //           decoration: BoxDecoration(
                            //             color: Colors.green.shade100,
                            //             borderRadius: BorderRadius.circular(10.0),
                            //           ),
                            //           child: Row(
                            //               mainAxisAlignment: MainAxisAlignment.center,
                            //
                            //               children: [
                            //                 TextButton(onPressed: () {
                            //
                            //                 },
                            //                   child: Text('в корзину', style: kLabele15,),
                            //                 )
                            //               ]
                            //           ),
                            //         ),
                            //       ],
                            //     )
                            // )

                          ]
                      )),
                    ]
                ))
              ],
            )
        ),);
  }
}
//////////////////////////////////////



// Страница корзина

class CardCardWidget extends StatelessWidget {
  CardCardWidget({ /*required this.widgetIn,*/ required this.countChild,
    required this.arrayProduct,
    required this.refreshWidget
   // required this.onPress
  });

  OperationOnCard operationOnCard = OperationOnCard();
  // final Widget widgetIn;
    final Function() refreshWidget;
   int countChild;
   List<CardData> arrayProduct;
  //final VoidCallback onPress;


  void refreshCard () {

      arrayProduct = operationOnCard.returnCardArray();
      countChild = arrayProduct.length;
      print('нажата кнопка + или -');
  }




  @override
  Widget build(BuildContext context) {
    return
      CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFixedExtentList(
              delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  color: Colors.grey.shade50,
                  alignment: Alignment.center,
                  // child: widgetIn,


                  //   onPressed: () {
                  //     print('нажал на плашку в карзине');
                  //   },

                  child: ReusebleCardProductCard( // карточка в корзине
                    colour: kMainBackGroundColor,
                    productNumber: arrayProduct[index].idProduct,
                    productName: arrayProduct[index].nameProduct,
                    propertyTextProduct: arrayProduct[index].propertyTextProduct,
                    countProduct: arrayProduct[index].countProduct,
                    priceProduct: arrayProduct[index].price * arrayProduct[index].countProduct,
                    countPorc: arrayProduct[index].countPorc * arrayProduct[index].countProduct,
                    onPressRefresh: refreshWidget,
                    formName: arrayProduct[index].formName,
                   // addCard: operationOnCard.CardAdd(arrayProduct[index]),
                   // cutCard: operationOnCard.CardCut(),
                    onPress: () {
                      print('плашка $index');
                    },
                  ),
                 //   ),
                );
              }, childCount: arrayProduct.length),
              itemExtent: 110),// высота плашки

        ],
      );
  }
}



//Бар скроллинга фото вверху формы
class ScrollImageWidget extends StatelessWidget {
  ScrollImageWidget({required this.imageName1, required this.imageName2, required this.imageName3, });

  final String imageName1;
  final String imageName2;
  final String imageName3;

  @override
  Widget build(BuildContext context) {
    return
        ImageSlideshow(

          /// Width of the [ImageSlideshow].
          //width: double.infinity,

          /// Height of the [ImageSlideshow].
          height: 250,

          /// The page to show when first creating the [ImageSlideshow].
          initialPage: 0,

          /// The color to paint the indicator.
          indicatorColor: kTextColor1,

          /// The color to paint behind th indicator.
          indicatorBackgroundColor: Colors.grey,

          /// The widgets to display in the [ImageSlideshow].
          /// Add the sample image file into the images folder
          children: [
            Image.asset(
              imageName1,
              fit: BoxFit.contain,
            ),
            Image.asset(
              imageName2,
              fit: BoxFit.contain,
            ),
            Image.asset(
              imageName3,
              fit: BoxFit.contain,
            ),
          ],

          /// Called whenever the page in the center of the viewport changes.
          onPageChanged: (value) {
            print('Page changed: $value');
          },

          /// Auto scroll interval.
          /// Do not auto scroll with null or 0.
          autoPlayInterval: 5000,

          /// Loops back to first slide.
          isLoop: true,
        );
  }
}

//Бар навигации внизу формы

class ButtomTapWidget extends StatelessWidget  {
  ButtomTapWidget(
      {required this.barHeight1, required this.arcHeight1,  required this.itemTextOff1, required this.itemTextOn1, required this.numberPage, required this.buttonPress  });

  final double  barHeight1;
  final double  arcHeight1;
  final double  itemTextOff1;
  final double  itemTextOn1;
  final int     numberPage;
  final Function buttonPress;



  @override
  Widget build(BuildContext context)  {
    return  CircleBottomNavigationBar(
      barHeight: 80,
      arcHeight: 60,
      itemTextOff: 0,
      itemTextOn: 0,
      circleOutline: 10.0,
      shadowAllowance: 10.0,
      circleSize: 40.0,
        iconYAxisSpace: 1,
        textYAxisSpace:  0,
      blurShadowRadius: 0.0,

        hasElevationShadows : false,

      initialSelection: numberPage,
      barBackgroundColor: kTextColor3,
      circleColor: kTextColor3,
      activeIconColor: Colors.white,
      inactiveIconColor: Colors.grey,
      tabs: [
        TabData(
          icon: Icons.home,
          iconSize: 25,// Optional
          title: 'Каталог',// Optional
          fontSize: 12,// Optional
          onClick: () {
            print('Каталог');
          },
        ),
        TabData(
            icon: Icons.shopping_cart_rounded,
            title: 'Корзина',
            fontSize: 12.0,
            onClick: () {
              print('Корзина');
            }
        ),
        TabData(icon: Icons.search,
          title: 'Поиск',
          fontSize: 12.0,
        ),
        //TabData(icon: Icons.alarm),
      ],
      onTabChangedListener: (index) {
        buttonPress(index);
      }
    );
  }
}



// Пустой экран если нет истории заказов
class NoHistoryOrder extends StatelessWidget {
  const NoHistoryOrder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15, top: 40, bottom: 5),
                  height: 150.0,
                  child: SvgPicture.asset('image/profile/no_list_order.svg', height: 250,width: 250,)
              ),
              Container(

                  margin: const EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 5),
                  child: Text('В данном разделе будет отображаться история ваших заказов', style: kLabele15,textAlign: TextAlign.center)),

            ],

          ),
        )

        //Text('В данном разделе будет отбражаться история заказов', style: kLabele10)
      ],
    );
  }
}

class NoCardData extends StatelessWidget {
  const NoCardData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15, top: 40, bottom: 5),
                  height: 150.0,
                  child: SvgPicture.asset('image/profile/empty_cart.svg', height: 300,width: 300,)
              ),
              Container(

                  margin: const EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 5),
                  child: const Text('В заказе еще нет вкуснейших позиций', style: kLabele15,textAlign: TextAlign.center)),

            ],

          ),
        )

        //Text('В данном разделе будет отбражаться история заказов', style: kLabele10)
      ],
    );
  }
}

class NoPostData extends StatelessWidget {
  const NoPostData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15, top: 40, bottom: 5),
                  height: 150.0,
                  child: SvgPicture.asset('image/profile/posting_photo.svg', height: 300,width: 300,)
              ),
              Container(

                  margin: const EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 5),
                  child: const Text('В данном разделе будет фото тортиков', style: kLabele15,textAlign: TextAlign.center)),

            ],

          ),
        )

        //Text('В данном разделе будет отбражаться история заказов', style: kLabele10)
      ],
    );
  }
}