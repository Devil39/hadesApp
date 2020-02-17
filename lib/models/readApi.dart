// class Event{
//    List<RS> rs;
//   String err;
//   Event({
//     this.rs,
//     this.err
    
//   });
//   factory Event.fromJson(Map<String,dynamic> json){
//     var list = json['rs'] as List;
//         print(list.runtimeType);
//         List<RS> rs = list.map((i) => RS.fromJson(i)).toList();
//       return Event(
        
        
//         rs:rs,
//         err:json['err']
//       );
//   }
// }



class RS{
  String clubName;
  String name;
  String toDate;
  String fromDate;
  String toTime;
  String fromTime;
  String budget;
  String description;
  String category;
  String venue;
  String attendance;
  String expectedParticipants;
  facultyCoordinator facultycoordinator;
  studentCoordinator studentcoordinator;
 // guest guestt;
  String prorequest;
  String campusEngineerRequest;
  String duration;
 // mainSponsor mainsponsor;
  String status;

  RS({
    this.clubName,
    this.name,
    this.toDate,
    this.fromDate,
    this.toTime,
    this.fromTime,
    this.budget,
    this.description,
    this.category,
    this.venue,
    this.attendance,
    this.expectedParticipants,
    this.facultycoordinator,
    this.studentcoordinator,
   // this.guestt,
    this.prorequest,
    this.campusEngineerRequest,
    this.duration,
   // this.mainsponsor,
    this.status

 });
  factory RS.fromJson(Map<String,dynamic> json){
    return RS(
      clubName: json['clubName'],
      name: json['name'],
      toDate: json['toDate'],
      fromDate: json['fromDate'],
      toTime: json['toTime'],
      fromTime: json['fromTime'],
      budget: json['budget'],
      description: json['description'],
      category: json['category'],
      venue: json['venue'],
      attendance: json['attendance'],
      expectedParticipants: json['expectedParticipants'],
      facultycoordinator: facultyCoordinator.fromJson(json['facultyCoordinator']),
      studentcoordinator: studentCoordinator.fromJson(json['studentCoordinator']),
    //  guestt: guest.fromJson(json['guest']),
      prorequest: json['PROrequest'],
      campusEngineerRequest: json['campusEngineerRequest'],
      duration: json['duration'],
     // mainsponsor:mainSponsor.fromJson(json['mainSponsor']),
      status: json['status']
    );
  }

}
class facultyCoordinator{
  String name;
  String registrationNumber;
  String email;
  String phoneNumber;
  String gender;

  facultyCoordinator({
    this.name,
    this.registrationNumber,
    this.email,
    this.phoneNumber,
    this.gender
  });
  factory facultyCoordinator.fromJson(Map<String,dynamic> json){
    return facultyCoordinator(
      name: json['name'],
      registrationNumber: json['registrationNumber'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender']
    );
  }
}

class studentCoordinator{
  String name;
  String registrationNumber;
  String email;
  String phoneNumber;
  String gender;

  studentCoordinator({
    this.name,
    this.registrationNumber,
    this.email,
    this.phoneNumber,
    this.gender
  });
  factory studentCoordinator.fromJson(Map<String,dynamic> json){
    return studentCoordinator(
      name: json['name'],
      registrationNumber: json['registrationNumber'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender']
    );
  }
}
// class guest{
//   String name;
//   String email;
//   String phoneNumber;
//   String gender;
//   String stake;
//   String locationOfStay;

//   guest({
//     this.name,
//     this.email,
//     this.phoneNumber,
//     this.gender,
//     this.stake,
//     this.locationOfStay
//   });
//   factory guest.fromJson(Map<String,dynamic> json){
//     return guest(
//       name: json['name'],
//       email: json['email'],
//       phoneNumber: json['phoneNumber'],
//       gender: json['gender'],
//       stake: json['stake'],
//       locationOfStay: json['locationOfStay']
//       );
//   }

// }
// class mainSponsor{
//   String name;
//   String registrationNumber;
//   String email;
//   String phoneNumber;
//   String gender;

//   mainSponsor({
//     this.name,
//     this.registrationNumber,
//     this.email,
//     this.phoneNumber,
//     this.gender
//   });
//   factory mainSponsor.fromJson(Map<String ,dynamic> json){
//     return mainSponsor(
//       name: json['name'],
//       registrationNumber: json['registrationNumber'],
//       email: json['email'],
//       phoneNumber: json['phoneNumber'],
//       gender: json['gender']
//     );
//   }
// }