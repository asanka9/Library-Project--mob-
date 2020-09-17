import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:library_app/models/BookModel.dart';
import 'package:library_app/models/CategoryModel.dart';
import 'package:library_app/models/LibraryModel.dart';
import 'package:library_app/models/UserModel.dart';
import 'package:library_app/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/services/HttpService.dart';

class GoLibrary extends StatefulWidget {
  @override
  _GoLibraryState createState() => _GoLibraryState();
}

class _GoLibraryState extends State<GoLibrary> {

  List<Library> libraries = []  ;
  String selectedValue ;
  String selectedCategoryName;
  HttpService service = HttpService();

  List<String> bokNames = ['qaqa','qaqa','qaqa','qaqa','qaqa','qaqa','qaqa','qaqa'];
  List<String> authorNames =['qaqa21','qa423qa','q5435aqa','q54aqa','q444aqa','q333aqa','q432aqa','qa4234qa'];
  List<String> bookState = ['YES','NO','YES','NO','NO','YES','YES','YES'];

 

  List<String> categories=['asanka12','asanka13','asanka14','asanka15','asanka16','asanka13','asanka14','asanka15','asanka16'];
  List<String> category_desc =['desc_01','desc_01','desc_01','desc_01','desc_01','desc_01','desc_01','desc_01','desc_01'];

    returnAllLibraries(String id) async {

    User user;
    final response = await http.get("http://10.0.2.2:8080/user/getUser/"+id);
    if (response.statusCode==200) {
      String responseString = response.body;
      user =  userFromJson(responseString);
    final res = await http.get("http://10.0.2.2:8080/user/returnLibs/"+user.lid);
    if (res.statusCode==200) {
      String responseString = res.body;
      List<dynamic> body = jsonDecode(responseString);
      List<Library> my = body.map((e) => Library.fromJson(e)).toList();
      setState(() {
        libraries = my;
        
      });
      selectedValue = libraries[0].id;
      
      
    }
    }



  }

  @override
  void initState() {
    
    this.returnAllLibraries(LoginForm.us.id);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Go Library',
          style: TextStyle(
            fontSize: 16
          ),
          ),
        backgroundColor: Colors.green,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                selectedValue = value;
              });
            },
            itemBuilder: (BuildContext context){
              return libraries.map((e){
                return PopupMenuItem(
                  value: e.id,
                  child: Text(e.name));
              }).toList();
            },
            )
        ]
      ),
      body: Padding(padding: EdgeInsets.all(12),
        child: FutureBuilder(
          future: service.returnAllCategories(selectedValue),
          builder: (BuildContext context, AsyncSnapshot  snapshot)  {
            if (snapshot.hasData) {
              List<Category> orders = snapshot.data;
              return ListView(
                
                children: orders.map((e) => 
                 Card(
              child: ListTile(
                title: Text(
                   e.categoryname,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                subtitle: Text(e.description),
                onTap: () {
                  setState(() {
                    selectedCategoryName = e.categoryname;
                  });
                  showCategories(context);
                },
              ),
            )              
                ).toList(),
              );

            }
            return LoginForm.us.lid==null?Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Hi Userrrr')
                ],
              ),
            ): Center(
              child: CircularProgressIndicator(),
            );
          }
          
          
          ),
      
      ),
    );
  }

/*
 Card(
                  child: ListTile(
                  leading: Icon(
                    Icons.book,
                    color: Colors.blueAccent,
                  ),
                  title: Text(categories[e],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey
                    ),
                  ),
                  subtitle: Text(category_desc[e]),
                  onTap: (){
                    
                    showCategories(context);
                  },
                ),
                );

 */
  showCategories(BuildContext context){
    showModalBottomSheet(
      
      context: context, 
      builder: (BuildContext context){
        return Container(
          
          color: Color(0xFF737373),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              )
            ),
            child: FutureBuilder(
          future: service.returnBooksWithCategory(selectedCategoryName,selectedValue),
          builder: (BuildContext context, AsyncSnapshot  snapshot)  {
            if (snapshot.hasData) {
              List<Book> orders = snapshot.data;
              return ListView(
                
                children: orders.map((e) => 
              Container(
              margin: EdgeInsets.only(
                bottom: 4
              ),
              color: Colors.black12,
              
              child: ListTile(
                title: Text(
                   e.name,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                subtitle: Text(e.authorname),
                
              ),
            )              
                ).toList(),
              );

            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          
          
          ),
          )
        );
      }
      );
  }
}

/*

ListTile(

                title: Text(bokNames[index],
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(authorNames[index]),
                onTap: (){},
              );

 */