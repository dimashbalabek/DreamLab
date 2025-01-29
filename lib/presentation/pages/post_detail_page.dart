
import 'package:dreaml_ab/data/models/post_model.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final PostModel post;

  const PostDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(post.image),
            SizedBox(height: 16),
            Text(
              post.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  post.content
                  ),
              )
              ),
          ],
        ),
      ),
    );
  }
}
