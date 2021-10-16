class Products {
  int _id;
  String _name;
  String _title;
  String _avatar;
  int _price;
  int _category_id;
  String _description;


  Products(this._id , this._name , this._title , this._avatar , this._category_id ,this._price , this._description);


  String get description => _description;

  set description(String value) {
    _description = value;
  }

  int get price => _price;

  set price(int value) {
    _price = value;
  }

  String get name => _name;

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get avatar => _avatar;

  int get category_id => _category_id;

  set category_id(int value) {
    _category_id = value;
  }

  set avatar(String value) {
    _avatar = value;
  }
}
