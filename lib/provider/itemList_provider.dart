import 'package:flutter/material.dart';
import 'item_list.dart';

class Items with ChangeNotifier {
  List<ItemList> products = [
    ItemList(
        img: Image.asset("assets/food.png"),
        title: 'Food',
        price: 500,
        date: DateTime.now(),
        remark: 'aa',
        id: DateTime.now().toString(),
        time: TimeOfDay.now(),
        firestoreId: ''),
    ItemList(
        img: Image.asset("assets/wine.png"),
        title: 'wine',
        price: 550,
        date: DateTime.now(),
        remark: 'aa',
        id: DateTime.now().toString(),
        time: TimeOfDay.now(),
        firestoreId: ''),
    ItemList(
        img: Image.asset("assets/sports.png"),
        title: 'Sports',
        date: DateTime.now(),
        price: 400,
        remark: 'aa',
        id: DateTime.now().toString(),
        time: TimeOfDay.now(),
        firestoreId: ''),
  ];

  List<ItemList> get items {
    return [...products];
  }

  double get totalExpances {
    double _total = 0.0;
    items.forEach((element) {
      _total += element.price!;
    });
    return _total;
  }

  void deleteProduct(String id) {
    products.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void updateProduct(ItemList item) {
    final newItem = ItemList(
      img: item.img,
      date: item.date,
      remark: item.remark,
      title: item.title,
      price: item.price,
      time: item.time,
      id: item.id,
      firestoreId: item.firestoreId,
    );
    notifyListeners();
  }

  void updateDate(String productId, DateTime date) {
    print('aa gya');
    final item = products.firstWhere((element) => element.id == productId);
    final prodIndex = products.indexWhere((element) => element.id == productId);
    final newItem = ItemList(
      img: item.img,
      date: date,
      remark: item.remark,
      title: item.title,
      price: item.price,
      id: item.id,
      time: item.time,
      firestoreId: item.firestoreId,
    );
    products[prodIndex] = newItem;
    notifyListeners();
  }
}
