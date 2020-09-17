import 'package:flutter/material.dart';
import 'package:library_app/screens/login.dart';
import 'package:library_app/screens/login.dart';
import 'package:library_app/services/HttpService.dart';
import 'package:library_app/models/UserModel.dart';


class ChangeAccountSetting extends StatefulWidget {
  @override
  _ChangeAccountSettingState createState() => _ChangeAccountSettingState();
}

class _ChangeAccountSettingState extends State<ChangeAccountSetting> {


  List <String> logOut =  ['Log Out'];
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  User newUser;

  @override
  void initState() {
    
    newUser = LoginForm.us;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Account Setting',
          style: TextStyle(
            fontSize: 16
          ),
          ),
          backgroundColor: Colors.purple,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white70,
                ), 
              onPressed: (){
                newUser.address == '--'? updateUser():updateUser01();
                updateUser();
              }),
              /*
              itemBuilder: (BuildContext context){
              return libraries.map((e){
                return PopupMenuItem(
                  value: e.id,
                  child: Text(e.name));
              }).toList();
            },
              
              
               */
              PopupMenuButton(
                onSelected: (value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginForm()));
                },
                itemBuilder: (BuildContext context){
                  return logOut.map((e){
                    return PopupMenuItem(
                      value: 12,
                      child: Text(e));
                  }).toList();
                })
          ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
        children: <Widget>[
          
          SizedBox(
            height: 20,
          ),
         Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                         //accountName: Text(LoginForm.us.name), 
                      //accountEmail: Text(LoginForm.us.email),
              ],
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.purpleAccent,
              ),
              title: Text(LoginForm.us.name),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.purpleAccent
              ),
              title: TextField(
                controller: email,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 15,bottom: 11,top: 11,right: 15
                  ),
                  helperMaxLines: null,
                  hintText: newUser.email,
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey
                  )
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
                    Card(
            child: ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.purpleAccent
              ),
              title:newUser.address == '--'? TextField(
                controller: address,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 15,bottom: 11,top: 11,right: 15
                  ),
                  helperMaxLines: null,
                  hintText: newUser.address,
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey
                  )
                ),
              ):Text(LoginForm.us.address),
            ),
          ),
          SizedBox(
            height: 10,
          ),
                    Card(
            child: ListTile(
              leading: Icon(
                Icons.local_grocery_store,
                color: Colors.purpleAccent
              ),
              title: TextField(
                controller: password,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 15,bottom: 11,top: 11,right: 15
                  ),
                  helperMaxLines: null,
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey
                  )
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                Icons.info,
                size: 20,
                ),
                color: Colors.purple,
                onPressed: (){
                  showInformationBox(context);
                },
              ),
            ),
          ),
        ],
      ),
        ),
    );
  }

  showInformationBox(BuildContext context){
    var alertDialog = AlertDialog(
      
      elevation: 24,
      content: Container(
        child: ListView(
          children: <Widget>[
          Container(
          child: Container(
            child: Center(
              child: Text('data'),
            ),
            decoration: BoxDecoration(
              color: Colors.purpleAccent,
              
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100)
              )
            ),
          ),
          width: 200,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            
          ),
        )
          ],
        ),
      ),
      
    );
    showDialog(
      context: context,
      builder: (BuildContext context){
        return alertDialog;
      }
      );
  }
 
 updateUser()  {
     setState(() async {
      newUser= await  HttpService().updateUser(LoginForm.us.name, email.text, address.text, password.text);
     });
 }

  updateUser01()  {
    setState(() async {
      newUser= await  HttpService().updateUser(LoginForm.us.name, email.text, newUser.address, password.text);
     });
 }

}