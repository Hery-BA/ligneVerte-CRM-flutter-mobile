import 'package:flutter/material.dart';
class Statistique extends StatefulWidget {
  const Statistique({ Key? key }) : super(key: key);

  @override
  State<Statistique> createState() => _ProjectState();
}

class _ProjectState extends State<Statistique> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Statistique'),
      )
      
    );
  }
}