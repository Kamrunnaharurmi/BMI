import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'page1.dart';
import 'package:google_fonts/google_fonts.dart';


class start extends StatefulWidget {
  const start({super.key});

  @override
  State<start> createState() => startState();
}

class startState extends State<start> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    Future.delayed( Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (ctx) =>  page1()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/im.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              padding:  EdgeInsets.only(left: 25, right: 25, top: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(height: 200),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Image.asset(
                          'image/log.jpg',
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                   SpinKitPouringHourGlassRefined(
                    color: Colors.black,
                    size: 50,
                  ),
                   SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
