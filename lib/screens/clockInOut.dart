// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:testtt/database/attencence.dart';
//
// import '../database/sqlite_service.dart';
//
//
// class ClockInOut extends StatefulWidget {
//   String employeeId ;
//
//   ClockInOut({super.key,required this.employeeId});
//
//   @override
//   State<ClockInOut> createState() => _ClockInOutState(this.employeeId);
// }
//
// class _ClockInOutState extends State<ClockInOut> {
//   List<Map<String, dynamic>> _user = [];
//
//   // User? _user;
//
//   bool fetching = true;
//   int currentIndex = 0;
//   String currentIn= '';
//   String currentOut= '';
//   String employeeId = '';
//
//   _ClockInOutState(this.employeeId);
//   bool isLoading = true;
//
//
//
//
//
//
//
//   // User? _user;
//
//
//
//
//
//   File? imageFile;
//
//   selectFile() async {
//     XFile? file = await ImagePicker().pickImage(
//         source: ImageSource.camera, maxHeight: 1800, maxWidth: 1800);
//
//     if (file != null) {
//       setState(() {
//         imageFile = File(file.path);
//       });
//     }
//   }
//
//
//
//
//
//   int initialCount = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery
//         .of(context)
//         .size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('attendance'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(40),
//           child: Form(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Container(
//                     height: size.height / 5,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                         border: Border.all(
//                           color: Color(0xFFD9073C),
//                           width: 1.2,
//                         )),
//                     alignment: Alignment.center,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Text('Upload Image', style: TextStyle(fontSize: 17),),
//
//                         if (imageFile != null)
//                           Expanded(
//                             child: Container(
//                               child: Image.file(
//                                 imageFile!,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                         IconButton(onPressed: selectFile, icon: Icon(Icons.camera)),
//
//                           ],
//                         )
//
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 70.0),
//                   child: SizedBox(
//                     width: size.width / 2,
//                   child: Column(
//                     children: [
//                        ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFFD9073C),
//                           ),
//                           onPressed: (){
//                             setState(() {
//                               currentIn = 'ClockIn';
//                               currentOut ='';
//                             });
//                             var user = Attendance(employeeId: employeeId, clockIn: currentIn, clockOut: currentOut,dateTime: DateTime.now().toString());
//                             DatabaseHelper.insertUser(user);
//
//                           },
//                           child: Text('Clockin', style: TextStyle(fontSize: 15),)),
//                       ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFFD9073C),
//                           ),
//                           onPressed: (){
//                             setState(() {
//                               currentOut = 'ClockOut';
//                               currentIn = '';
//                             });
//
//                             var user = Attendance(employeeId: employeeId, clockIn: currentIn, clockOut: currentOut,dateTime: DateTime.now().toString());
//                             DatabaseHelper.insertUser(user);
//
//
//                           },
//                           child: Text('ClockOut', style: TextStyle(fontSize: 15),)),
//                     ],
//                   ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
