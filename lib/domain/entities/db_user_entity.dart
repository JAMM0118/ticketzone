
class DbUserEntity {
  String email;
  String password;
  String? fullName;
  int? id;

   DbUserEntity({
    required this.email,
    required this.password,
    this.fullName,
    this.id,
  });
}