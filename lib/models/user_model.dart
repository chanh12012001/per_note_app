class User {
  String? userId;
  String? phoneNumber;
  String? name;
  String? dateOfBirth;
  String? sex;
  String? email;
  String? token;

  User({
    this.userId,
    this.phoneNumber,
    this.name,
    this.dateOfBirth,
    this.sex,
    this.email,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['id'],
        phoneNumber: responseData['phoneNumber'],
        name: responseData['name'],
        dateOfBirth: responseData['dateOfBirth'],
        sex: responseData['sex'],
        email: responseData['email'],
        token: responseData['token']);
  }
}
