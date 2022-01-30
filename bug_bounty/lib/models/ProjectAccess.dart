class ProjectAccess {
  int? applicationId;
  bool create;
  bool read;
  bool update;
  bool delete;

  ProjectAccess(
      {this.applicationId,
      this.create = false,
      this.read = false,
      this.update = false,
      this.delete = false});

  factory ProjectAccess.fromJson(Map<String, dynamic> json) {
    return ProjectAccess(
        applicationId: json['applicationId'],
        create: json['create'],
        read: json['read'],
        update: json['update'],
        delete: json['delete']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['create'] = this.create;
    data['read'] = this.read;
    data['update'] = this.update;
    data['delete'] = this.delete;
    return data;
  }
}
