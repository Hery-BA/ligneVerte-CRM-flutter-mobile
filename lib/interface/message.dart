import 'package:croix_rouge/interface/insert_message.dart';
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
                  height: 620,
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 350,
                          child: _textfield(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: const Color.fromARGB(255, 244, 67, 54)),
                          child: const IconButton(
                              onPressed: null, icon: Icon(Icons.send)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const insert_message()))
        },
        tooltip: 'add client',
        child: const Icon(Icons.person_add_alt),
      ),
    );
  }

  final _controler = TextEditingController();
  int _countWords({required String text}) {
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) {
      return 0;
    } else {
      return trimmedText.split(RegExp("\\s+")).length;
    }
  }

  _textfield() => TextField(
        controller: this._controler,
        minLines: 1,
        maxLines: 10,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          //counterText: '${_countWords(text: this._controler.text)}',
          labelText: 'Message',
          alignLabelWithHint: true,
          hintText: 'Tapez votre message ici...',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
        onChanged: (text) => setState(() {}),
      );
}
