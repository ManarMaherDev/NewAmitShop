
class Category{
  int _Id;
   String _Name;
   String _Avatar ;
  Category(this._Id, this._Name, this._Avatar);

    String get Avatar => _Avatar;

  set Avatar(String value) {
    _Avatar = value;
  }

  String get Name => _Name;

  set Name(String value) {
    _Name = value;
  }

  int get Id => _Id;

  set Id(int value) {
    _Id = value;
  }
}