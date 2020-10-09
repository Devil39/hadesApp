import 'package:flutter/material.dart';

class Event{
  int eventId;
  int days;
  int orgId;
  String name;
  String budget;
  String description;
  String category;
  String venue;

  Event({
    @required this.eventId,
    @required this.days,
    @required this.orgId,
    @required this.name,
    @required this.budget,
    @required this.description,
    @required this.category,
    @required this.venue,
  });

  factory Event.fromJson(Map<String, dynamic> json){
    return Event(
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
