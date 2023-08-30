import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/bloc/karyawan/karyawan_bloc.dart';
import 'package:test_mobile/form_page.dart';
import 'package:test_mobile/list_page.dart';
import 'package:test_mobile/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => KaryawanBloc(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            '/form': (context) => FormPage(),
            '/list': (context) => ListPage(),
            // Add more routes here
          },
        ));
  }
}
