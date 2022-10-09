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
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RaisedButton(onPressed: null),
                  RaisedButton(onPressed: null)
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
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
