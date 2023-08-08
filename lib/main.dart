import 'package:flutter/material.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/screens/loading_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataRepository(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Not Netflix',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LoadingScreen()),
    );
  }
}
