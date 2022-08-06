import 'package:bgm/components/my_footer_component.dart';
import 'package:bgm/utils/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

import '../login/login_view.dart';
import 'components/page_view_1.dart';
import 'components/page_view_2.dart';
import 'components/page_view_3.dart'; 


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  final ValueNotifier<int> _indicatorValue = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      bottomSheet: const MyFooterComponent(),
      body: Column(
        children: [
          //header
          Container(
            height: screenSize.height * 0.20,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  logo(height: screenSize.height*.08, width: screenSize.width*.1),
                  GestureDetector(
                    onTap: () {
                      //Sortir de l'application
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    child: const Icon(Icons.close, size: 30, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          //Content
          Container(
            height: screenSize.height * 0.8,
            width: screenSize.width,
            padding: const EdgeInsets.only(bottom: 40),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Page Views
                Container(
                  child: ExpandablePageView(
                    onPageChanged: (int pageNumber) {
                      setState(() {
                        _indicatorValue.value = pageNumber;
                      });
                    },
                    controller: _pageController,
                    children: const [
                      PageView1(),
                      PageView2(),
                      PageView3(),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _buildCircleIndicator2(),
                const SizedBox(height: 15),
                //Bouton connexion
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: LoginView(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(10, 10),
                      ),
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: screenSize.width,
                        minHeight: 50.0,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Connexion",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIndicator2() {
    return CirclePageIndicator(
      size: 16.0,
      selectedSize: 18.0,
      itemCount: 3,
      currentPageNotifier: _indicatorValue,
    );
  }
}