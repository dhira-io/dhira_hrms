import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String name;
  final String content;
  final String commentType;
  final String owner;
  final DateTime creation;
  final String? commentBy;

  const CommentEntity({
    required this.name,
    required this.content,
    required this.commentType,
    required this.owner,
    required this.creation,
    this.commentBy,
  });

  @override
  List<Object?> get props => [name, content, commentType, owner, creation, commentBy];
}
