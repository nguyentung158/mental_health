// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

class DoctorModel {
  String name;
  String uid;
  String email;
  String type;
  String description;
  double rating;
  double goodReviews;
  double totalScore;
  double satisfaction;
  List isfavourite;
  String image;
  int votes;

  DoctorModel(
      {required this.name,
      required this.type,
      required this.uid,
      required this.email,
      required this.description,
      required this.rating,
      required this.goodReviews,
      required this.totalScore,
      required this.satisfaction,
      required this.isfavourite,
      required this.image,
      required this.votes});

  // DoctorModel copyWith({
  //     String name,
  //     String type,
  //     String description,
  //     double rating,
  //     double goodReviews,
  //     double totalScore,
  //     double satisfaction,
  //     bool isfavourite,
  //     String image,
  // }) =>
  //     DoctorModel(
  //         name: name ?? this.name,
  //         type: type ?? this.type,
  //         description: description ?? this.description,
  //         rating: rating ?? this.rating,
  //         goodReviews: goodReviews ?? this.goodReviews,
  //         totalScore: totalScore ?? this.totalScore,
  //         satisfaction: satisfaction ?? this.satisfaction,
  //         isfavourite: isfavourite ?? this.isfavourite,
  //         image: image ?? this.image,
  //     );

  factory DoctorModel.fromRawJson(String str) =>
      DoctorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
      name: json["name"],
      type: json["type"],
      description: json["description"],
      rating: json["rating"] == null ? null : json["rating"].toDouble(),
      goodReviews:
          json["goodReviews"] == null ? null : json["goodReviews"].toDouble(),
      totalScore:
          json["totalScore"] == null ? null : json["totalScore"].toDouble(),
      satisfaction:
          json["satisfaction"] == null ? null : json["satisfaction"].toDouble(),
      isfavourite: json["isfavourite"],
      image: json["image"],
      email: json['email'] ?? '',
      uid: json['uid'] ?? '',
      votes: json['votes']);

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "description": description,
        "rating": rating,
        "goodReviews": goodReviews,
        "totalScore": totalScore,
        "satisfaction": satisfaction,
        "isfavourite": isfavourite,
        "image": image,
        "email": email,
        "uid": uid,
        "votes": votes
      };
}
