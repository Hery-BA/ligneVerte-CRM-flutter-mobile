import 'dart:io';
import 'package:croix_rouge/models/project_model.dart';
import 'package:croix_rouge/models/region_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper{
  static const _nomBasededonne='DBCRM';
  static const _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  Database? _database;
  Future<Database?> get database async{
    if (_database != null)return _database;
    _database =await _initDatabase();
    return _database;
  }
  
  _initDatabase()async{
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path,_nomBasededonne);
   return await openDatabase(dbPath,version: _databaseVersion,onCreate: _onCreateDb,);
  }
 
  //============PROJECT TABLE==============
  _onCreateDb(Database db, int version)async{
    await db.execute('''CREATE TABLE ${ProjectModel.tableProject}(
      ${ProjectModel.coloneId} INTEGER PRIMARY KEY  AUTOINCREMENT,
      ${ProjectModel.coloneProjectName} TEXT NOT NULL
    )
'''); db.execute('''CREATE TABLE ${RegionModel.tableRegion}(
      ${RegionModel.coloneId} INTEGER PRIMARY KEY  AUTOINCREMENT,
      ${RegionModel.coloneRegionName} TEXT NOT NULL
    )''');
  }
 Future onDropdb(ProjectModel projectModel)async{
   Database? db = await database;
  return await db!.execute('''DROP TABLE ${ProjectModel.tableProject}''');
} 
//  Future oncreateTable(ProjectModel projectModel)async{
//    Database? db = await database;
//   return await db!.execute('''CREATE TABLE ${ProjectModel.tableProject}(
//       ${ProjectModel.coloneId} INTEGER PRIMARY KEY AUTOINCREMENT,
//       ${ProjectModel.coloneProjectName} TEXT NOT NULL
//     )
// ''');
// } 
//=============INSERTPROJECT======================
  Future <int> insertProject(ProjectModel projectModel)async{
    Database? db = await database;
    return await db!.insert(ProjectModel.tableProject, projectModel.toMap());

  }
   Future <int>insertRegion(RegionModel region)async{
    Database? db = await database;
    return await db!.insert(RegionModel.tableRegion, region.toMap());
  }
//============UPDATEPROJECT=============================
   Future <int> updateProject(ProjectModel projectModel)async{
    Database? db = await database;
    return await db!.update(ProjectModel.tableProject, projectModel.toMap(),
    where: '${ProjectModel.coloneId}=?',whereArgs:[projectModel.id]);

  }
   Future <int>updateRegion(RegionModel region)async{
    Database? db = await database;
    return db!.update(RegionModel.tableRegion, region.toMap(),
    where:'${RegionModel.coloneId}=?',
    whereArgs: [region.idreg]);
  }
  //===============DELETEPROJECT==========================
  Future<int>delete(int id)async{
    Database? db = await database;
    return await db!.delete(ProjectModel.tableProject,where: '${ProjectModel.coloneId}=?',whereArgs: [id]);
  }
  //======================DROP TABLE REGION================================
    supprimtable(RegionModel region)async{
    Database? db = await database;
    return await db!.execute('''DROP TABLE ${RegionModel.tableRegion}''');
  }
  //======================DROP TABLE PROJECT================================
  Future <int> deleteproject(ProjectModel projectModel)async{
    Database? BD = await database;
    int num =0;
    return await BD!.delete(ProjectModel.tableProject);
  }
//======================DELETE REGION================================`
    Future <int>deleteRegion(int id)async{
    Database? db = await database;
    return db!.delete(RegionModel.tableRegion,where: '${RegionModel.coloneId}=?',whereArgs: [id]);
  }
  //==================AFFICHE PROJECT=======================
  Future<List<ProjectModel>> fetchProjects()async{
    Database? db = await database;
    List<Map> pRojects = await db!.query(ProjectModel.tableProject);
    return pRojects.length==0 ? [] : pRojects.map((e) => ProjectModel.fromMap(e as Map<String,dynamic>)).toList();
  }
  //======================AFFICHE REGION================================
    Future <List<RegionModel>>afficherRegion(RegionModel region)async{
    Database? db = await database;
    List<Map> allregion = await db!.query(RegionModel.tableRegion);
    return  allregion.length==0 ?[]:allregion.map((e) => RegionModel.fromMap(e as Map<String,dynamic>)).toList();
  }
  //=================REGION TABLE=========================
  //   encreanTablereg(RegionModel region)async{
  //   Database? db = await database;
  //   return await db!.execute('''CREATE TABLE ${RegionModel.tableRegion}(
  //     ${RegionModel.coloneId}INTEGER PRIMARY KEY AUTOINCREMENT,
  //     ${RegionModel.tableRegion}TEXT NOT NULL
  //   )''');
  // }
 

}