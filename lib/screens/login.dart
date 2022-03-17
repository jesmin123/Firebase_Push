
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app001/screens/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  //firebase
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: Text("Email"),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: TextFormField(
                              decoration: InputDecoration(isDense: true,),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator:(val){
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val!)) {
                                  return "Please enter a valid email address";
                                }
                                return null;
                              } ,
                              onSaved: (value){
                                emailController.text = value!;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: Text("Password"),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(isDense: true),
                              validator: (val){
                                if (val!.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                              onChanged: (val){
                                passwordController.text = val;
                              },
                            ),
                          ),
                          SizedBox(height: 40),
                          InkWell(
                            onTap: (){
                              signIn(emailController.text, passwordController.text);
                            },
                            child: Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width*0.9,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.blue),
                              child: Center(
                                child: Text("Login"),
                              ),
                            ),
                          ),

                        ],
                      ),

                    )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );




  }
  Future<void> signIn(String email, String password) async{
    if(_formKey.currentState!.validate()){
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()))
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      }
      );
    }
  }


}
