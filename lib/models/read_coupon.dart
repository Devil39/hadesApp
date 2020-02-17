class ReadCoupon{
  int couponId;
  String name;
  String description;
  int day;
  ReadCoupon({
    this.couponId,
    this.name,
    this.description,
    this.day,
  });
  factory ReadCoupon.fromJson(Map<String,dynamic> json){
    return ReadCoupon(
      couponId: json["coupon_id"],
      name: json["name"],
      description: json["description"],
      day: json["day"]!=null?json["day"]:-1,
    );
  }
}

// Future<List<readAttendee>> fetchreadAttendee(http.HttpClient client)async{
//   final response=await client.post(host, port, path)
// }
