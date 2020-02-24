class RequestList{
  List<Members> member;

  RequestList({this.member});
  // factory RequestList.fromJson(Map<String, dynamic> json){
  factory RequestList.fromJson(List<dynamic> json){
    // print("JSON");
    // print(json);
    // var list = json["data"] as List;
    var list=json;
    // print(json[0].runtimeType);
    // var a=Members.fromJson(json[0]);
    // print("I reached here!");
    // print(a.runtimeType);
    List<Members> requestedList = list.map((i) => Members.fromJson(i)).toList();
    // print("Done!");
    return RequestList(
        member: requestedList
    );
  }
}
class Members{
  // String firstName;
  // String lastName;
  // String email;
  // Members({this.email,this.firstName,this.lastName});

  int orgId;
  String email;

  Members({
    this.orgId,
    this.email
  });

  // factory Members.fromJson(Map<String,dynamic> json){
  factory Members.fromJson(dynamic json){
    // print("Member Enter:");
    // print(json);
    // print(json["org_id"]);
    // print(json["email"]);
    // print(Members(
    //     orgId: json["org_id"],
    //     email: json["email"]));
    return Members(
        orgId: json["org_id"],
        email: json["email"]
        // firstName: json['firstName'],
        // lastName: json["lastName"],
        // email: json['email']
    );
  }
}