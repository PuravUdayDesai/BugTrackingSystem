class Project {
  int? applicationId;
  int? organizationId;
  String? applicationName;
  String? applicationDescription;
  String? createdOn;
  bool? markForPrivate;

  Project(
      {this.applicationId,
      this.organizationId,
      this.applicationName,
      this.applicationDescription,
      this.createdOn,
      this.markForPrivate});

  Project.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    organizationId = json['organizationId'];
    applicationName = json['applicationName'];
    applicationDescription = json['applicationDescription'];
    createdOn = json['createdOn'];
    markForPrivate = json['markForPrivate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['organizationId'] = this.organizationId;
    data['applicationName'] = this.applicationName;
    data['applicationDescription'] = this.applicationDescription;
    data['createdOn'] = this.createdOn;
    data['markForPrivate'] = this.markForPrivate;
    return data;
  }
}
