class RegionModel{
  static const tableRegion = 'region';
  static const coloneId ='idREG';
  static const coloneRegionName ='region_name';
  RegionModel({this.idreg=0,this.nom_region=''});
  RegionModel.fromMap(Map<String,dynamic> map){
    idreg = map[coloneId];
    nom_region=map[coloneRegionName];
  }
  int idreg=0;
  String nom_region='';
   //------------------------------------
    Map<String,dynamic> toMap(){
    var map =<String,dynamic>{'region_name':nom_region};
    if(idreg != 0) map[coloneId]=idreg;
    return map;
  }
}