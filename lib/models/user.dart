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
    final user = json['data'];
    return User(
      id: user['id'],
      email: user['email'],
      firstName: user['first_name'],
      lastName: user['last_name'],
      point: user['point'],
    );
  }
}
