import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/models/UserModel.dart';
import 'package:library_app/services/HttpService.dart';
import './mainMenu.dart';


class LoginForm extends StatefulWidget {
  static User us = _LoginFormState.user;
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  HttpService service = HttpService();
  static User user;
  bool errorWithCredintial = false;
  bool errorWithSign = false;


  _LoginFormState(){
    errorWithCredintial = false;
    errorWithSign = false;
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue[900],
              Colors.blue[700],
              Colors.blue[400]
            ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                     'e - Lib',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 40.0
                     ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Welcome e-Lib,enjoy your self',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              ),
            Expanded(
             child: Container(
              width: double.infinity,
               child: Padding(
                 padding: EdgeInsets.all(20),
                 child: ListView(
                   children: <Widget>[
                     
                     SizedBox(
                       height: 10,
                     ),
                     TextField(
                       controller: idController,
                       decoration: InputDecoration(
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: Colors.blue
                           ),
                           borderRadius: BorderRadius.all(Radius.circular(25))
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: Colors.blue
                           ),
                           borderRadius: BorderRadius.all(Radius.circular(25))
                         ),
                         prefixIcon: Icon(
                           Icons.account_circle,
                           color: Colors.blue,
                           
                         ),
                         hintText: 'user name',
                         hintStyle: TextStyle(
                           color: Colors.blue
                         )
                       ),
                     ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: passwordController,
                       decoration: InputDecoration(
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: Colors.blue
                           ),
                           borderRadius: BorderRadius.all(Radius.circular(25))
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: Colors.blue
                           ),
                           borderRadius: BorderRadius.all(Radius.circular(25))
                         ),
                         prefixIcon: Icon(
                           Icons.enhanced_encryption,
                           color: Colors.blue,
                           
                         ),
                         hintText: 'password',
                         hintStyle: TextStyle(
                           color: Colors.blue
                         )
                       ),
                     ),
                     errorWithCredintial ?
                     Padding(padding: EdgeInsets.only(
                       top: 5
                     ),
                     child: Align(
                       alignment: Alignment.center,
                       child: Text('Invalid Credintial',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent
                        ),
                       ),
                     ),
                     )
                     :SizedBox(),
                     SizedBox(
                       height: 30,
                     ),
                     Material(
                       borderRadius: BorderRadius.circular(12.0),
                       color: Colors.blueAccent,
                       child: MaterialButton(
                         child: Text(
                           'Login',
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 15.0
                           ),
                           ),
                         onPressed: () async {
                           User u = await service.loginUser(idController.text, passwordController.text);
                           if (u !=null) {
                             setState(() {
                               user = u;
                             });
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>MainMenu()));
                           }else{
                             setState(() {
                               errorWithCredintial = true;
                             });
                           }
                           
                         })
                     ),
                    SizedBox(
                       height: 12,
                     ),
                     Material(
                       borderRadius: BorderRadius.circular(12.0),
                       color: Colors.orangeAccent,
                       child: MaterialButton(
                         child: Text(
                           'Sign Up !',
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 15.0
                           ),
                           ),
                         onPressed: (){
                           showSignAlertBox(context);
                         })
                     ),
                     SizedBox(
                       height: 12.0,
                     ),
                     Center(
                       child: InkWell(
                         onTap: (){},
                         child: Text(
                           'www.e-lib.com',
                           style: TextStyle(
                             color: Colors.black54
                           ),
                           ),
                       ),
                     )
                   ],
                 ),
                 ),
               decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  
                  topRight: Radius.circular(60)
                )
                ),
              )
            )
          ],
        ),
      )
    );
  }


  void showSignAlertBox(BuildContext context){

    TextEditingController username = TextEditingController();
    TextEditingController emailAddress = TextEditingController();
    TextEditingController password = TextEditingController();

    bool isChecked = true;
    var alertDiaog = AlertDialog(
      title: Text(
        'Sign Up !',
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),
      ),
      content: ListView(
        children: <Widget>[
          Divider(
            height: 2,
            color: Colors.blueAccent,
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Enter user name',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87
            ),
            ),
          TextField(
            controller: username,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Enter email address',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87
            ),
            ),
          TextField(
            controller: emailAddress,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Enter password',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87
            ),
            ),
          TextField(
            controller: password,
          ),
          SizedBox(
            height: 15,
          ),
          errorWithSign?Container(
            color: Colors.redAccent,
            padding: EdgeInsets.all(12),
            child: Text(
              'user name already exits !',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              ),
          ):SizedBox(),
          OutlineButton.icon(
            onPressed: () async {
                  final res = await http.get("http://10.0.2.2:8080/mobile/create/"+username.text +"/"+emailAddress.text+"/"+password.text);
                  if ( res.statusCode ==200) {
                  String responseString = res.body;
                  User u = userFromJson(responseString);
                  setState(() {
                      user = u;  });
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>MainMenu()));   
                  Navigator.of(context).pop();
                      }else{
                    setState(() {
                      errorWithSign = true;
                    });
                    }
            }, 
            icon: Icon(
              Icons.supervisor_account,
              color: Colors.blue,
            ), 
            label: Text(
              'submit',
              style: TextStyle(
                color: Colors.blue
              ),
              )
            )
   
          
        ],
      ),
      elevation: 50,
      actions: <Widget>[
        Icon(
          Icons.close
        )
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext  context){
        return alertDiaog;
      }

      
      );
  }
}

