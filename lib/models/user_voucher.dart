class UserVoucher {
  final int id;
  final String image;
  final String name;
  final String description;
  final String code;
  final DateTime createdAt;

  UserVoucher({
    this.id = 0,
    this.image = "",
    this.name = "x1",
    this.description = "description",
    this.code = "xxxx-xxxx-xxxx-xxxx",
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory UserVoucher.fromJson(Map<String, dynamic> json) {
    return UserVoucher(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      code: json['code'],
      createdAt: json['created_at']['date'] != null
          ? DateTime.parse(json['created_at']['date'])
          : DateTime.now(),
    );
  }
}
