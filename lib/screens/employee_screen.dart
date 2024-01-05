import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:testtt/database/attencence.dart';
import 'package:testtt/screens/clockInOut.dart';

import '../database/sqlite_service.dart';

class EmployeeScreen extends StatefulWidget {
  String userId ='';
  String branch_id = '';
   EmployeeScreen({super.key, required this.userId ,required this.branch_id });

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState(this.userId,this.branch_id);
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  var employeeId = '';
  var employeeName = '';
  String userId ;
  String branch_id;
  String currentStatus = 'clockIn';
  _EmployeeScreenState(this.userId,this.branch_id);


  List<Map<String, dynamic>> data = [];


  File? imageFile;

  selectFile() async {
    XFile? file = await ImagePicker().pickImage(
        source: ImageSource.camera, maxHeight: 180, maxWidth: 180);

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }



  void getData() async {
    List<Map<String, dynamic>> userData = await DatabaseHelper.getSingleUser(int.parse(employeeId));

    setState(() {
      fetching = false;
      data = userData;
      final existingEmployee =
      data.firstWhere((element) => element['employeeCode'] == employeeId);
      currentStatus = existingEmployee['lastStatus'];






      // currentStatus = userData.last.toString();

    });


  }











  // User? _user;

  bool fetching = true;
  int currentIndex = 0;




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
                  'Enter EmployeeId',
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
                    employeeId = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'Field must not be empty ';
                    }
                    return null;
                  },
                ),

                Text(
                  'employee name is : $employeeName',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'employee attendance status : $currentStatus',
                  style: TextStyle(fontSize: 20),
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  height: size.height / 5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Color(0xFFD9073C),
                        width: 1.2,
                      )),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Upload Image', style: TextStyle(fontSize: 17),),

                      if (imageFile != null)
                        Expanded(
                          child: Container(
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: selectFile, icon: Icon(Icons.camera)),

                        ],
                      )

                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
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
                          setState(() {
                            currentStatus = 'clockIn';
                          });
                       // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ClockInOut(employeeId: employeeId,)));

                        },
                        child: Text(
                          'ClockIn',
                          style: TextStyle(fontSize: 15),
                        )),
                  ),
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
                          setState(() {
                            currentStatus = 'clockOut';
                          });
                          // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ClockInOut(employeeId: employeeId,)));

                        },
                        child: Text(
                          'ClockOut',
                          style: TextStyle(fontSize: 15),
                        )),
                  ),
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


                          // print(allData.last['clockIn'].toString());
                          //  print(allData.last['clockOut'].toString());

                          _formKey.currentState!.save();

                          if( _formKey.currentState!.validate()) {
                          // getData();



                            final queryParameters = {
                              'employee_code':employeeId,
                              'branch_id': branch_id,
                              'user_id':'439'
                              //
                            };
                            final response = await http.post(
                              Uri.parse('https://app.arityhrmpro.com/api/employee_code'),headers: {
                              'Authorization': 'Bearer 43lOVttdgw5nx8ONrfGtpsMGKnFlbzTshFLLoCcT81ekReqXomUjnYZmIW762sn7',
                            }, body: queryParameters,
                              // Send authorization headers to the backend.

                            );
                            var name = jsonDecode(response.body);

                            if(response.statusCode==200){
                              print(currentStatus);
                              setState(() {
                                employeeName = name['data']['name'];
                                currentStatus = currentStatus;

                              });
                              getData();

                              var base = imageFile!.readAsBytesSync();
                              String imageName = imageFile!.path.split('/').last;

                                DatabaseHelper.insertUser(Attendance(employeeName: name['data']['name'], employeeCode: name['data']['employee_code'], employeeEmail: name['data']['email'], lastStatus: currentStatus, dateTime: DateTime.now().toString(), picture: base));


                              print(data);
                            }
                            else{
                              const snackBar = SnackBar(
                                content: Text('please enter valid employee code'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }

                          }
                        },
                        child: Text(
                          'Submit attendance',
                          style: TextStyle(fontSize: 15),
                        )),
                  ),
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

                          // print(allData.last['clockIn'].toString());
                          //  print(allData.last['clockOut'].toString());

                          _formKey.currentState!.save();

                          if( _formKey.currentState!.validate()) {




                            final queryParameters = {
                              'employee_code':employeeId,
                              'branch_id': branch_id,
                              'user_id':'439'
                              //
                            };
                            final response = await http.post(
                              Uri.parse('https://app.arityhrmpro.com/api/employee_code'),headers: {
                              'Authorization': 'Bearer 43lOVttdgw5nx8ONrfGtpsMGKnFlbzTshFLLoCcT81ekReqXomUjnYZmIW762sn7',
                            }, body: queryParameters,
                              // Send authorization headers to the backend.

                            );
                            var name = jsonDecode(response.body);

                            if(response.statusCode==200){
                              getData();
                              setState(() {
                                employeeName = name['data']['name'];
                                currentStatus = currentStatus;

                                // print(currentStatus);

                              });

                            }
                            else{
                              const snackBar = SnackBar(
                                content: Text('please enter valid employee code'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }

                          }
                        },
                        child: Text(
                          'get Employee',
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
