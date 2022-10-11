import 'package:flutter/material.dart';

class insert_message extends StatefulWidget {
  const insert_message({Key? key}) : super(key: key);

  @override
  State<insert_message> createState() => _insert_messageState();
}

class _insert_messageState extends State<insert_message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Enregistrer message"),
      ),
    );
  }
}
