class Organization {
  int? organizationId;
  String? organizationName;
  String? organizationDescription;
  String? organizationWebsite;
  String? createdOn;

  Organization(
      {this.organizationId,
      this.organizationName,
      this.organizationDescription,
      this.organizationWebsite,
      this.createdOn});

  Organization.fromJson(Map<String, dynamic> json) {
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
    organizationDescription = json['organizationDescription'];
    organizationWebsite = json['organizationWebsite'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organizationId'] = this.organizationId;
    data['organizationName'] = this.organizationName;
    data['organizationDescription'] = this.organizationDescription;
    data['organizationWebsite'] = this.organizationWebsite;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
