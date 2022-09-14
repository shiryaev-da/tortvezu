// import 'package:tortvezu/constants.dart';
// import 'package:tortvezu/moduls/networking.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:tortvezu/constants.dart';
import 'package:tortvezu/moduls/action_modul_class.dart';

/*
//=============================
  Информация о пользователе:
  Класс информации по пользователю. Данные пользователя, тип учетной записи и т.д.
//=============================
*/
List<UserData> userDataCash = []; //основной массив текущей информации о пользователе

class UserData {

  int id = 0;
  String deviceId = '?';
  String phoneNumber ='?';
  String firstName = '?';
  String email = '?';
  String beathDate = '?';
  int typeUser = 0;
  String imagePath = '?';
  int activeUser = 0;

  UserData(int _id, String _deviceId, String _phoneNumber, String _firstName, String _email, String _beathDate, int _typeUser, String _imagePath, int _activeUser)
  {
    id = _id;
    deviceId = _deviceId;
    phoneNumber = _phoneNumber;
    firstName = _firstName;
    email=_email;
    beathDate = _beathDate;
    typeUser = _typeUser;
    imagePath = _imagePath;
    activeUser = _activeUser;
  }

  Map toJson() => {
    'id' : id,
    'deviceId' : deviceId,
    'phoneNumber' : phoneNumber,
    'firstName': firstName,
    'email': email,
    'beathDate': beathDate,
    'typeUser': typeUser,
    'imagePath': imagePath,
    'activeUser': activeUser
  };

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    phoneNumber = json['phoneNumber'];
    firstName = json['firstName'];
    email = json['email'];
    beathDate = json['beathDate'];
    typeUser = json['typeUser'];
    imagePath = json['imagePath'];
    activeUser = json['activeUser'];
  }


}


/*
//=============================
  Информация по карточке продукта:
  Класс информации по продукту в карточке. В данный класс собирается информация по продукту и отправляется на в виджет
//=============================
*/
class ProductDataWidget  {
  int idProduct = 0;
  String nameImage = '?';
  String nameProduct = '?';
  String propertyTextProduct  = '?';

 ProductDataWidget(int _idProduct,String _nameImage, String _nameProduct, String _propertyTextProduct)
 {
   idProduct = _idProduct;
   nameImage = _nameImage;
   nameProduct = _nameProduct;
   propertyTextProduct = _propertyTextProduct;
 }

 Map toJson() => {
   'idProduct' : idProduct,
   'nameImage' : nameImage,
   'nameProduct': nameProduct,
   'propertyTextProduct': propertyTextProduct
 };
}



//Класс для корзины

class CardData {
  int idProduct = 0;
  String nameProduct = '?';
  String propertyTextProduct  = '?';
  int countProduct = 0;
  int countPorc = 0;
  int price=0;
  String formName = '?';

  CardData(int _idProduct, String _nameProduct, String _propertyTextProduct, int _countProduct, int _price, int _countPorc, String _formName)
  {
    idProduct = _idProduct;
    countProduct = _countProduct;
    nameProduct = _nameProduct;
    propertyTextProduct = _propertyTextProduct;
    countPorc = _countPorc;
    price = _price;
    formName = _formName;
  }

  Map toJson() => {
    //TODO {поменять на логин реального пользователя}
    'username': 1,
    'idProduct' : idProduct,
    'countProduct' : countProduct,
    'nameProduct': nameProduct,
    'propertyTextProduct': propertyTextProduct,
    'countPorc': countPorc,
    'price': price,
    'totalPrice':  price*countProduct,
    'formName': formName
  };
}

//ответ на отправку нового заказа
class AnswersCartData {
  int? numberOrder;

  AnswersCartData(this.numberOrder);

  AnswersCartData.fromJson(Map<String, dynamic> json) {
    numberOrder = json['numberOrder'];
  }

}


///[START CARD]//////////////////
List<CardData> cardDataCash = []; //основной массив в перечнем продуктов в корзине

class OperationOnCard   {
 //  List<CardData> _cardData1 = [];

void cardOperation (CardData arraiIn, String rule) {
  // print('Добавлен или удален продукт ' + arraiIn.nameProduct);
  var numProd = -1;
  numProd = cardDataCash.indexWhere((element) => element.idProduct == arraiIn.idProduct) ;

 if (numProd != -1 && (rule == '+'))
   {
     cardDataCash[numProd].countProduct = cardDataCash[numProd].countProduct + arraiIn.countProduct; //кол-во шт. товара
     cardDataCash[numProd].countPorc = cardDataCash[numProd].countPorc + arraiIn.countPorc; // порции
     //cardData1[numProd].price = cardData1[numProd].countProduct * arraiIn.price;
   }
 else if (numProd == -1 && (rule == '+'))
   {
     cardDataCash.add(arraiIn);
   }
 else if ((numProd != -1 && (rule == '-')))
  {
    if (arraiIn.idProduct == cardDataCash[numProd].idProduct && arraiIn.countProduct == cardDataCash[numProd].countProduct)
   {
      cardDataCash.removeWhere((element) => element.idProduct == arraiIn.idProduct);
   }
    else if (numProd != -1 && (rule == '-'))
   {
     cardDataCash[numProd].countProduct = cardDataCash[numProd].countProduct - arraiIn.countProduct; //кол-во шт. товара
     cardDataCash[numProd].countPorc = cardDataCash[numProd].countPorc - arraiIn.countPorc; // порции
     //cardData1[numProd].price = cardData1[numProd].countProduct * arraiIn.price;
     //print(cardData1);
   }
 }
 // clear data in cart
 else if ( rule == '0')
 {
   cardDataCash = [];
 }
 // print(cardData1[numProd].price);
}

int totalPriceCard () {
  var totalPrice = 0;
  for (int i =0; i < cardDataCash.length; i++) {
    totalPrice = totalPrice+ cardDataCash[i].price * cardDataCash[i].countProduct;
  }
  return totalPrice;
}


returnCardArray ()   {
    //var n=cardDataCash.length;
    //print('вернул весь массив данных в корзине $n');
    return  cardDataCash;
   }
}
///[END CARD]//////////////////////////////////////////


///[START delivery class]//////////

List<DeliveryData> dataDelivery = [];
 int tempNumberOrder = 0; //временный номер заказа

class DeliveryData {
  int     idOrder = 0; //[номер заказа]
  String deliveryDate = '?'; //[Дата доставки]
  String  timeFrom = '?'; //[Интервал доставки С]
  String  timeTo = '?'; //[Интервал доставки ПО]

  String  phoneNumberGot = '?'; //[Номер телефона получателя]
  String  iO ='?'; //[Имя получателя, опционально]

  String  townName ='?'; //[Наименование населенного пункта]
  String  areaName ='?'; //[Наименоавние области]
  String  streetName ='?'; //[Наименование улицы, проспекта, бульвара и т.д.]
  String  houseNumber ='?'; //[Номер дома]
  String  partHouseNumber ='?'; //[Номер дома, корпуса]
  String  doorNumber ='?'; //[Номер подъезда]
  String  floorNumber ='?'; // [Этаж]
  String  doorKey ='?'; //[Домофон]
  String  commentToDelivery  ='?'; //комментарий позаказу
  String  appNumber = '?';

DeliveryData
    (
      int _idOrder,
      String _deliveryDate,
      String _timeFrom,
      String _timeTo,
      String  _phoneNumberGot,
      String  _iO, //[Имя получателя, опционально]

      String  _townName, //[Наименование населенного пункта]
      String  _areaName, //[Наименоавние области]
      String  _streetName, //[Наименование улицы, проспекта, бульвара и т.д.]
      String  _houseNumber, //[Номер дома]
      String  _partHouseNumber, //[Номер дома, корпуса]
      String  _doorNumber, //[Номер подъезда]
      String  _floorNumber , // [Этаж]
      String  _doorKey ,//[Домофон]
      String  _commentToDelivery, //комментарий позаказу
      String  _appNumber, //комментарий позаказу
    )
{
  idOrder = _idOrder;
  deliveryDate = _deliveryDate;
  timeFrom =  _timeFrom;
  timeTo =  _timeTo;
  phoneNumberGot =  _phoneNumberGot;
  iO = _iO; //[Имя получателя, опционально]
  townName = _townName; //[Наименование населенного пункта]
  areaName = _areaName; //[Наименоавние области]
  streetName  = _streetName; //[Наименование улицы, проспекта, бульвара и т.д.]
  houseNumber = _houseNumber; //[Номер дома]
  partHouseNumber = _partHouseNumber; //[Номер дома, корпуса]
  doorNumber = _doorNumber; //[Номер подъезда]
  floorNumber = _floorNumber; // [Этаж]
  doorKey = _doorKey; //[Домофон]
  commentToDelivery = _commentToDelivery;
  appNumber = _appNumber; // [Номер квартиры]
}

Map toJson() => {
    //TODO {поменять на логин реального пользователя}
    'idOrder': idOrder,
    'deliveryDate' : deliveryDate,
    'timeFrom' : timeFrom,
    'timeTo': timeTo,
    'phoneNumberGot': phoneNumberGot,
    'iO': iO,
    'townName': townName,
    'areaName':  areaName,
    'streetName': streetName,
    'houseNumber': houseNumber,
    'partHouseNumber': partHouseNumber,
    'doorNumber': doorNumber,
    'floorNumber': floorNumber,
    'doorKey': doorKey,
    'commentToDelivery': commentToDelivery,
    'appNumber': appNumber,
    'key' :   cryptoKeyOut,
    'solt' :  SoltOut
  };
}

class OperationOnDelivery {
  void updateDeliveryData (DeliveryData dataIn) {
    var numProd = -1;
    numProd = dataDelivery.indexWhere((element) => element.idOrder == dataIn.idOrder) ;

    if (numProd == -1)
    {
      dataDelivery.add(dataIn);
    }
    else {
      dataDelivery = [];
      dataDelivery.add(dataIn);
    }

  }

}

///[END delivery class]//////////


///[Start actual katalog]////
class ActualKatalog {
  List<ActualCatalog>? KATALOG;

  ActualKatalog(this.KATALOG);

  ActualKatalog.fromJson(Map<String, dynamic> json) {
    if (json['KATALOG'] != null) {
      KATALOG = <ActualCatalog>[];
      (json['KATALOG'] as List).forEach((e) {
        KATALOG!.add(ActualCatalog.fromJson(e));
      });
    }
  }
}

class ActualCatalog{
  String? PRODUCT_GROUP ;
  List<ActualProductCatalog>? PRODUCT;

  ActualCatalog(this.PRODUCT_GROUP, this.PRODUCT);

  ActualCatalog.fromJson(Map<String, dynamic> json) {
    PRODUCT_GROUP = json['PRODUCT_GROUP'];
    if(json['PRODUCT']!=null) {
      PRODUCT=<ActualProductCatalog>[];
      (json['PRODUCT'] as List).forEach((e) {
        PRODUCT!.add(ActualProductCatalog.fromJson(e));
      });
    }
  }
}




class ActualProductCatalog {
  int? ID;
  String? PRODUCT_NAME;
  String? TEXT_PRODUCT;
  String? IMAGE_PATH;
  int? COUNT_PORC;
  int? COUNT_SHUGER;
  int? COUNT_FRUIT;
  int? COUNT_ON_SKLAD;
  String? FORM_NAME;
  String? PRICE_PRODUCT;

  ActualProductCatalog(
      this.ID,
      this.PRODUCT_NAME,
      this.TEXT_PRODUCT,
      this.IMAGE_PATH,
      this.COUNT_PORC,
      this.COUNT_SHUGER,
      this.COUNT_FRUIT,
      this.COUNT_ON_SKLAD,
      this.FORM_NAME,
      this.PRICE_PRODUCT);

  ActualProductCatalog.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    PRODUCT_NAME = json['PRODUCT_NAME'];
    TEXT_PRODUCT = json['TEXT_PRODUCT'];
    IMAGE_PATH = json['IMAGE_PATH'];
    COUNT_PORC = json['COUNT_PORC'];
    COUNT_SHUGER = json['COUNT_SHUGER'];
    COUNT_FRUIT = json['COUNT_FRUIT'];
    COUNT_ON_SKLAD = json['COUNT_ON_SKLAD'];
    FORM_NAME = json['FORM_NAME'];
    PRICE_PRODUCT = json['PRICE_PRODUCT'].toString();
  }
}

ActualKatalog? actualKatalogData;

class OperatioOnKatalog  {
  ActualKatalog? _actualKatalogData;
  void refreshKatalogData (ActualKatalog inKatalog){
    _actualKatalogData = inKatalog;
    actualKatalogData = inKatalog;
    //print('сейчас в дата модуле информация');
    //print(_actualKatalogData!.KATALOG?[0].PRODUCT?[0].PRODUCT_NAME);
  }

  returnActualCatalog () {
      //print('Возврат данных из класса');
      //print(actualKatalogData!.KATALOG?[0].PRODUCT?[0].PRODUCT_NAME);
        return actualKatalogData;
      }

}
///[End actual katalog]////

///[Start Order Data]////

///Основной массив истории заказов
///

OrderDataArray? orderListHistory;

class OperatioOnOrderListHistory  {
  OrderDataArray? _orderListHistory;




  getOrderListHistory  () async  {
    //var duration = new Duration(seconds: 3);
    print('Будет отправка сервиса');
    var OrderHistData = await postOrderList ('{"id_user": 1,"key": "$cryptoKeyOut", "solt": "$SoltOut" }');//; networkPost.postData(kServiceKatalogData, '{"id_user": 1}');
    print('Даные истории заказов из сервиса Получены');
    OrderDataArray orderDataArray = OrderDataArray.fromJson(OrderHistData);
    OperatioOnOrderListHistory onOrderListHistory = OperatioOnOrderListHistory();
    onOrderListHistory.refreshOrderListData(orderDataArray);

  }

  void refreshOrderListData (OrderDataArray inArray){
    _orderListHistory = inArray;
    orderListHistory = inArray;
    print('сейчас в дата модуле Истории заказов информация');
    //print(_orderListHistory!.ORDER_ID);
  }

  returnOrderListHistory () {
    print('Возврат данных из истории заказов!!!!!!');
    //print(actualKatalogData!.KATALOG?[0].PRODUCT?[0].PRODUCT_NAME);
    return orderListHistory!.ORDER_DATA!;
  }
}


class OrderDataArray {
  List<OrderData>? ORDER_DATA;

  OrderDataArray(this.ORDER_DATA);

  OrderDataArray.fromJson(Map<String, dynamic> json) {
    if (json['ORDER_DATA'] != null) {
      ORDER_DATA = <OrderData>[];
      (json['ORDER_DATA'] as List).forEach((e) {
        ORDER_DATA!.add(OrderData.fromJson(e));
      });
    }
  }
}


class OrderData{
  int? ORDER_ID;
  String? STATUS_NAME;
  String? DATE_ORDER;
  int? TOTAL_PRICE;

  List<OrderProduct>? PRODUCT;
  List<OrderDelivery>? DELIVERY;

  OrderData(this.ORDER_ID, this.STATUS_NAME, this.DATE_ORDER, this.TOTAL_PRICE, this.PRODUCT, this.DELIVERY);

  OrderData.fromJson(Map<String, dynamic> json) {
    ORDER_ID = json['ORDER_ID'];
    STATUS_NAME = json['STATUS_NAME'];
    DATE_ORDER = json['DATE_ORDER'];
    TOTAL_PRICE = json['TOTAL_PRICE'];
    if(json['PRODUCT']!=null) {
      PRODUCT = <OrderProduct>[];
      (json['PRODUCT'] as List).forEach((e) {
        PRODUCT!.add(OrderProduct.fromJson(e));
      });
    }
    if(json['DELIVERY']!=null) {
      DELIVERY=<OrderDelivery>[];
      (json['DELIVERY'] as List).forEach((e) {
        DELIVERY!.add(OrderDelivery.fromJson(e));
      });
    }
  }
}

class OrderProduct {
  int? ID_PRODUCT;
  String? NAME_PRODUCT;
  int? COUNT_PRODUCT;
  int? PRICE;
  int? TOTAL_PRICE;

  OrderProduct(
      this.ID_PRODUCT,
      this.NAME_PRODUCT,
      this.COUNT_PRODUCT,
      this.PRICE,
      this.TOTAL_PRICE);

  OrderProduct.fromJson(Map<String, dynamic> json) {
    ID_PRODUCT = json['ID_PRODUCT'];
    NAME_PRODUCT = json['NAME_PRODUCT'];
    COUNT_PRODUCT = json['COUNT_PRODUCT'];
    PRICE = json['PRICE'];
    TOTAL_PRICE = json['TOTAL_PRICE'];
  }
}

class OrderDelivery {
  String? DATE_DELIVERY;
  String? TIME_FROM;
  String? TIME_TO;
  String? PHONE_NAMBER_GOT;
  String? IO;
  String? TOWN_NAME;
  String? STREET_NAME;
  String? HOUSE_NUMBER;
  String? PART_HOUSE_NUMBER;
  String? DOOR_NUMBER;
  String? FLOOR_NUMBER;
  String? DOOR_KEY;

  OrderDelivery(
        this.DATE_DELIVERY,
        this.TIME_FROM,
        this.TIME_TO,
        this.PHONE_NAMBER_GOT,
        this.IO,
        this.TOWN_NAME,
        this.STREET_NAME,
        this.HOUSE_NUMBER,
        this.PART_HOUSE_NUMBER,
        this.DOOR_NUMBER,
        this.DOOR_KEY,
        this.FLOOR_NUMBER
      );

  OrderDelivery.fromJson(Map<String, dynamic> json) {
    DATE_DELIVERY = json['DATE_DELIVERY'];
    TIME_FROM = json['TIME_FROM'];
    TIME_TO = json['TIME_TO'];
    PHONE_NAMBER_GOT = json['PHONE_NAMBER_GOT'];
    IO = json['IO'];
    TOWN_NAME = json['TOWN_NAME'];
    STREET_NAME = json['STREET_NAME'];
    HOUSE_NUMBER = json['HOUSE_NUMBER'];
    PART_HOUSE_NUMBER = json['PART_HOUSE_NUMBER'];
    DOOR_NUMBER = json['DOOR_NUMBER'];
    DOOR_KEY = json['DOOR_KEY'];
    FLOOR_NUMBER = json['FLOOR_NUMBER'];

  }
}

///[End Order Data]////



///Класс для Меню пользователя
class PopupItem{
  int value;
  String name;
  PopupItem(this.value, this.name);
}



/// Действия пользователя в приложении для ML

List<UserActionInApp> userActionData = [];

class UserActionInApp {
  int userId = 0;
  String uuid = '?';
  DateTime dateAction = DateTime.now();
  int groupAction = 0;
  int numberAction = 0;
  int idProduct = 0;

  UserActionInApp(int _userId, String _uuid, DateTime _dateAction, int _groupAction, int _numberAction, int _idProduct)
  {
    userId = _userId;
    uuid = _uuid;
    dateAction = _dateAction;
    groupAction = _groupAction;
    numberAction=_numberAction;
    idProduct = _idProduct;
  }

  Map toJson() => {
    'userId' : userId,
    'uuid' : uuid,
    'dateAction' : dateAction,
    'groupAction': groupAction,
    'numberAction': numberAction,
    'idProduct': idProduct
  };

  UserActionInApp.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    uuid = json['uuid'];
    dateAction = json['dateAction'];
    groupAction = json['groupAction'];
    numberAction = json['numberAction'];
    idProduct = json['idProduct'];
  }

}


/// Класс для call greenCall

class GreenCall {
  String? request_id;
  String? code;

  GreenCall(
      this.request_id,
      this.code);

  GreenCall.fromJson(Map<String, dynamic> json) {
    request_id = json['request_id'];
    code = json['code'];
  }
}