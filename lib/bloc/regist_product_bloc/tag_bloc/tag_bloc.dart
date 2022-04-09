import 'package:bloc/bloc.dart';
import 'package:deepy_wholesaler/repository/regist_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  final RegistRepository _registRepository = RegistRepository();
  TagBloc() : super(TagState.initial()) {
    on<ChangeSearchTagTextEvent>(getTags);
    on<AddTagEvent>(addTag);
    on<RemoveTagEvent>(removeTag);
    on<AutoCompleteEvent>(autoCompleteTag);
  }

  Future<void> getTags(
      ChangeSearchTagTextEvent event, Emitter<TagState> emit) async {
    List<dynamic> resultTags = [];
    if (event.searchTag.isNotEmpty) {
      resultTags = await _registRepository.getTags(event.searchTag);
    }
    emit(state.copyWith(tagsList: resultTags));
  }

  void addTag(AddTagEvent event, Emitter<TagState> emit) {
    List copy = [...state.selectedTags];
    for (var value in state.tagsList) {
      if (copy.contains(value)) {
        return;
      }
      if (value['name'] == event.tag) {
        copy.add(value);
        emit(state.copyWith(selectedTags: copy, tagsList: []));
        return;
      }
    }
  }

  void removeTag(RemoveTagEvent event, Emitter<TagState> emit) {
    List copy = [...state.selectedTags];

    copy.removeAt(event.index);
    emit(state.copyWith(selectedTags: copy));
    return;
  }

  void autoCompleteTag(AutoCompleteEvent event, Emitter<TagState> emit) {
    event.tagController.text = state.tagsList[event.index]['name'];
    return;
  }
}
