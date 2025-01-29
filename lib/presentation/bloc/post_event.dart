part of "post_bloc.dart";
class PostEvent {
  
}

class SearchRequest extends PostEvent{
  final value;
  final allPosts;
  SearchRequest({
    required this.value,
    required this.allPosts
  });
}
