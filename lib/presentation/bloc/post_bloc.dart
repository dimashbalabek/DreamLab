import 'package:bloc/bloc.dart';
import 'package:dreaml_ab/data/models/post_model.dart';

part "post_event.dart";
part "post_state.dart";
class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<SearchRequest>((event, emit) {
      try {
        final String value = event.value;
        final List<PostModel> allPosts = event.allPosts;

        List<PostModel> searchPosts;

        if (value.isEmpty) {
          searchPosts = [];

          emit(UndefinedSearchResults(error: "Please start writing"));
        } else {
          final id = int.tryParse(value);
          if (id != null) {
            searchPosts = allPosts.where((post) => post.id == id).toList();
            emit(PostSearchResults(posts: searchPosts));
          } else {
            searchPosts = [];
          }

          if (searchPosts.isEmpty && (id == null || allPosts.contains(id) == false)) {
            print("");
            emit(UndefinedSearchResults(error: "Could not find Post with that type of ID"));
          }
        }
      } catch (e) {
      }
    });
  }
}
