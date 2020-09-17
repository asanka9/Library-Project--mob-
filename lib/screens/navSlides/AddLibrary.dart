import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/models/LibraryModel.dart';
import 'package:library_app/models/UserModel.dart';
import 'package:library_app/screens/login.dart';
import 'package:library_app/services/HttpService.dart';


class AddLibrary extends StatefulWidget {
  @override
  _AddLibraryState createState() => _AddLibraryState();
}

class _AddLibraryState extends State<AddLibrary> {

  List<Library> currentLibraries = [];
  HttpService service = HttpService();
  String deletedSelected;

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
        currentLibraries = my;
      });
    }
    }
  }

  @override
  void initState() {
    returnAllLibraries(LoginForm.us.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Add Library',
            style: TextStyle(
              fontSize: 16
            ),
            ),
          actions: <Widget>[
            IconButton(icon: Icon(
              Icons.add_box
            ), onPressed: (){
              showSignAlertBox(context);
            })
          ],
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: CustomScrollView(
        slivers: <Widget>[

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (builder,e){
                return Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.arrow_right,
                      color: Colors.blueAccent,
                    ),
                    title: Text(currentLibraries[e].name,

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey
                    ),
                    ),
                    subtitle: Text(currentLibraries[e].address),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.remove
                      ),
                      onPressed: (){
                        showCuperActionDialog(context,currentLibraries[e].id);
                      },
                    ),
                  ),
                );
            },
            childCount: currentLibraries.length
            )
            )
        ],
        ),
          )
      );
      
    
  }

 showCuperActionDialog(BuildContext context,String lid){
   showCupertinoModalPopup(context: context, builder: 
   (context){
     return CupertinoActionSheet(
       title: Text('Delete Library'),
       message: Text('you delte this library will remove from your account'),
       cancelButton: CupertinoActionSheetAction(
         onPressed: (){
           Navigator.of(context).pop();
         }, 
         child: Text('cancel',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold
          ),
         )
         ),
         actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('OK',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            onPressed: (){
              
              

              deleteSelectedLibrary( LoginForm.us.id,lid,LoginForm.us.lid,LoginForm.us.nic );
              Navigator.of(context).pop();
            },
          )
         ],

     );
   }
   );
 }

 void showSignAlertBox(BuildContext context){

    TextEditingController userIdController = TextEditingController();
    TextEditingController userPasswordController = TextEditingController();

    bool isChecked = true;
    var alertDiaog = AlertDialog(
      title: Text(
        'Add Library + ',
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),
      ),
      content: Container(
          height: 500,
          child: ListView(
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
              'Enter Library id',
              
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.bold
              ),
              ),
            TextField(
              controller: userIdController,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Enter password',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.bold
              ),
              ),
            TextField(
              controller: userPasswordController,
            ),
            SizedBox(
              height: 15,
            ),

            OutlineButton.icon(
              onPressed:  () async{
                //User u = LoginForm.us;
                User u;
                final response = await http.get("http://10.0.2.2:8080/user/getUser/"+LoginForm.us.id);
                if (response.statusCode==200) {
                  String responseString = response.body;
                  u =  userFromJson(responseString);
                  if (u.lid=='' || u.nic=='') {
                    addLibrary(userIdController.text, userPasswordController.text, u.id, u.email, u.name, u.password, u.role, u.mnumber, userIdController.text, u.address, userPasswordController.text, u.gender);
                  } else {
                    addLibrary(userIdController.text, userPasswordController.text, u.id, u.email, u.name, u.password, u.role, u.mnumber, u.lid, u.address, u.nic, u.gender);

                  }
                }
                
              }, 
              icon: Icon(
                Icons.add_to_photos,
                color: Colors.blue,
              ), 
              label: Text(
                'Add to library',
                style: TextStyle(
                  color: Colors.blue
                ),
                )
              )
   
            
          ],
        ),
      ),
      elevation: 50,
    );
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext  context){
        return alertDiaog;
      }

      
      );
  }

addLibrary(String userId,String userpassword,
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
    debugPrint('dssssssssssssssssssssssssssssssssssss');
   


    final res = await http.get("http://10.0.2.2:8080/mobile/addLibrary/"+userId+"/"+userpassword+"/"+id+"/"+email+"/"+name+
     "/"+password+"/"+role+"/"+mnumber+"/"+lid+"/hakuruwela/"+nic+"/"+gender
    );
    debugPrint('dssssssssssssssssssssssssssssssssssss');
    debugPrint("http://10.0.2.2:8080/mobile/addLibrary/"+userId+"/"+userpassword+
      "/"+id+"/"+email+
     "/"+name+
     "/"+password+
     "/"+role+
     "/"+mnumber+
     "/"+lid+ 
     "/"+address+
     "/"+nic+
     "/"+gender);
    if (res.statusCode==200) {
        String responseString = res.body;
      List<dynamic> body = jsonDecode(responseString);
      List<Library> libraries = body.map((e) => Library.fromJson(e)).toList();
      setState(() {
        currentLibraries = libraries;
        Navigator.of(context).pop();
      });
      debugPrint('Hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
      
    }else{
      debugPrint('Erroe Occuredddd');
    }

  }


  deleteSelectedLibrary(String userId,String deletedId,String lids,String uids) async{
    User user;
    final response = await http.get("http://10.0.2.2:8080/user/getUser/"+LoginForm.us.id);
    if (response.statusCode==200) {
      String responseString = response.body;
      user =  userFromJson(responseString);
    }
    final res1 = await http.delete("http://10.0.2.2:8080/mobile/deleteLibrary/"+userId+"/"+deletedId+"/"+user.lid+"/"+user.nic);
    if (res1.statusCode==200) {
      String responseString = res1.body;
      debugPrint('##############################');
      debugPrint(responseString); 
      debugPrint('##############################');
      if (responseString.isNotEmpty) {
      List<dynamic> body = jsonDecode(responseString);
      List<Library> libraries= body.map((e) => Library.fromJson(e)).toList();
      setState(() {
        currentLibraries = libraries;
      });
      } else {
        setState(() {
        debugPrint('XXXXXXXXXXXXBBBBBBBBBBBBBBBBBBXXXXXXXXXXXXXXXXXXXXXXXXXXX');
        List<Library> my = [];
      setState(() {
        currentLibraries = my;
      });
      });
      }

    }else{
      debugPrint('Erroe Occuredddd');
    }
  }

}