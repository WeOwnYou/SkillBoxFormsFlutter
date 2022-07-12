import 'package:flutter/material.dart';
import 'package:hotels/view_models/detail_view_model.dart';
import 'package:hotels/view_models/home_view_model.dart';
import 'package:hotels/views/details_view.dart';
import 'package:hotels/views/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // backgroundColor: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => ChangeNotifierProvider(
              child: const HomeView(),
              create: (BuildContext context) => HomeViewModel(context),
            ),
        '/hotel_details': (BuildContext context) => ChangeNotifierProvider(
            child: const DetailsView(),
            create: (BuildContext context) {
              // print(args);
              return DetailsViewModel(context);
            })
      },
    );
  }
}
