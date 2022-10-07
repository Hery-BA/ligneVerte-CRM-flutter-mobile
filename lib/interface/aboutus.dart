import 'package:flutter/material.dart';
class Aboutus extends StatefulWidget {
  const Aboutus({ Key? key }) : super(key: key);

  @override
  State<Aboutus> createState() => _ProjectState();
}

class _ProjectState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('A propos'),
      )
      
    );
  }
}