import 'package:dreaml_ab/data/data_sources/api_service.dart';
import 'package:dreaml_ab/presentation/bloc/post_bloc.dart';
import 'package:dreaml_ab/data/models/post_model.dart';
import 'package:dreaml_ab/presentation/pages/post_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final ApiService _apiService = ApiService();
  late Future<List<PostModel>> _featurePosts;
  late List<PostModel> _allPosts = [];

  @override
  void initState() {
    super.initState();
    _featurePosts = _apiService.fetchPosts();
    awaitListsToLoad();
  }

  void awaitListsToLoad() async {
    final _localPosts = await _featurePosts;
    setState(() {
      _allPosts = _localPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: _featurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBar(
                    hintText: "Search Post by ID",
                    onChanged: (value) {
                      context.read<PostBloc>().add(
                        SearchRequest(value: value, allPosts: _allPosts),
                      );
                    },
                    leading: Icon(Icons.search),
                    padding: WidgetStatePropertyAll(EdgeInsets.only(left: 14, right: 14)),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      if (state is PostSearchResults) {
                        return ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            final post = state.posts[index];
                            return ListTile(
                              leading: Image.network(post.thumbnail),
                              title: Text(post.title),
                              subtitle: Text("${post.id}"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostDetailPage(post: post),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                      if (state is UndefinedSearchResults) {
                        return Center(child: Text(state.error));
                      }
                      return Center(child: Text("Please start writing"));
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
