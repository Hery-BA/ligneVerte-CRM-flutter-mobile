class ProjectModel{
  static const tableProject = 'projects';
  static const coloneId ='id';
  static const coloneProjectName ='project_name';
  ProjectModel({ this.id=0, this.project_name=''});
  ProjectModel.fromMap(Map<String,dynamic> map) {
    id = map[coloneId];
    project_name=map[coloneProjectName];
  }
  int id=0;
  String project_name='';
  
  // ------------------
  Map<String,dynamic> toMap(){
    var map =<String,dynamic>{'project_name':project_name};
    if(id != 0) map[coloneId]=id;
    return map;
  }
}

