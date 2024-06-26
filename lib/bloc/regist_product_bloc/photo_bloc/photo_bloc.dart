import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../color_bloc/color_bloc.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final ImagePicker picker = ImagePicker();
  final ColorBloc colorBloc;

  PhotoBloc(this.colorBloc) : super(PhotoState.initial()) {
    on<ClickGetBasicPhotoEvent>(getBasicPhoto);
    on<ClickGetColorByPhotoEvent>(getPhotoByColor);
    on<ClickMoveButton>(moveTabEvent);
    on<ReorderPhotoEvent>(reorderPhoto);
    on<ClickBasicPhotoRemoveEvent>(removeBasicImage);
    on<ClickColorPhotoRemoveEvent>(removeColorImage);
  }

  Future<void> getBasicPhoto(
      ClickGetBasicPhotoEvent event, Emitter<PhotoState> emit) async {
    List<Map> copy = [...state.basicPhoto];
    if (copy.length < 10) {
      List<XFile>? pickedFile = await picker.pickMultiImage();

      if (pickedFile != null) {
        for (var file in pickedFile) {
          if (copy.length < 10) {
            copy.add({
              'image': Image.file(
                File(file.path),
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              )
            });
          }
        }
      }
      emit(state.copyWith(basicPhoto: copy));
    }
  }

  Future<void> getPhotoByColor(
      ClickGetColorByPhotoEvent event, Emitter<PhotoState> emit) async {
    Image? photoByColor = state.photoByColor;

    XFile? colorPhoto = await picker.pickImage(source: ImageSource.gallery);
    if (colorPhoto != null) {
      photoByColor = Image.file(
        File(colorPhoto.path),
      );
    }
    colorBloc.state.selectedColorMap[event.index]['images'] = photoByColor;
    emit(state.copyWith(photoByColor: photoByColor));
  }

  void reorderPhoto(ReorderPhotoEvent event, Emitter<PhotoState> emit) {
    List<Map> copy = [...state.basicPhoto];

    final tmp = copy.removeAt(event.oldIndex);
    copy.insert(event.newIndex, tmp);

    emit(state.copyWith(basicPhoto: copy));
  }

  void moveTabEvent(ClickMoveButton event, Emitter<PhotoState> emit) {
    emit(state.copyWith(colorTabIndex: event.colorTabIndex));
  }

  void removeBasicImage(
      ClickBasicPhotoRemoveEvent event, Emitter<PhotoState> emit) {
    List<Map> basicImageList = [...state.basicPhoto];
    basicImageList.removeAt(event.photoIndex);
    emit(state.copyWith(basicPhoto: basicImageList));
  }

  void removeColorImage(
      ClickColorPhotoRemoveEvent event, Emitter<PhotoState> emit) {
    List selectedColorMap = [...colorBloc.state.selectedColorMap];
    selectedColorMap[event.photoIndex]['images'] = null;
    emit(state.copyWith(photoByColor: null));
  }
}
