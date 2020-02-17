class CreateAttendee{
  String name;
  String registrationNumber;
  String email;
  String phoneNumber;
  String gender;
  String eventName;
  CreateAttendee({
    this.name,
    this.registrationNumber,
    this.email,
    this.phoneNumber,
    this.gender,
    this.eventName
  });
  factory CreateAttendee.toJson(Map<String,dynamic> json){
    return CreateAttendee(

    );
  }
}



abstract class View {

}

abstract class Model {

}

abstract class Presenter {

}
