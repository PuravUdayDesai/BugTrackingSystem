class User {
  int? userId;
  String? userName;
  String? userEmailId;
  String? userCountry;
  String? userContactNumber;
  String? password;

  User(
      {this.userId,
      this.userName,
      this.userEmailId,
      this.userCountry,
      this.userContactNumber,
      this.password});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userEmailId = json['userEmailId'];
    userCountry = json['userCountry'];
    userContactNumber = json['userContactNumber'];
    password = json['userPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userEmailId'] = this.userEmailId;
    data['userCountry'] = this.userCountry;
    data['userContactNumber'] = this.userContactNumber;
    data['userPassword'] = this.password;
    return data;
  }
}
