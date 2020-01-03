import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/post/bloc.dart';
import 'package:flutter_plate/post/post.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  static const String PATH = '/posts';

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = PostBloc(httpClient: http.Client())..add(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (BuildContext context) {
        return _postBloc;
      },
      child: BlocBuilder<PostBloc, PostState>(
          builder: (BuildContext context, PostState state) {
        return _buildBody(state);
      }),
    );
  }

  Widget _buildBody(PostState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inifite Posts'),
      ),
      body: _buildWidgets(state),
    );
  }

  Widget _buildWidgets(PostState state) {
    if (state is PostUninitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is PostError) {
      return Center(
        child: Text('failed to fetch posts'),
      );
    } else if (state is PostLoaded) {
      if (state.posts.isEmpty) {
        return Center(
          child: Text('no posts'),
        );
      }
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return index >= state.posts.length
              ? BottomLoader()
              : PostWidget(post: state.posts[index]);
        },
        itemCount:
            state.hasReachedMax ? state.posts.length : state.posts.length + 1,
        controller: _scrollController,
      );
    }
    return Container();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(Fetch());
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}
