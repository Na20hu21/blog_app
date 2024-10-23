import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_model.dart';
import '../models/post_model.dart';
import '../widget/card_post.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final ScrollController _scrollController = ScrollController();
  late PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostBloc>(context);
    _postBloc.add(FetchPosts());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _postBloc.add(FetchPosts());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Blog"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Posts'),
              Tab(text: 'About'),
            ],
          ),
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              return Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildPostList(state),
                        const Center(child: Text('About this blog')),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('Failed to load posts'));
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Blog', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('A place to share knowledge and ideas.', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPostList(PostLoaded state) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
      itemBuilder: (context, index) {
        if (index >= state.posts.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final post = state.posts[index];
        return _buildPostItem(post);
      },
    );
  }

  Widget _buildPostItem(Post post) {
    return  CardPost(
      title: post.title,
      subtitle: post.body,
    );
  }
}
