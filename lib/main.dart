import 'package:flutter/material.dart';
import 'package:iphone_rates_tracker/providers/data_provider.dart';

import 'package:iphone_rates_tracker/screens/homescreen.dart';
import 'package:provider/provider.dart';

//remove provider and use the normal method coz it is not needed in this. DOT

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DataProvider dataProvider = DataProvider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (ctx) => DataProvider()),
        FutureProvider(create: (ctx) => dataProvider.getDataFromApi()),
      ],
      builder: (ctx, _) => MaterialApp(
        title: 'Iphone Rate Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
