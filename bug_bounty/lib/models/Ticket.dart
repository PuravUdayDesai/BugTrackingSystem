class Ticket {
  int? ticketId;
  String? title;
  String? desc;
  String? createdOn;
  String? status;
  int? statusColor;
  String? priority;

  Ticket(
      {this.ticketId,
      this.title,
      this.desc,
      this.createdOn,
      this.status,
      this.statusColor,
      this.priority});

  Ticket.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticketId'];
    title = json['title'];
    desc = json['desc'];
    createdOn = json['createdOn'];
    status = json['status'];
    statusColor = json['statusColor'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketId'] = this.ticketId;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['createdOn'] = this.createdOn;
    data['status'] = this.status;
    data['statusColor'] = this.statusColor;
    data['priority'] = this.priority;
    return data;
  }
}
