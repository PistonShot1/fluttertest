// search_state.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_state_notifier.g.dart';

class SearchState {
  final String query;
  final String selectedCategory;

  SearchState({this.query = '', this.selectedCategory = 'All'});

  SearchState copyWith({String? query, String? selectedCategory}) {
    return SearchState(
      query: query ?? this.query,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

@riverpod
class SearchStateNotifier extends _$SearchStateNotifier {
  @override
  SearchState build() {
    return SearchState();
  }

  void updateQuery(String query) {
    state = state.copyWith(query: query);
  }

  void updateCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void clearSearch() {
    state = state.copyWith(query: '');
  }

  void reset() {
    state = SearchState();
  }
}
