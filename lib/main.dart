import 'package:flutter/material.dart';
import 'package:project/screens/addItem.dart';
import 'package:project/services/router.dart';
import './splash_screen.dart';
import 'package:provider/provider.dart';
import './provider/itemList_provider.dart';
import './screens/product_detail_screen.dart';
import './screens/edit_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Pocketify());
}

class Pocketify extends StatelessWidget {
  const Pocketify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Items(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.purple,
            canvasColor: Colors.white.withOpacity(0.9)),
        initialRoute: splashScreenId,
        onGenerateRoute: routing,
      ),
    );
  }
}
