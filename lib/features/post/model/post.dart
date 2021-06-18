import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  Post({this.id, this.title, this.body});

  @override
  String toString() {
    return 'Post{id: $id, title: $title, body: $body}';
  }

  @override
  List<Object> get props => [id, title, body];
}
