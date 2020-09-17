import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_app/models/BookDB.dart';
import 'package:library_app/models/OrderModel.dart';
import 'package:library_app/models/UserModel.dart';
import 'package:library_app/screens/login.dart';
import 'package:library_app/services/HttpService.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/utils/database_helper.dart';



class Books extends StatefulWidget {
  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {

  List bookNames = ['Madolduwa','Hathpana','Titanic','ABC'];
  HttpService service = HttpService();
  Map<String,int> bookDBMap = Map();

  Databasehelper databasehelper = Databasehelper();
  String current_date;

  bool checkBadUser ;

  addDataToCharts() async { 
   var now = new DateTime.now();
   //int formatYear01 = int.parse(formatYear.format(now));
   var formatter = new DateFormat('yyyy MM dd');
   current_date = formatter.format(now);
   await databasehelper.createDate(current_date);
    //Chart 02
  }



  @override
 initState() {
    
    this.checkBadUser = false;
    databaseOperation();
    addDataToCharts();
    

    
  }


  databaseOperation() async {
    User user;
    final response = await http.get("http://10.0.2.2:8080/user/getUser/"+LoginForm.us.id);
    if (response.statusCode==200) {
      String responseString = response.body;
      user =  userFromJson(responseString);
      
    final res = await http.get("http://10.0.2.2:8080/mobile/returnBooks/"+user.lid+"/"+user.nic);
    debugPrint("http://10.0.2.2:8080/mobile/returnBooks/"+user.lid+"/"+user.nic);
      if (res.statusCode==200) {
      String responseString = res.body;
      List<dynamic> body = jsonDecode(responseString);
      List<Order> orders = body.map((e) => Order.fromJson(e)).toList();
      Map<String,int> tempBookDBMap = Map();
      for (var item in orders) {
        //
        BookDB bookDB = BookDB(item.id, 0);
        int tempNum = await databasehelper.getNumOfPages(bookDB);

        //This is where we need add Sqflite data 
        tempBookDBMap[item.id] = tempNum;
      }
      setState(() {
        bookDBMap = tempBookDBMap;
      });
    }else{
      
    }
    var tempLidList = user.lid.split(' ');
    for (var item in tempLidList) {
      debugPrint('LLLLLLLLLLLLLLLLL   : '+item);
      databasehelper.chart02AddingDetails(item);
    }
    
    }
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      child: Padding(
        padding: EdgeInsets.all(8), 
        child: FutureBuilder(
          future: service.getBorrowedBooks(LoginForm.us.id),
          builder: (BuildContext context, AsyncSnapshot  snapshot)  {
            if (snapshot.hasData) {
              List<Order> orders = snapshot.data;
              return ListView(
                children: orders.map((e) => 
                 Card(
              child: ListTile(
                title: Text(
                   e.bookname,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                subtitle: Row(
                  children: <Widget>[
                    Text(e.authorname),
                    SizedBox(width: 5,),
                    //'| '+e.countdays.toString()+' days left'
                    Text(e.countdays>0?'| '+e.countdays.toString()+' days left':'| '+(-e.countdays).toString()+' days post')
                  ],
                ),
                trailing: Column(
                  children: <Widget>[
                     InkWell(
                       child: Icon(
                        Icons.arrow_drop_up,
                        color: Colors.blueAccent,
                      ),
                      onTap: (){
                        incrementNumbers(e.id);
                        
                      },
                     ),
                    InkWell( 
                      child: Text(
                       bookDBMap[e.id].toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent
                      ),
                      ),
                      onTap: (){
                        createNumberAlertDialog(context,e.id);
                      },
                    )
                  ],
                ),
              ),
            )
  
                
                ).toList(),
              );

            }
            return LoginForm.us.lid == null? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Welcome New User !')
                ],
              ),
            ): Center(
              child: CircularProgressIndicator(),
            );
          }
          
          )
          
          
        ),
    );
  }


    createNumberAlertDialog(BuildContext context,String bookId){
      TextEditingController textController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Add number of pages here'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold
                ),
                ),
              elevation: 5.0,
              onPressed: (){
                databasehelper.updateNumOfBooks(bookId, int.parse(textController.text));
                int a1 = bookDBMap[bookId];
                setState(() {
                  bookDBMap[bookId]=int.parse(textController.text);
                  Navigator.of(context).pop();
                });
                 
                 int val = int.parse(textController.text) - a1;
                 databasehelper.updateDateBookDetails(current_date, val);
              }
              )
          ],
        );
      }
    );
  }

  incrementNumbers(String bookId){
     databasehelper.updateNumOfBooks(bookId, bookDBMap[bookId]+1);
    setState(() {
      bookDBMap[bookId]++;
    });
    databasehelper.updateDateBookDetails(current_date, 1);
  }
}