import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _ProjectState();
}

class _ProjectState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Messages'),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                //hasiana zavatra
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 600,
                ),
                _textfield()
              ],
            ),
          )
        ],
      ),
    );
  }

  _textfield() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'tapez ici',
          labelText: 'votre message',
        ),
      );
}
