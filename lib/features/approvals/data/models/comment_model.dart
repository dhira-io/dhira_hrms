import 'package:dhira_hrms/features/approvals/domain/entities/comment_entity.dart';

class CommentModel {
  final String name;
  final String content;
  final String commentType;
  final String owner;
  final DateTime creation;
  final String? commentBy;

  CommentModel({
    required this.name,
    required this.content,
    required this.commentType,
    required this.owner,
    required this.creation,
    this.commentBy,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      name: json['name'] ?? '',
      content: json['content'] ?? '',
      commentType: json['comment_type'] ?? '',
      owner: json['owner'] ?? '',
      creation: DateTime.parse(json['creation']),
      commentBy: json['comment_by'],
    );
  }

  CommentEntity toEntity() {
    return CommentEntity(
      name: name,
      content: content.replaceAll(RegExp(r'<[^>]*>'), ''), // Strip HTML tags
      commentType: commentType,
      owner: owner,
      creation: creation,
      commentBy: commentBy,
    );
  }
}
