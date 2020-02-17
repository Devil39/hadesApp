/* {code: 200, message: Retrieved all participants in event segment successfully,
 participants: [{name: Someone, reg_no: 18BCE0001, email: someone@gmail.com,
  phone_number: 9632587410, gender: Male}]}*/

class ReadAttendee{
 String name;
  String registrationNumber;
  // String regNo;
  String email;
  String phoneNumber;
  String gender;
  ReadAttendee({
    this.name,
    this.registrationNumber,
    // this.regNo,
    this.email,
    this.phoneNumber,
    this.gender,
  });
  factory ReadAttendee.fromJson(Map<String,dynamic> json){
    return ReadAttendee(
      name: json["name"],
      registrationNumber: json["reg_no"],
      // regNo: json["regNo"],
      email: json["email"],
      // phoneNumber: json["phoneNumber"],
      phoneNumber: json["phone_number"],
      gender: json["gender"],
    );
  }
}

// Future<List<readAttendee>> fetchreadAttendee(http.HttpClient client)async{
//   final response=await client.post(host, port, path)
// }
