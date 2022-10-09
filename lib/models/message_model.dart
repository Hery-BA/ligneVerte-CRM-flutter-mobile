class MessageModel {
  int idMessage = 0;
  int idProject = 0;
  int idRegion = 0;
  String nomAppelant = '';
  String title = '';
  String tel = '';
  String date = '';
  String message = '';
  String statue = '';
  static const tableMessage = 'message';
  static const coloneIDMessage = 'idMessage';
  static const coloneIDProject = 'idProject';
  static const coloneIDRegion = 'idRegion';
  static const coloneNomAppelant = 'nomAppelant';
  static const coloneTitle = 'Titre';
  static const coloneTel = 'telephone';
  static const coloneDate = 'date';
  static const coloneMessage = 'message';
  static const coloneStatue = 'statue';

  MessageModel(
      {this.idMessage = 0,
      this.idProject = 0,
      this.idRegion = 0,
      this.nomAppelant = '',
      this.tel = '',
      this.title = '',
      this.date = '',
      this.message = '',
      this.statue = ''});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'idProject': idProject,
      'idRegion': idProject,
      'nomAppelant': idProject,
      'Titre': idProject,
      'telephone': idProject,
      'date': idProject,
      'message': idProject,
      'statue': idProject
    };
    if (idMessage != 0) map[coloneIDMessage] = idMessage;
    return map;
  }
}
