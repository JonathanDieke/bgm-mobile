
import 'package:bgm/views/home/home_view.dart';
import 'package:bgm/views/home/home_view_2_animated.dart';
import 'package:bgm/views/insulin/insulin_view.dart';
import 'package:bgm/views/intro/intro_screen.dart';
import 'package:bgm/views/meal/meal_view.dart';
import 'package:bgm/views/sleep/sleep_view.dart';
import 'package:bgm/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../views/login/login_view.dart';
import '../views/sport/sport_view.dart';

final routes = {
  '/splash_screen': (BuildContext context) => const MySplashScreen(),  
  '/intro': (BuildContext context) => const IntroScreen(),  
  '/login': (BuildContext context) => const LoginView(),  
  '/home': (BuildContext context) => const HomeView2Animated(),  
  '/meal': (BuildContext context) => const MealView(),  
  '/sleep': (BuildContext context) => const SleepView(),  
  '/sport': (BuildContext context) => const SportView(),  
  '/insulin': (BuildContext context) => const InsulinView(),  
};