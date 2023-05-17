class Appointment {
  String? date;
  String? time;
  String? title;
  String? subTitle;
  String? userId;
  String? docId;
  String? status;
  String? image;
  String? id;

  Appointment(
      {this.date,
      this.time,
      this.title,
      this.subTitle,
      this.userId,
      this.docId,
      this.status,
      this.image,
      this.id});

  Appointment.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    title = json['title'];
    subTitle = json['subTitle'];
    userId = json['user_id'];
    docId = json['doc_id'];
    status = json['status'];
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['user_id'] = userId;
    data['doc_id'] = docId;
    data['status'] = status;
    data['image'] = image;
    data['id'] = id;
    return data;
  }
}
