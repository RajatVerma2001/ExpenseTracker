import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemList {
  Image? img;
  String? title;
  double? price;
  String? id;
  String? category;
  String? remark;
  DateTime? date;
  TimeOfDay? time;
  String? firestoreId;

  ItemList({
    required this.img,
    required this.date,
    this.category = 'Expences',
    required this.remark,
    required this.title,
    required this.price,
    required this.time,
    required this.id,
    required this.firestoreId,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': img,
      'date': date,
      'remark': remark,
      'title': title,
      'price': price,
      'time': time,
      'id': id,
    };
  }

  static ItemList? fromSnapShot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map;
    if (map == null) {
      return null;
    }

    return ItemList(
      img: map['img'],
      date: map['date'],
      remark: map['remark'],
      title: map['title'],
      price: map['price'],
      time: map['time'],
      id: map['id'],
      //TODO::Store doc id instead of empty string
      firestoreId: snapshot.id,
    );
  }
}
