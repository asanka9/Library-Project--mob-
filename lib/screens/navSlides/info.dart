import 'package:flutter/material.dart';




class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data',
            style: TextStyle(
            fontSize: 16
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
              child: ListView(
          children: <Widget>[
            /*
                     RichText(text: TextSpan(style: TextStyle( color: Colors.black87  ),
                     children: [ extSpan(text: 'Hello' ,style: TextStyle( color: Colors.red  )), TextSpan(text: ' World'),                                        ]                  )              ),
            
             */
            Text('data'),
            Center(
              child: RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Asanka ',
                    
                    style: TextStyle(
                      color: Colors.red,
                      
                    )
                  ),
                                    TextSpan(
                    text: 'Asanka ',
                    style: TextStyle(
                      color: Colors.red
                    )
                  ),
                                    TextSpan(
                    text: 'Asanka ',
                    style: TextStyle(
                      color: Colors.red
                    )
                  ),
                                    TextSpan(
                    text: 'Asanka ',
                    style: TextStyle(
                      color: Colors.red
                    )
                  ),
                                    TextSpan(
                    text: 'Asanka ',
                    style: TextStyle(
                      color: Colors.red
                    )
                  ),
                                    TextSpan(
                    text: 'Asanka ',
                    style: TextStyle(
                      color: Colors.red
                    )
                  ),
                                    TextSpan(
                    text: 'Asanka ',
                    style: TextStyle(
                      color: Colors.red
                    )
                  ),
                                    TextSpan(
                    text: 'Asanka ',
                    style: TextStyle(
                      color: Colors.red
                    )
                  ),
                                    TextSpan(
                    text: 'Asanka ',
                    style: TextStyle(
                      color: Colors.red
                    )
                  ),
                ]
              )),
            )
          ],
        ),
      ),
    );
  }
}