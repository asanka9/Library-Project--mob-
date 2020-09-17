import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:library_app/models/UserModel.dart';
import 'package:library_app/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/models/BookModel.dart';


class SearchBook extends StatefulWidget {
  @override
  _SearchBookState createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  List<String> bokNames = ['qaqa','qaqa','qaqa','qaqa','qaqa','qaqa','qaqa','qaqa'];
  List<String> authorNames =['qaqa21','qa423qa','q5435aqa','q54aqa','q444aqa','q333aqa','q432aqa','qa4234qa'];
  List<Book> searchBooks = [];

  String bookName;
  bool absorbButton = true;

  TextEditingController textController = TextEditingController();

  databaseOperation(String bookName) async {
    User user;
    final response = await http.get("http://10.0.2.2:8080/user/getUser/"+LoginForm.us.id);
    if (response.statusCode==200) {
      String responseString = response.body;
      user =  userFromJson(responseString);
       
    final res = await http.get("http://10.0.2.2:8080/mobile/searchAnyBook/"+user.id+"/"+bookName); 
    if (res.statusCode==200) {
      String resString = res.body;
      List<dynamic> body = jsonDecode(resString);
      setState(() {
            searchBooks = body.map((e) => Book.fromJson(e)).toList();
      });

    }else{
      
    }

    
    }
  }





  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Book',
          style: TextStyle(
            fontSize: 16
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFixedExtentList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 12,
                ),
                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Search with book name',
 
                    ),
                  onSubmitted: (value) {
                    setState(() {
                      absorbButton = false;
                    });
                  },
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
         
       
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: 
                  
                  AbsorbPointer(
                      absorbing: absorbButton,
                      child: RaisedButton.icon(
                      color: Colors.deepOrangeAccent,
                      onPressed: (){
                        debugPrint('THIS IS BOOK NAME  ::::::::::::::::::::::::: '+textController.text);
                        databaseOperation(textController.text);
                        showBooks(context);
                      }, 
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        ), 
                      label: Text(
                        'search',
                        style: TextStyle(
                          color: Colors.white
                        ),
                        )
                        ),
                  ),
                ),
                
                
              ]
            ), 
            itemExtent: 30),

        ],
      )
    );
  }
    showBooks(BuildContext context){
    showModalBottomSheet(
      
      context: context, 
      builder: (BuildContext context){
        return 
         Container(
          
          color: Color(0xFF737373),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              )
            ),
            child:searchBooks.length>0? ListView.builder(
            itemCount: searchBooks.length,
            itemBuilder:  (BuildContext context,index){
              return ListTile(

                title: Text('Library Code : '+searchBooks[index].libraryid,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text('Book Location : '+searchBooks[index].blocation),
                onTap: (){},
              );
            }
            ):Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.search,
                    size:100,
                    color: Colors.black12,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('No Result Found',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                      fontSize: 15
                    ),
                  
                  ),
                ],
              )
            ),
          )
        );
      }
      );
  }
}