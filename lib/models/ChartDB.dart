class LibraryDB{

  String _libraryID;
  int _numOfBooks;

  LibraryDB(this._libraryID,this._numOfBooks);

  set libraryID(String id){
    this._libraryID = id;
  }

  set numOfBooks(int num){
    this.numOfBooks = num;
  }

  get libraryID => this._libraryID;

  get numOfBooks => this._numOfBooks;

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
  
    map['libraryID'] = _libraryID;
    map['numOfBooks'] = _numOfBooks;
  }

  //Exact Object in to map object
  LibraryDB.fromMapObject(Map<String,dynamic> map){
    this._libraryID = map['libraryID'];
    this._numOfBooks = map['numOfBooks'];
    
  }


}


class BookNumDB{

  String _date;
  int _numOfPages;

  BookNumDB(this._date,this._numOfPages);

  set date (String date){
    this._date = date;
  }

  set numOfPages(int num){
    this._numOfPages = num;
  }

  get date => this._date;

  get numOfPages => this._numOfPages;

}