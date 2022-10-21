import 'package:croix_rouge/models/project_model.dart';
import 'package:croix_rouge/models/region_model.dart';
import 'package:croix_rouge/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
//import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _ProjectState();
}

class _ProjectState extends State<Message> {
  //======================les variables===============================
  String idProj = '';
  String idRegion = '';
  String status = 'En attente';
  String daate = '____-__-__';
  int? _radioval = 0;
  DatabaseHelper? _dbHelper;
  //=====================les listes==================================
  List<String> list = ['salama', 'salut', 'akory', 'hallo'];
  List<Map<String, dynamic>> listmap = [];
  List<ProjectModel> listeProject = [];
  List<RegionModel> listeRegion = [];
  //====================xxx xxxxx====================================
  //====================les fonctions================================
  afficherlisteProjectETregion() async {
    List<ProjectModel> pmdl = await _dbHelper!.fetchProjects();
    List<RegionModel> Rmdl = await _dbHelper!.afficherRegion();
    setState(() {
      listeProject = pmdl;
      listeRegion = Rmdl;
      print(listeProject);
    });
  }

  afficher() {
    for (int i = 0; i < list.length; i++) {
      print(list[i]);
    }
  }

  Future afficherddd() async {
    var s = await showRoundedDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year + 20),
        borderRadius: 16,
        theme: ThemeData(primaryColor: Colors.red, accentColor: Colors.red));
    print(s);
    if (s != null) {
      setState(() {
        daate = s.toString();
      });
    }
  }

  verifStatus() {
    if (_radioval == 0) {
      setState(() {
        status = 'En attente';
        print(status);
      });
    } else if (_radioval == 1) {
      setState(() {
        status = 'En cours';
        print(status);
      });
    } else if (_radioval == 2) {
      setState(() {
        status = 'Termine';
        print(status);
      });
    }
  }

//================================xx xxxxxx==================================================
//===========================Corps de l'interface message====================================
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
    afficherlisteProjectETregion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Messages'),
      ),
      body: _FormulaireCard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {afficher()},
        tooltip: 'add client',
        child: const Icon(Icons.person_add_alt),
      ),
    );
  }

//=======================================xxxxxxxxxxxxxxxxxxxxxxxxxx===============================================================================================
//=======================================les widgets============================================================================
  final _controler = TextEditingController();
  int _countWords({required String text}) {
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) {
      return 0;
    } else {
      return trimmedText.split(RegExp("\\s+")).length;
    }
  }

  // ignore: non_constant_identifier_names
  _FormulaireCard() => Center(
        child: Card(
          color: Colors.white,
          elevation: 30.0,
          child: SizedBox(
            height: 600,
            width: 360,
            child: _Contenuformulaire(),
          ),
        ),
      );
  _Contenuformulaire() => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            Container(
                alignment: Alignment.center,
                child: const Text(
                  'veillez remplir',
                  style: TextStyle(fontSize: 30),
                )),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text('Id project :'),
                const SizedBox(
                  width: 140,
                ),
                DropdownButton<String>(
                    hint: Text(idProj.toString()),
                    menuMaxHeight: 200,
                    items: List<DropdownMenuItem<String>>.generate(
                        listeProject.length, (index) {
                      return DropdownMenuItem(
                          value: listeProject.isNotEmpty
                              ? listeProject[index].id.toString()
                              : '',
                          child: Text(listeProject[index].id.toString()));
                    }).toList(),
                    onChanged: (String? newvalue) {
                      setState(() {
                        idProj = newvalue.toString();
                        print('value = $newvalue');
                      });
                    })
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text('Id region :'),
                const SizedBox(
                  width: 140,
                ),
                DropdownButton<String>(
                    hint: Text(idRegion.toString()),
                    menuMaxHeight: 200,
                    items: List<DropdownMenuItem<String>>.generate(
                        listeRegion.length, (index) {
                      return DropdownMenuItem(
                          value: listeRegion.isNotEmpty
                              ? listeRegion[index].idreg.toString()
                              : '',
                          child: Text(listeRegion[index].idreg.toString()));
                    }).toList(),
                    onChanged: (String? newvalue) {
                      setState(() {
                        idRegion = newvalue.toString();
                        print('value = $newvalue');
                      });
                    })
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: false,
                prefixIcon: Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 8.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
                hintText: 'Name',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: false,
                prefixIcon: Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 8.0),
                  child: Icon(
                    Icons.title,
                    color: Colors.black,
                  ),
                ),
                hintText: 'Titre',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: false,
                prefixIcon: Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 8.0),
                  child: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                ),
                hintText: 'tel',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.date_range,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 14,
                ),

                TextButton(
                    onPressed: () => afficherddd(),
                    child: Text(
                      daate.substring(0, 10),
                      style: const TextStyle(color: Colors.black),
                    )),
                // Column(
                //   children: ['En attemte','en cours','terminer'].map(
                //     (int index) => Radio<String>(
                //     value: index,
                //      groupValue: groupValue, onChanged: onChanged)),
                // )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            _radiobitt(),
            const SizedBox(
              height: 10,
            ),
            _textfield_button(),

            // _dateTime(),
          ],
        ),
      );
  // ignore: non_constant_identifier_names
  _textfield_button() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 280,
            child: _textfield(),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: const Color.fromARGB(255, 244, 67, 54)),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.send)),
          )
        ],
      );

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

  _essai() => Stack(
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
      );

  _radiobitt() => Stack(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10, top: 10),
            child: Row(
              children: [
                Icon(Icons.task),
                Text('Status:'),
              ],
            ),
          ),

          //decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 30),
                child: Column(
                    children: [0, 1, 2]
                        .map((int index) => Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 70),
                              child: Radio<int>(
                                  value: index,
                                  groupValue: this._radioval,
                                  onChanged: (int? value) {
                                    if (value != null) {
                                      setState(() {
                                        this._radioval = value;
                                      });
                                      verifStatus();
                                    }
                                  }),
                            ))
                        .toList()),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 115, top: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Text('En Attente'),
                    SizedBox(
                      height: 32,
                    ),
                    Text('En cours'),
                    SizedBox(
                      height: 35,
                    ),
                    Text('Termine')
                  ],
                ),
              )
            ],
          ),
        ],
      );
//=========================================================xxxxxxxxxxxxxxxxx=====================================
}
