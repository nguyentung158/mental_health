class User {
  String name;
  String email;
  String uid;
  String profilePhoto;
  String gender;
  String phoneNumber;
  String dateOfBirth;
  String age;
  List<dynamic> goals;

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

  static User fromJson(var snap) {
    var snapshot = snap as Map<String, dynamic>;
    User user = User(
        uid: snapshot['uid'],
        name: snapshot['name'],
        age: snapshot['age'],
        goals: snapshot['goals'],
        email: snapshot['email'],
        gender: snapshot['gender'],
        dateOfBirth: snapshot['dateOfBirth'],
        phoneNumber: snapshot['phoneNumber'],
        profilePhoto: snapshot['profilePhoto']);
    return User(
        uid: snapshot['uid'],
        name: snapshot['name'],
        age: snapshot['age'],
        goals: snapshot['goals'],
        email: snapshot['email'],
        gender: snapshot['gender'],
        dateOfBirth: snapshot['dateOfBirth'],
        phoneNumber: snapshot['phoneNumber'],
        profilePhoto: snapshot['profilePhoto']);
  }
}
