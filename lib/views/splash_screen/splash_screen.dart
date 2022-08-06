import 'dart:async';

import 'package:bgm/components/my_footer_component.dart';
import 'package:bgm/utils/logo.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2500));
  late Animation sizeAnimation = Tween<double>(begin: 270.0, end: 370.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

  @override
  void initState() {
    super.initState(); 
    
    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    Timer(const Duration(milliseconds: 3600), () {
      Navigator.pushReplacementNamed(context, "/intro");
    });

    // AuthProvider authProvider =
    //     Provider.of<AuthProvider>(context, listen: false);

    // authProvider.getUserStatus().then((String navigation) {
    //   if (navigation == "intro") {
    //     Timer(Duration(milliseconds: 3600), () {
    //       Navigator.pushReplacementNamed(context, "/$navigation");
    //     });
    //   }
    //   if (navigation == "login") {
    //     Timer(Duration(milliseconds: 3600), () {
    //       Navigator.pushReplacementNamed(context, "/$navigation");
    //     });
    //   }
    //   if (navigation == "home") {
    //     Timer(Duration(milliseconds: 3600), () {
    //       Navigator.pushReplacementNamed(context, "/$navigation");
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MyFooterComponent(),
          Container(
            width: width,
            decoration: const BoxDecoration(
              color: Color(0xFFEFEFEF),
            ),
            padding: const EdgeInsets.only(
              bottom: 20,
              top: 10,
              left: 15,
              right: 15,
            ),
            child: const Text(
              "V 1.0.0",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      body: SizedBox(
        width: width,
        height: height,
        // color: Colors.white,
        child: Center(
          child: logo(width: width*.2, height: height*.2),
        ),
      ),
    );
  }
}
