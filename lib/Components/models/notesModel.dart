// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotesModel {
  int? id;
  String title;
  String description;
  NotesModel({
    this.id = null,
    required this.title,
    required this.description,
  });

  NotesModel copyWith({
    int? id,
    String? title,
    String? description,
  }) {
    return NotesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesModel.fromJson(String source) =>
      NotesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NotesModel(id: $id, title: $title, description: $description)';

  @override
  bool operator ==(covariant NotesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;
}
