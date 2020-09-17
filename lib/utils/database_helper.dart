import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
//import 'package:lproject/models/BookDB.dart';
import 'package:library_app/models/BookDB.dart';

class Databasehelper{

  static Databasehelper _databasehelper; // Singleton Database helper
  //Here Singleton Object create ,this object instainsitae only once when application start to end
  static Database _database;

  String colId = 'id';
  String bookTable = 'mybook_table';
  String colBookId = 'bookId';
  String colNumOfBooks = 'numOfBooks';


  String chart01Table = 'chart_Table';
  String col01date = 'date';
  String col01num = 'numOfPages';


  String chart02Table = 'chart02_table';
  String col02library = 'librarynames';
  String col02nums = 'numOfDates';

  //When using Factory keyword i our constructor constructor will allow return some value
  factory Databasehelper(){


    if (_databasehelper== null) {
          //This is namely construco
    _databasehelper = Databasehelper._createInstance();
    }
    return _databasehelper;
  }

  Databasehelper._createInstance();
//
  void _createDb(Database db,int newVersion) async{
    await db.execute('CREATE TABLE $bookTable ($colNumOfBooks INTEGER,$colBookId TEXT)');

    await db.execute('CREATE TABLE $chart01Table ($col01num  INTEGER,$col01date TEXT)');

    await db.execute('CREATE TABLE $chart02Table ($col02nums INTEGER,$col02library TEXT)');

    

  }

  Future<Database> initializeDatabase()  async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'MyDB2.db';
    var bookDatabase = await openDatabase(path,version: 1,onCreate: _createDb);
    return bookDatabase;

  }

  Future<Database> get database async{

    if (_database==null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  //Functions for CRUD operations
  Future<int> getNumOfPages(BookDB bookDB) async{
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.query(bookTable,where: '$colBookId=?',whereArgs: [bookDB.bookId] );
    int num =Sqflite.firstIntValue(x);
    if (num==null) {
      String bookId = bookDB.bookId;
      int num =  bookDB.numOfPages;
      db.rawInsert('INSERT INTO  $bookTable ($colBookId,$colNumOfBooks)  VALUES ( ?,? )',['$bookId',num]);
      return num;
    } else {
      return num;
    }
    
  }

  Future<int> updateNumOfBooks(String bookId,int num) async {
    Database db = await this.database; 
    int updateCount = await db.rawUpdate('UPDATE  $bookTable SET $colNumOfBooks = ? WHERE $colBookId = ?',[num,'$bookId']);
  }

  //This For Chart 01
  //Create Current date
  Future<int> createDate(String date) async {
    debugPrint( 'This is a Date :::::::::::::::::::::::::'+ date);
    Database db = await this.database;
    List<Map<dynamic,dynamic>> x = await db.query(chart01Table,where: '$col01date=?',whereArgs: [date] );
    int num = Sqflite.firstIntValue(x);
    if (num==null) {
      db.rawInsert('INSERT INTO  $chart01Table ($col01date,$col01num)  VALUES ( ?,? )',[date,10]);
      debugPrint('AAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBCCCCCCCCCCCCCCCCCCCC');
    } else{
      debugPrint('NUMMM ::: '+num.toString());
    }
  } 

  Future<int> updateDateBookDetails(String date,int num) async {
    Database db = await this.database;
    List<Map<dynamic,dynamic>> x = await db.query(chart01Table,where: '$col01date=?',whereArgs: [date] );
    int n =Sqflite.firstIntValue(x) + num ;

    int updateCount = await db.rawUpdate('UPDATE  $chart01Table SET $col01num = ? WHERE $col01date = ?',[n,date]);
    List<Map<dynamic,dynamic>> x1 = await db.query(chart01Table,where: '$col01date=?',whereArgs: [date] );
    int num1 = Sqflite.firstIntValue(x1);
    debugPrint('YYYYYYYY  : '+num1.toString());
  }

  Future<List<Map<dynamic,dynamic>>> getAllChart01Details() async{
    Database db = await this.database;
    List<Map<dynamic,dynamic>> x = await db.rawQuery('SELECT * FROM $chart01Table');
    return x;
  }

  //This is for chart 02
  //add library to database
  chart02AddingDetails(String lid) async{
    Database db = await this.database;
    List<Map<dynamic,dynamic>> x = await db.query(chart02Table,where: '$col02library=?',whereArgs: [lid] );
    int num = Sqflite.firstIntValue(x);
    if (num==null) {
      db.rawInsert('INSERT INTO  $chart02Table ($col02library,$col02nums)  VALUES ( ?,? )',[lid,0]);
    } else {
      List<Map<dynamic,dynamic>> s = await db.query(chart02Table,where: '$col02library=?',whereArgs: [lid] );
      int n = Sqflite.firstIntValue(x);
      int m = n+1;
      await db.rawUpdate('UPDATE  $chart02Table SET $col02nums = ? WHERE $col02library = ?',[m,lid]);
    }
  }


  Future<List<Map<dynamic,dynamic>>> getAllChart02Details() async{
    Database db = await this.database;
    List<Map<dynamic,dynamic>> x = await db.rawQuery('SELECT * FROM $chart02Table');
    return x;
  }


}