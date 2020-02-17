import '../models/organization.dart' as prefix0;
import 'package:hive/hive.dart';

part 'get_Organization.g.dart';

// @HiveType(0)
@HiveType()
class Data{

  @HiveField(0)
  List<Organization> organization;

  Data({this.organization});

  //  factory Data.fromJson(Map<String, dynamic> json){
  factory Data.fromJson(dynamic json){
    var list = json["organizations"] as List;
    // var list = json["orgs"] as List;
    // print("List");
    // print(list);
    // print("<!----!>");
    // print(list);
    // print(list.runtimeType);
    List<Organization> requestedList = list.map((i) => Organization.fromJson(i)).toList();
    // print(requestedList[0].name);
    return Data(
     organization: requestedList
    );
  }
}

// @HiveType()
@HiveType()
class Organization{
  @HiveField(0)
  String name;
  @HiveField(1)
  String location;
  @HiveField(2)
  String description;
  @HiveField(3)
  String tag;
  @HiveField(4)
  String website;
  @HiveField(5)
  int orgId;

  Organization({this.description,this.location,this.name,this.tag,this.website, this.orgId});

factory Organization.fromJson(Map<String,dynamic> json){
    return Organization(
      name: json["name"],
      location: json["location"],
      description: json["description"],
      tag: json["tag"],
      website: json["website"],
      orgId: json["org_id"]
    );
  }
}