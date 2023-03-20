class User {
  String name;
  String email;
  String uid;
  String profilePhoto;
  String gender;
  String phoneNumber;
  String dateOfBirth;
  String age;
  List<Map> goals;

  User({
    required this.name,
    required this.email,
    required this.uid,
    required this.profilePhoto,
    required this.gender,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.age,
    required this.goals,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "profilePhoto": profilePhoto,
      "gender": gender,
      "phoneNumber": phoneNumber,
      "dateOfBirth": dateOfBirth,
      "age": age,
      "goals": goals,
    };
  }
}
