import 'package:postgres/postgres.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';

class DbUserModel {
  final String email;
  final String password;
  final String? fullName;
  final int? id;

  DbUserModel({
    required this.email,
    required this.password,
    this.fullName,
    this.id,
  });

  factory DbUserModel.fromJson(ResultRow result) => DbUserModel(
    id: result[0] as int,
    email: result[1] as String ,
    password: result[2] as String,
    fullName: result[3] as String,
  );

  DbUserEntity toDbUserEntity() => DbUserEntity(
    email: email,
    fullName: fullName,
    password: password,
    id: id,
  );

}