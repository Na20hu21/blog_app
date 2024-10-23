// lib/bloc/post_bloc.dart
import 'dart:async';
import 'package:blog_app/bloc/post_event.dart';
import 'package:blog_app/bloc/post_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_model.dart';
import '../services/post_service.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostService postService;
  int currentPage = 0;
  final int limit = 10;

  PostBloc({required this.postService}) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    if (state is PostLoading) return;

    final currentState = state;
    List<Post> posts = [];

    if (currentState is PostLoaded) {
      posts = currentState.posts;
    }

    emit(PostLoading());
    try {
      final newPosts = await postService.fetchPosts(currentPage * limit, limit);
      currentPage++;
      emit(PostLoaded(posts: posts + newPosts, hasReachedMax: newPosts.isEmpty));
    } catch (e) {
      emit(PostInitial());
    }
  }
}
