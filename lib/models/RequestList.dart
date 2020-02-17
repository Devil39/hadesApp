class RequestList{
  List<Members> member;

  RequestList({this.member});
  factory RequestList.fromJson(Map<String, dynamic> json){
    var list = json["data"] as List;
    List<Members> requestedList = list.map((i) => Members.fromJson(i)).toList();
    return RequestList(
        member: requestedList
    );
  }
}
class Members{
  String firstName;
  String lastName;
  String email;
  Members({this.email,this.firstName,this.lastName});

  factory Members.fromJson(Map<String,dynamic> json){
    return Members(
        firstName: json['firstName'],
        lastName: json["lastName"],

        email: json['email']
    );
  }
}