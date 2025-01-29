import 'package:dreaml_ab/data/data_sources/api_service.dart';
import 'package:dreaml_ab/presentation/pages/post_search_page.dart';
import 'package:flutter/material.dart';
import 'package:dreaml_ab/data/models/post_model.dart';
import 'package:dreaml_ab/presentation/pages/post_detail_page.dart';


class PostsAllPage extends StatefulWidget {
  @override
  _PostsAllPageState createState() => _PostsAllPageState();
}

class _PostsAllPageState extends State<PostsAllPage> {
  final ApiService _apiService = ApiService();
  List<PostModel> _allPosts = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  final int _limit = 20;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _scrollController.addListener(_onScroll);
  }

Future<void> _fetchPosts() async {
  if (_isLoading || !_hasMore) return;
  setState(() => _isLoading = true);
  try {
    final newPosts = await _apiService.fetchPosts(page: _page, limit: _limit);
    if (newPosts.length < _limit) {
      setState(() => _hasMore = false);  
    }
    setState(() {
      _allPosts.addAll(newPosts);
      _page++;
    });
  } catch (e) {
    print(e);
  } finally {
    setState(() => _isLoading = false);
  }
}


  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      _fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        actions: [IconButton(
          onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => PostsPage(),)), 
        icon: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(100)
          ),
          child: Icon(Icons.search, size: 28,)
          )
        )
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _allPosts.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _allPosts.length) {
            return _hasMore ? Center(child: CircularProgressIndicator()) : SizedBox();
          }
          final post = _allPosts[index];
          return ListTile(
            leading: Image.network(post.thumbnail, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(post.title),
            subtitle: Text("ID: ${post.id}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostDetailPage(post: post)),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
