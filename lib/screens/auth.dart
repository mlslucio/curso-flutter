import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/main.dart';
import 'dart:async';

enum AuthMode {
  Signup,
  Login
}

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<AuthScreen> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTerms = false;  
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                image: AssetImage('assets/background.jpg'))),
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: 'E-Mail',
                      filled: true,
                      fillColor: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    setState(() {
                      _emailValue = value;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  controller: _passwordTextController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      _passwordValue = value;
                    });
                  },
                ),
                  _authMode == AuthMode.Signup ? TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      filled: true,
                      fillColor: Colors.white),
                  obscureText: true,
                  validator: (String value){
                    if(_passwordTextController.text != value){
                      return 'as senhas não conferem';
                    }
                  },
                  onSaved: (String value) {
                    setState(() {
                      _passwordValue = value;
                    });
                  },
                ) : Text(' '), 
                FlatButton(child: Text('Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}'),
                onPressed: (){
                  setState(() {
                    _authMode = _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;                    
                  });
                  
                },),
                 SwitchListTile(
                  value: _acceptTerms,
                  onChanged: (bool value) {
                    setState(() {
                      _acceptTerms = value;
                    });
                  },
                  title: Text('Accept Terms'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                    ScopedModelDescendant<MainModel>(
                        builder: (context, child, model) =>
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text('LOGIN'),
                  onPressed: () async {
                    if(_authMode == AuthMode.Login){
                       model.login(_emailValue, _passwordValue);
                    }else{
                     final Map<String, dynamic> msg = await model.signup(_emailValue, _passwordValue);

                      if(msg['hasError'] == false){
                        Navigator.pushReplacementNamed(context, '/products');
                     } else{
                      showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title: Text('Ocorreu um erro'),
                          actions: <Widget>[
                            FlatButton(child: Text('Ok'), onPressed: () {Navigator.of(context).pop();},)
                          ],
                        );});
                      }
                    } 
                  },
                )),
              ],
            )),
      ),
    );
  }
}
