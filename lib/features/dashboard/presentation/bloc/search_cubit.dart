import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/search_menu_item.dart';

class SearchState {
  final List<SearchMenuItem> allItems;
  final List<SearchMenuItem> filteredItems;
  final String query;

  const SearchState({
    this.allItems = const [],
    this.filteredItems = const [],
    this.query = '',
  });

  SearchState copyWith({
    List<SearchMenuItem>? allItems,
    List<SearchMenuItem>? filteredItems,
    String? query,
  }) {
    return SearchState(
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      query: query ?? this.query,
    );
  }
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  void initItems(List<SearchMenuItem> items) {
    emit(state.copyWith(
      allItems: items,
      filteredItems: _filterItems(items, state.query),
    ));
  }

  void updateQuery(String query) {
    emit(state.copyWith(
      query: query,
      filteredItems: _filterItems(state.allItems, query),
    ));
  }

  List<SearchMenuItem> _filterItems(List<SearchMenuItem> items, String query) {
    if (query.trim().isEmpty) return items;
    final lowerQuery = query.toLowerCase();
    return items.where((item) {
      final matchTitle = item.title.toLowerCase().contains(lowerQuery);
      final matchSubtitle = item.subtitle?.toLowerCase().contains(lowerQuery) ?? false;
      return matchTitle || matchSubtitle;
    }).toList();
  }
}
