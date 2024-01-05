import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:testtt/screens/employee_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Item',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Email',
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  style: TextStyle(fontSize: 17),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    fillColor: Colors.white70,
                  ),
                  // controller: myNameController,
                  onSaved: (value) {
                    email = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'Field must not be empty ';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'password',
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  style: TextStyle(fontSize: 17),
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    fillColor: Colors.white70,
                  ),
                  // controller: myPriceController,
                  onSaved: (value) {
                    password = value!;
                  },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                  validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'Field must not be empty ';

                    }
                    return null;
                  },

                ),
                SizedBox(
                  height: 60,
                ),



                Container(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: size.width / 2,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD9073C),
                        ),
                        onPressed: () async {
                          _formKey.currentState!.save();

                          if( _formKey.currentState!.validate()) {


                            final queryParameters = {
                              'email': email.toString(),
                              'password':password.toString(),//
                            };
                            final response = await http.post(
                              Uri.parse('https://app.arityhrmpro.com/api/tablet_user_login_api'),body: queryParameters,
                              // Send authorization headers to the backend.

                            );
                            var body = jsonDecode(response.body);
                            print(body['data']['user_id'].toString());
                            if(response.statusCode==200){

                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>EmployeeScreen( userId: body['data']['user_id'].toString(), branch_id: body['data']['branch_id'].toString(),)),);
                            }
                            else{
                              const snackBar = SnackBar(
                                content: Text('please enter valid Email and password'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }

                            print(response.body.toString());
                         }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 15),
                        )),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
