import 'package:croix_rouge/models/project_model.dart';
import 'package:croix_rouge/utils/database_helper.dart';
import 'package:flutter/material.dart';

class Project extends StatefulWidget {
  const Project({Key? key}) : super(key: key);

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  final _formKey = GlobalKey<FormState>();
  final _onselectedName = TextEditingController();
  ProjectModel _projectModel = ProjectModel();
  List<ProjectModel> _projects = [];
  String etatBoutton = 'Ajouter';
  DatabaseHelper? _dbHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
    _enActualisant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Projets'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_form(), _list()],
        ),
      ),
    );
  }

  _form() => Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _onselectedName,
              decoration: const InputDecoration(labelText: 'Nom du projet'),
              onSaved: (val) =>
                  setState(() => _projectModel.project_name = val!),
              validator: (val) => (val?.length == 0 ? 'veillez remplir' : null),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () => _enAjoutant()(),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: Text(
                  etatBoutton,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Visibility(
                visible: false,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () => _enSupprimant(),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        child: const Text(
                          'supprimer',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () => _supprimtable(),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        child: const Text(
                          'supprimertable',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    //   Container(
                    //   margin: const EdgeInsets.all(10.0),
                    //   child:  RaisedButton(onPressed: ()=>_creertable(),
                    //   child: const Text('cree table'),
                    //   color: Colors.red,
                    //   textColor: Colors.black,),

                    // )
                  ],
                )),
          ],
        ),
      ));

  _enActualisant() async {
    List<ProjectModel> x = await _dbHelper!.fetchProjects();
    setState(() {
      _projects = x;
      print(_projects);
      etatBoutton = 'Ajouter';
    });
  }

  _enAjoutant() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      _projectModel.id == 0
          ? await _dbHelper!.insertProject(_projectModel)
          : await _dbHelper!.updateProject(_projectModel);
      _enActualisant();
      // setState(() {
      //   _projects.add(ProjectModel(id:0,project_name: _projectModel.project_name));
      // });
      _onreset();
    }
  }

  _onreset() {
    setState(() {
      _formKey.currentState!.reset();
      _onselectedName.clear();
      _projectModel.id = 0;
    });
  }

  _enSupprimant() async {
    await _dbHelper!.deleteproject(_projectModel);
    _enActualisant();
  }

  _supprimtable() async {
    await _dbHelper!.onDropdb(_projectModel);
    _enActualisant();
  }

  // _creertable()async{
  //   await _dbHelper!.oncreateTable(_projectModel);
  //   _enActualisant();
  // }
  _list() => Expanded(
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.add_task_rounded,
                          color: Colors.red, size: 40.0),
                      title: Text(
                        _projects[index].project_name.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(_projects[index].id.toString()),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_sweep,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          await _dbHelper!.delete(_projects[index].id);
                          _onreset();
                          _enActualisant();
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _projectModel = _projects[index];
                          etatBoutton = 'Modifier';
                          _onselectedName.text = _projectModel.project_name;
                        });
                      }),
                  const Divider(
                    height: 5.0,
                  )
                ],
              );
            },
            itemCount: _projects.length,
          ),
        ),
      );
}
