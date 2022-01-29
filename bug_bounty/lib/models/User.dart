class User {
  int? userId;
  String? userName;
  String? userEmailId;
  String? userCountry;
  String? userContactNumber;

  User({this.userId, this.userName, this.userEmailId, this.userCountry, this.userContactNumber});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userEmailId = json['userEmailId'];
    userCountry = json['userCountry'];    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userEmailId'] = this.userEmailId;
    data['userCountry'] = this.userCountry;
    data['userContactNumber'] = this.userContactNumber;
    return data;
  }
}
