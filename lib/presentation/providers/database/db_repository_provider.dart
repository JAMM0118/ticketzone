import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/infrastructure/datasources/db_datasource_impl.dart';
import 'package:ticketzone/infrastructure/repositories/db_repository_impl.dart';

final dbRepositoryProvider = Provider((ref){
  return DbRepositoryImpl(dbDataSource: DbDatasourceImpl());
});
