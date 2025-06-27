import 'package:ticketzone/domain/entities/categories_entity.dart';

class CategoriesModel {
  final String category;
  final String genreId;
  final String genreName;

  CategoriesModel({required this.category, required this.genreId, required this.genreName});

  factory CategoriesModel.fromJson(Map<String,dynamic> json,{int id =0 }) => CategoriesModel(
    category: json['segment'] != null && json['segment']['name'] != 'Undefined' 
    ? json['segment']['name'] : '',
    genreId: json['segment'] != null && json['segment']['name'] != 'Undefined'? 
    json['segment']['_embedded']['genres'][id]['id'] : '',
    genreName: json['segment'] != null && json['segment']['name'] != 'Undefined' ?
    json['segment']['_embedded']['genres'][id]['name'] : '',
  );

  CategoriesEntity toCategoriesEntity() => CategoriesEntity(
    category: category,
    genreId: genreId,
    genreName: genreName,
  );
}