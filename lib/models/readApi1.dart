import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:hades_app/models/scoped_models/mainModel.dart';

class RS1{
  int eventId;
  int days;
  int orgId;
  String name;
  String budget;
  String description;
  String category;
  String venue;

  RS1({
    @required this.eventId,
    @required this.days,
    @required this.orgId,
    @required this.name,
    @required this.budget,
    @required this.description,
    @required this.category,
    @required this.venue,
  });

  factory RS1.fromJson(Map<String, dynamic> json){
    return RS1(
      eventId: json["event_id"],
      days: json["days"],
      orgId: json["org_id"],
      name: json["name"],
      budget: json["budget"],
      description: json["description"],
      category: json["category"],
      venue: json["venue"]
    );
  }
}
/*{code: 200, events: [{event_id: 2, days: 0, org_id: 2, name: Something, budget: 10000,
 description: Something Something, category: Nothing, venue: Somwhere, attendance: ,
  expected_participants: , pro_request: , campus_engineer_request: , duration: , status: ,
   to_date: 0001-01-01T00:00:00Z, from_date: 0001-01-01T00:00:00Z, to_time: 0001-01-01T00:00:00Z,
    from_time: 0001-01-01T00:00:00Z, attendees: null, guests: null}],
     message: Successfully retrieved events}*/