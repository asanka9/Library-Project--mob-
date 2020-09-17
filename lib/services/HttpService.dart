import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/models/BookModel.dart';
import 'package:library_app/models/CategoryModel.dart';
import 'package:library_app/models/LibraryModel.dart';
import 'package:library_app/models/OrderModel.dart';
import 'package:library_app/models/UserModel.dart';

class HttpService {
  final String postUrl = "http://localhost:8080/mobile";

  /*
    Future <List<Book>> getBooks() async {
    Response res = await get(postUrl);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      
    }
  }
   */
  /*
  Future<User> loginUser(String id,String password) async {
    final String url = "";
    Response response = await post(url,
      body: {
        "id" : id,
        "password" : password
      }
    );
    if (response.statusCode==200) {
      final String responseString = response.body;
      return userFromJson(responseString);
    }else{
      return null;
    }
  }
  */
  Future<User> loginUser(String id,String password) async {
    final res = await http.get("http://10.0.2.2:8080/mobile/login/"+id+"/"+password);
    if (res.statusCode==200) {
      String responseString = res.body;
      return userFromJson(responseString);
    }else{
      return null;
    }
  }

  Future<List<Order>> getBorrowedBooks( String userId) async {

    User user;
    final response = await http.get("http://10.0.2.2:8080/user/getUser/"+userId);
    if (response.statusCode==200) {
      String responseString = response.body;
      user =  userFromJson(responseString);
      
    final res = await http.get("http://10.0.2.2:8080/mobile/returnBooks/"+user.lid+"/"+user.nic);
      if (res.statusCode==200) {
      String responseString = res.body;
      List<dynamic> body = jsonDecode(responseString);
      List<Order> orders = body.map((e) => Order.fromJson(e)).toList();
      return orders;
    }else{
      
    }
    }
  }

  Future<List<Library>> returnAllLibraries(String lid) async {
    final res = await http.get("http://10.0.2.2:8080/user/returnLibs/"+lid);
    if (res.statusCode==200) {
      String responseString = res.body;
      List<dynamic> body = jsonDecode(responseString);
      List<Library> libraries = body.map((e) => Library.fromJson(e)).toList();
      return libraries;
    }else{
      throw 'can not get libariess';
    }
  }

  Future<List<Category>> returnAllCategories(String lid) async{
    final res = await http.get("http://10.0.2.2:8080/superUser/getCategories/"+lid);
    if (res.statusCode==200) {
      String responseString = res.body;
      List<dynamic> body = jsonDecode(responseString);
      List<Category> categories = body.map((e) => Category.fromJson(e)).toList();
      return categories;
    }else{
      throw 'can not get orders';
    }
  }

  Future<List<Book>> returnBooksWithCategory(String categoryName,String libId) async{
    final res = await http.get("http://10.0.2.2:8080/superUser/searchCategoryBook/"+categoryName+"/"+libId);
    if (res.statusCode==200) {
      String responseString = res.body;
      List<dynamic> body = jsonDecode(responseString);
      List<Book> books = body.map((e) => Book.fromJson(e)).toList();
      return books;
    }else{
      throw 'can not get orders';
    }
  }

  Future<List<Library>> addLibrary(String userId,String userpassword,
    String id,
    String email,
    String name,
    String password,
    String role,
    String mnumber,
    String lid,
    String address,
    String nic,
    String gender
  ) async{
    final res = await http.post("http://10.0.2.2:8080/user/addLibraries/"+userId+"/"+password,body: {
      "id":id,
     "email":email,
     "name":name,
     "password":password,
     "role":role,
     "mnumber":mnumber,
     "lid":lid,
     "address":address,
     "nic":nic,
     "gender":gender
    });
    if (res.statusCode==200) {
      String responseString = res.body;
      List<dynamic> body = jsonDecode(responseString);
      List<Library> libraries = body.map((e) => Library.fromJson(e)).toList();
      return libraries;
    }else{
      throw 'can not get orders';
    }

  }

  Future<User> updateUserDetails(String lid) async{
    
    final res = await http.get("http://10.0.2.2:8080/superUser/"+lid);
  }

  Future<User> createUser(String  name,String email,String password) async{
    final res = await http.get("http://10.0.2.2:8080/mobile/create/"+name+"/"+email+"/"+password);
    if ( res.statusCode ==200) {
      String responseString = res.body;
      return userFromJson(responseString);
    }else{
      throw 'can not get orders';
    }
  }

  //@GetMapping("update/{name}/{email}/{address}/{password}")
  Future updateUser(String name,String email,String address,String password) async{
    debugPrint("http://10.0.2.2:8080/mobile/update/"+name+"/"+email+"/"+address+"/"+password);
    final res = await http.get("http://10.0.2.2:8080/mobile/update/"+name+"/"+email+"/"+address+"/"+password);
    if ( res.statusCode ==200) {
      String responseString = res.body;
      return userFromJson(responseString);
    }
  }
}