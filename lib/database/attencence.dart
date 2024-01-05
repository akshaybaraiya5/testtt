import 'dart:typed_data';

class Attendance {
  int? id;
  late final String employeeName;
  late final String employeeCode;
  late final String employeeEmail;
  late final String lastStatus;
  late final String dateTime;
  late final Uint8List picture;



  Attendance({
    // required this.id
    required this.employeeName,
    required this.employeeCode,
    required this.employeeEmail,
    required this.lastStatus,
    required this.dateTime,
    required this.picture,


  });


  Attendance.fromJson(Map<String, dynamic> result)
      : id = result["id"],
        employeeName = result["employeeName"],
         employeeCode= result["employeeCode"],
        employeeEmail = result["employeeEmail"],
        lastStatus = result["employeeStatus"],
        dateTime = result["dateTime"],
        picture = result["picture"];

  Map<String, Object?> toJson() {
    return { 'employeeName':employeeName, 'employeeCode': employeeCode,'employeeEmail':employeeEmail, 'lastStatus': lastStatus ,'dateTime': dateTime,'picture': picture};
  }
}