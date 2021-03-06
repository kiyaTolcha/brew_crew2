import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  String email="";
  String password="";
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("Sign up to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
           widget.toggleView();
          }, icon: Icon(Icons.person), label: Text("Sign In"))
        ],
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              validator: (val)=> val.isEmpty ? 'Enter an email' : null,
              onChanged: (val){
                setState(() {
                  email=val;
                });
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              obscureText: true,
              validator: (val)=> val.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val){
                setState(() {
                  password=val;
                });
            },),
            SizedBox(height: 20.0),
            RaisedButton(
              color: Colors.pink[400],
              child: Text(
                'Sign up',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async{
                if(_formKey.currentState.validate()){
                  dynamic result=await _auth.RigesterWithEmailAndPassword(email, password);
                  if(result==null){
                    setState(() {
                      error='Please suppply a valid email and password';
                    });
                  }
                }
              },
            ),
            SizedBox(height: 12.0,),
            Text(error,
            style: TextStyle(color: Colors.red,fontSize: 14.0),)
          ],
        )),
      ),
    ); 
  }
}