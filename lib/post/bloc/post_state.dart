import 'package:equatable/equatable.dart';
import 'package:flutter_plate/post/model/post.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostState extends Equatable {
  PostState();
}

class PostUninitialized extends PostState {
  @override
  String toString() => 'PostUninitialized';

  @override
  List<Object> get props => [];
}

class PostError extends PostState {
  @override
  String toString() => 'PostError';

  @override
  List<Object> get props => [];
}

class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostLoaded({
    this.posts,
    this.hasReachedMax,
  });

  PostLoaded copyWith({
    List<Post> posts,
    bool hasReachedMax,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'PostLoaded{posts: $posts, hasReachedMax: $hasReachedMax}';
  }

  @override
  List<Object> get props => [posts, hasReachedMax];
}
