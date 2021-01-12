import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/views/home_page.dart';
import 'package:getxdemo/views/loader.dart';
import 'package:getxdemo/views/onbroading_oage.dart';
import 'package:getxdemo/views/product_details_page.dart';
import 'package:getxdemo/widgets/custom_dropdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "/",
      // getPages: [
      //   GetPage(name: "/", page: () => OnBoardingPage()),
      //   // GetPage(name: HomePage.routeName, page: () => HomePage()),
      //   GetPage(name: HomePage.routeName, page: () => HomePage()),
      //   GetPage(name: ProductDetailsPage.routeName, page: () => ProductDetailsPage()),
      // ],
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      // Loader(),
      HomePage()
      // OnBoardingPage(),
    );
  }
}
