part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();

  @override
  List<Object> get props => [];
}

class ChangeSearchTagTextEvent extends TagEvent {
  final String searchTag;
  const ChangeSearchTagTextEvent({
    required this.searchTag,
  });
}

class AddTagEvent extends TagEvent {
  final String tag;
  const AddTagEvent({
    required this.tag,
  });
}

class RemoveTagEvent extends TagEvent {
  final int index;
  const RemoveTagEvent({
    required this.index,
  });
}

class AutoCompleteEvent extends TagEvent {
  final int index;
  TextEditingController tagController;
  AutoCompleteEvent({
    required this.index,
    required this.tagController,
  });
}
