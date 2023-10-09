import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/dependency_injection.dart';
import '../helper/colors.dart';
import '../provider/category_provider.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';

void main() async {
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isSign;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        checkIfUserSign();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryProvider(),
      child: GetMaterialApp(
        title: 'Shop-App',
        debugShowCheckedModeBanner: false,
        home: isSign == null
            ? openingView()
            : isSign!
                ? const HomeView()
                : const LoginView(),
      ),
    );
  }

  void checkIfUserSign() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.get("username") == null) {
      isSign = false;
    } else {
      isSign = true;
    }
    setState(() {});
  }
}

Widget openingView() {
  return Container(
    color: Colors.white,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/store.jpg',
          height: 400,
          width: 340,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 10),
        const Text(
          'STORE_APP',
          style: TextStyle(
            fontSize: 33,
            fontWeight: FontWeight.bold,
            color: blueDark2,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    ),
  );
}
