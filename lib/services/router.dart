import 'package:flutter/material.dart';
import 'package:project/provider/item_list.dart';
import 'package:project/screens/addItem.dart';
import 'package:project/screens/edit_screen.dart';
import 'package:project/screens/home_page.dart';
import 'package:project/screens/product_detail_screen.dart';
import 'package:project/splash_screen.dart';

const editScreenID = "/edit_screen";
const homePageID = "/home_page";
const productDetailID = "/product_detail_screen";
const addItemID = "/addItem";
const splashScreenId = "/splash_screen";

Route<dynamic>? routing(RouteSettings settings) {
  switch (settings.name) {
    case editScreenID:
      {
        return MaterialPageRoute(
          builder: (_) => EditScreen(),
        );
      }
    case splashScreenId:
      {
        return MaterialPageRoute(
          builder: (_) => SplashScreens(),
        );
      }
    case addItemID:
      {
        return MaterialPageRoute(
          builder: (_) => AddScreen(),
        );
      }
    case homePageID:
      {
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      }
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}
