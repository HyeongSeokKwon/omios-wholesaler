part of 'tag_bloc.dart';

class TagState extends Equatable {
  final List tagsList;
  List selectedTags;
  final FetchState fetchState;
  TagState({
    required this.tagsList,
    required this.selectedTags,
    required this.fetchState,
  });

  factory TagState.initial() {
    return TagState(
        tagsList: [], selectedTags: [], fetchState: FetchState.initial);
  }

  @override
  List<Object> get props => [tagsList, selectedTags, fetchState];

  TagState copyWith({
    List? tagsList,
    List? selectedTags,
    FetchState? fetchState,
  }) {
    return TagState(
      tagsList: tagsList ?? this.tagsList,
      selectedTags: selectedTags ?? this.selectedTags,
      fetchState: fetchState ?? this.fetchState,
    );
  }
}
