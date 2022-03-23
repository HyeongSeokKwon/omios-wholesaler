part of 'tag_bloc.dart';

class TagState extends Equatable {
  final List tagsList;
  final List selectedTags;

  const TagState({
    required this.tagsList,
    required this.selectedTags,
  });

  factory TagState.initial() {
    return const TagState(tagsList: [], selectedTags: []);
  }

  @override
  List<Object> get props => [tagsList, selectedTags];

  TagState copyWith({
    List? tagsList,
    List? selectedTags,
  }) {
    return TagState(
      tagsList: tagsList ?? this.tagsList,
      selectedTags: selectedTags ?? this.selectedTags,
    );
  }
}
