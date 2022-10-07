class Shelter{
  String _shelterProvince;
  String _shelterDetail;
  String _numberOfAnimals;
  String _shelterImage;

  Shelter(this._shelterProvince,this._shelterDetail,this._numberOfAnimals
      ,this._shelterImage,);

  String get shelterProvince => _shelterProvince;

  set shelterProvince(String value) {
    _shelterProvince = value;
  }

  String get shelterDetail => _shelterDetail;

  set shelterDetail(String value) {
    _shelterDetail = value;
  }

  String get numberOfAnimals => _numberOfAnimals;

  set numberOfAnimals(String value) {
    _numberOfAnimals = value;
  }

  String get shelterImage => _shelterImage;

  set shelterImage(String value) {
    _shelterImage = value;
  }
}



