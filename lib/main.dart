import 'package:flutter/material.dart';
import 'package:flutterlearning/Layouts/Testlayout.dart';
void main()
{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  // constructor
  // build

  @override
  Widget build(BuildContext context)
  {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}