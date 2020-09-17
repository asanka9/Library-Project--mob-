import 'package:flutter/material.dart';
import 'package:library_app/screens/login.dart';
import 'package:library_app/services/HttpService.dart';
import './navSlides/AddLibrary.dart';
import './navSlides/ChangeAccountSetting.dart';
import './navSlides/GoLibrary.dart';
import './navSlides/SerachBook.dart';
import './tabBarSlides/Books.dart';
import './tabBarSlides/Chart.dart';
import './navSlides/info.dart';

class MainMenu extends StatefulWidget {

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {


   HttpService service = HttpService();
   bool checkBadUser = false;


    checkingBadUserOrNotSendNotifications() async {
    var orderBooks = await service.getBorrowedBooks(LoginForm.us.id);
    if (orderBooks != null) {
          for (var item in orderBooks) {
          if (item.countdays<0) {
          setState(() {
            checkBadUser = true;
          });
      }
    }
    }
  }

  @override
  void initState() {
    checkingBadUserOrNotSendNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2, 
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[600],
              title: Text("e - Lib",
                style: TextStyle(
                  fontSize: 16
                ),
              ),
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    text: 'BOOKS',
                  ),
                  Tab(
                    text: 'CHART',
                  )
                ]
                ),
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 12, 5, 10),
                    width: 18,
                    child:Stack(
                     overflow: Overflow.visible,
                    children: <Widget>[
                      Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                      Positioned(
                        left: 13,
                        child: Container(
                          
                         child: Icon(
                           Icons.brightness_1,
                           color: checkBadUser? Colors.red:Colors.orangeAccent,
                           size: 10,
                         )
                        
                        ))
                    ],
                  ),
                  ),
                  SizedBox(
                    width: 12,
                  )
                ],
                
            ),
            body: TabBarView(

              children: [
                Books(),Chart()
              ]
              ),
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      /*            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              )
            ), */
                      decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    
                                    bottomRight: Radius.circular(70)
                                  ),
                                  gradient: LinearGradient(
                                   begin: Alignment.topCenter,
                                  colors: [
                                    Colors.blue[900],
                                    Colors.blue[700],
                                    Colors.blue[400]
                                        ]  
                               )
                      ),
                      accountName: Text(LoginForm.us.name), 
                      accountEmail: Text(LoginForm.us.email),
                      currentAccountPicture:  ClipOval(
                          
                          child: Image.asset(
                            LoginForm.us.gender == 'male'?'images/male.png': 'images/female.webp'
                            
                            )
                        ),
                     
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            left: 15
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(
                             // topLeft: Radius.circular(20),
                             topLeft: Radius.circular(20),
                             bottomLeft: Radius.circular(20),
                            )
                          ),
                          child: Container(
                            child:ListTile(
                        leading: Icon(
                          Icons.library_books,
                          color: Colors.green,
                        ),
                        title: Text('Go Library'),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>GoLibrary()));
                        },
                      ),
                          
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            left: 15
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(20),
                             bottomLeft: Radius.circular(20),
                            )
                          ),
                          child: 
		                    ListTile(
                        leading: Icon(
                          Icons.add_box,
                          color: Colors.orange,
                        ),
                        title: Text('Add Library'),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddLibrary()));
                        },
                      ),
                          
                        ),

                      SizedBox(
                        height: 15,
                        
                      ),
                    

                      Container(
                          margin: EdgeInsets.only(
                            left: 15
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(
                             // topLeft: Radius.circular(20),
                             topLeft: Radius.circular(20),
                             bottomLeft: Radius.circular(20),
                            )
                          ),
                          child:                       ListTile(
                        leading: Icon(
                          Icons.account_circle,
                          color: Colors.purple,
                        ),
                        title: Text('Change account setting'),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeAccountSetting()));
                        },
                      ),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                                            Container(
                          margin: EdgeInsets.only(
                            left: 15
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(
                             // topLeft: Radius.circular(20),
                             topLeft: Radius.circular(20),
                             bottomLeft: Radius.circular(20),
                            )
                          ),
                          child:                       ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: Colors.black87,
                        ),
                        title: Text('About us'),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Information()));
                        },
                      ),
                        ),
                      SizedBox(
                        height: 35,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'version : 1.000 v',
                              style: TextStyle(
                                color: Colors.black12,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                              ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('All Right Reserved @ e-Lib (pvt) LTD',
                                style: TextStyle(
                                color: Colors.black12,
                                fontWeight: FontWeight.bold,
                                fontSize: 13
                              ),
                              )
                          ],
                        ),
                      )


                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                tooltip: 'Search book you already registered libraries',
                backgroundColor: Colors.orange,
                child: Icon(
                  Icons.search,
                  
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchBook()));
                }),
          )
          )
        ),
    );
  }


}