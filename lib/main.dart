import 'package:bgm/api/providers/daily_data_provider.dart';
import 'package:bgm/api/providers/meal_provider.dart';
import 'package:bgm/api/providers/sleep_provider..dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'api/providers/user_provider.dart';
import 'api/providers/insulin_provider.dart';
import 'api/providers/sport_provider.dart';
import 'utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await UserProvider.initialize();
  await DailyDataProvider.initialize();
  await MealProvider.initialize();
  await SleepProvider.initialize();
  await SportProvider.initialize();
  await InsulinProvider.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return UserProvider();
        }),
        ChangeNotifierProvider(create: (context) { 
          return DailyDataProvider();
        }),
        ChangeNotifierProvider(create: (context) { 
          return MealProvider();
        }),
        ChangeNotifierProvider(create: (context) { 
          return SleepProvider();
        }),
        ChangeNotifierProvider(create: (context) { 
          return SportProvider();
        }),
        ChangeNotifierProvider(create: (context) { 
          return InsulinProvider();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bood Glucose Measure',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ).copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(
                builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder()
            })),
        routes: routes,
        initialRoute: "/splash_screen",
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Blood',
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(
  //       // This is the theme of your application.
  //       //
  //       // Try running your application with "flutter run". You'll see the
  //       // application has a blue toolbar. Then, without quitting the app, try
  //       // changing the primarySwatch below to Colors.green and then invoke
  //       // "hot reload" (press "r" in the console where you ran "flutter run",
  //       // or simply save your changes to "hot reload" in a Flutter IDE).
  //       // Notice that the counter didn't reset back to zero; the application
  //       // is not restarted.
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: const MyHomePage(title: 'Flutter Demo Home Page'),
  //   );
  // }

  //fin : Make with love, by JonathanDieke
}



// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bood Glucose Measure',
//       theme: ThemeData(
//         primarySwatch: Colors.deepOrange,
//       ).copyWith(
//           pageTransitionsTheme: const PageTransitionsTheme(
//               builders: <TargetPlatform, PageTransitionsBuilder>{
//             TargetPlatform.android: ZoomPageTransitionsBuilder()
//           })),
//       initialRoute: "/splash_screen",
//       routes: routes,
//     );
//   }
// }
