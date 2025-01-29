part of "post_bloc.dart";

class PostState {
  
}

class PostInitial extends PostState {
  
}

class PostSearchResults extends PostState{
  final posts;
  PostSearchResults({
    required this.posts
  });
}
class UndefinedSearchResults extends PostState{
  final error; 
  UndefinedSearchResults({
    required this.error
  });
}