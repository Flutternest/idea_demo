import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String? id;
  final String? name;
  final DateTime? dateCreated;

  const Category({this.id, this.name, this.dateCreated});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as String?,
        name: json['name'] as String?,
        dateCreated: json['date_created'] != null
            ? DateTime.parse(json['date_created'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date_created': dateCreated?.toIso8601String(),
      };

  Category copyWith({
    String? id,
    String? name,
    DateTime? dateCreated,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, dateCreated];
}
