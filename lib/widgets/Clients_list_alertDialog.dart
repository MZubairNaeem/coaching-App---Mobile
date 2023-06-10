class CheckedItemIdsNotifier extends StateNotifier<List<String>> {
  CheckedItemIdsNotifier() : super([]);

  void toggleCheckedItemId(String id) {
    if (state.contains(id)) {
      state = List.from(state)..remove(id);
    } else {
      state = List.from(state)..add(id);
    }
    print(state);
  }
}
