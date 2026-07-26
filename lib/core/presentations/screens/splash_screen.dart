import 'package:flutter/material.dart';
import 'package:rumour/core/base_service/service_registry.dart';
import 'package:rumour/core/modules/module.dart';
import 'package:rumour/core/utilities/navigation/navigation_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
  
    super.initState();
_startInitializationFlow();
    
  }

  Future<void> _startInitializationFlow()async{
   await  sl<ServiceRegistry>().initPreLogin();
   Navigator.of(context).popAndPushNamed(homeScreen);  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Welcome"),
      ),

      body:const Center(child: Text("Welcome to myChat"),),


    );
  }
}