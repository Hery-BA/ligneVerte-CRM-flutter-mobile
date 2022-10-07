import 'package:croix_rouge/models/region_model.dart';
import 'package:flutter/material.dart';

import '../utils/database_helper.dart';
class Region extends StatefulWidget {
  const Region({ Key? key }) : super(key: key);

  @override
  State<Region> createState() => _RegionState();
}

class _RegionState extends State<Region> {
DatabaseHelper? _dbHelper;
final _formKey =GlobalKey<FormState>();
final _onselectedName = TextEditingController();
RegionModel _regionModel=RegionModel();
List<RegionModel> _regionList=[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dbHelper=DatabaseHelper.instance;
    });
    _enActualisant();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Regions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _form(),_list()
          ],
        ),
      ),
      
    );
  }
  _enActualisant()async{
     List<RegionModel> x = await _dbHelper!.afficherRegion(_regionModel);
    setState(() {
      _regionList = x;
    });
  }
  _onreset()async{
    setState(() {
      _formKey.currentState!.reset();
      _onselectedName.clear();
      _regionModel.idreg=0;

    });
  }
   _enSupprimant()async{
    await _dbHelper!.deleteRegion(_regionModel.idreg);
    _enActualisant();
  }
  _supprimtable()async{
    await _dbHelper!.supprimtable(_regionModel);
    _enActualisant();
  }
  // _creertable()async{
  //   await _dbHelper!.encreanTablereg(_region);
  //   print('table crer avec succes');
  // }
  _enAjoutant()async{
    var form =_formKey.currentState;
    if(form!.validate()){
    form.save();
    _regionModel.idreg==0? await _dbHelper!.insertRegion(_regionModel): await _dbHelper!.updateRegion(_regionModel);
    _enActualisant();
    _onreset();
  }
  }
    _form()=>Container(
    color:Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
    child:Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _onselectedName,
            decoration: const InputDecoration(labelText:'Nom de la Region'),
            onSaved:(val) => setState(()=>_regionModel.nom_region = val!),
            validator: (val)=>(val?.length==0?'veillez remplir':null),
          ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child:  RaisedButton(onPressed: ()=>_enAjoutant(),
              child: const Text('Ajouter'),
              color: Colors.red,
              textColor: Colors.black,),
              
            ),        
               Visibility(
                visible: false,
                 child: Column(
              children: <Widget>[
                       Container(              
              margin: const EdgeInsets.all(10.0),
              child:  RaisedButton(onPressed: ()=>_enSupprimant(),
              child: const Text('supprimer'),
              color: Colors.red,
              textColor: Colors.black,),
              
            ),
                 Container(
              margin: const EdgeInsets.all(10.0),
              child:  RaisedButton(onPressed: ()=>_supprimtable(),
              child: const Text('supprimerTABLE'),
              color: Colors.red,
              textColor: Colors.black,),
              
            ),
            //   Container(
            //   margin: const EdgeInsets.all(10.0),
            //   child:  RaisedButton(onPressed: ()=>_creertable(),
            //   child: const Text('cree table'),
            //   color: Colors.red,
            //   textColor: Colors.black,),
              
            // )
              ],
            ),
               )
         
        ],
      ),
    )
  );
    _list()=>Expanded(
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.add_task_rounded,
                color: Colors.red,size:40.0),
                title: Text(_regionList[index].nom_region.toUpperCase(),
                style: const TextStyle(color:Colors.red,fontWeight: FontWeight.bold),),
                subtitle: Text(_regionList[index].idreg.toString()),
                trailing:  IconButton(icon: const Icon(Icons.delete_sweep,color: Colors.black,),
                onPressed: ()async{
                  await _dbHelper!.deleteRegion(_regionList[index].idreg);
                  _onreset();
                  _enActualisant();
                  
                },),
                onTap: (){
                  setState(() {
                    _regionModel = _regionList[index];
                    _onselectedName.text = _regionModel.nom_region;
                  });
                }
              ),
              const Divider(
                height: 5.0,
              )
            ],
          );
        },
        itemCount: _regionList.length,
      ),
    ),
  );
}