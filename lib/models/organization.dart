import 'package:hive/hive.dart';

import './get_Organization.dart';

part 'organization.g.dart';

@HiveType()
class Requests {
  @HiveField(0)
  List<Organization> requested;

  Requests({this.requested});

  factory Requests.fromJson(dynamic json, {String key}) {
    // print("<__>");
    // print(json);
    // var list = json["data"] as List;
    var list = json[key] as List;
    //var list = json["organizations"] as List;
    // print(list);
    // print(list.runtimeType);
    // List<Organization> requestedList = list.map((i) => print(i.runtimeType)).toList();
    List<Organization> requestedList =
        list.map((i) => Organization.fromJson(i)).toList();
    return Requests(requested: requestedList);
  }
}

@HiveType()
class Organization {
  @HiveField(0)
  String id;
  @HiveField(1)
  String fullName;
  @HiveField(2)
  String location;
  @HiveField(3)
  String photoUrl;
  @HiveField(4)
  String description;
  @HiveField(5)
  int v;
  @HiveField(6)
  String website;
  @HiveField(7)
  int org_id;

  Organization({
    this.v,
    this.id,
    this.description,
    this.fullName,
    this.location,
    this.photoUrl,
    this.website,
    this.org_id,
  });

  factory Organization.fromJson(dynamic json) {
    //Map<String, dynamic>
    return Organization(
        fullName: json["name"],
        location: json["location"],
        photoUrl: json["tag"],
        description: json["description"],
        website: json["website"],
        org_id: json["org_id"]);
  }

  List<Organization> fromData(Data data) {
    List<Organization> orgs = [];
    for(int i=0;i<data.organization.length;i++) {
      var org =data.organization[i];
      orgs.add(Organization(
        fullName: org.name,
        location: org.location,
        photoUrl: "",
        description: org.description,
        website: org.website,
        org_id: org.orgId,
      ));
    }
    return orgs;
  }
}
