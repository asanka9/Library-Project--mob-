class BookDB{


  int _id;
  String _bookId;
  int _numOfPages;

  BookDB(
    this._bookId,this._numOfPages
  );

  BookDB.withId(this._id,this._bookId,this._numOfPages);

  String get bookId => _bookId;

  int get numOfPages => _numOfPages;

  set bookId(String id){
    this._bookId = id;
  }

  set numOfPages(int num){
    this._numOfPages = num;
  }

  //Convert node object in to map object
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['bookId'] = _bookId;
    map['numOfPages'] = _numOfPages;
  }

  //Exact Object in to map object
  BookDB.fromMapObject(Map<String,dynamic> map){
    this._id = map['id'];
    this._bookId = map['bookId'];
    this._numOfPages = map['numOfPages'];
  }

}