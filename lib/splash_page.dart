import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  navigateToHome(BuildContext context) async{
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, '/nav');
    });
  }

  @override
  Widget build(BuildContext context) {
    navigateToHome(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/qr_blue.png",width: 400,height: 130),
          const SizedBox(height: 12),
          const Text("QR Scanner and Generator",style:TextStyle(color: Colors.white,fontSize: 25),)
        ],
        ),
      ),
    );
  }
}
