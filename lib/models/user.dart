class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final int point;

  User(
      {this.id = 0,
      this.email = "test@test.com",
      this.firstName = "x1",
      this.lastName = "x2",
      this.point = 0});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      point: json['point'],
    );
  }
}
