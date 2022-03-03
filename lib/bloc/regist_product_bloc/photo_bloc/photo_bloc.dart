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
  final ImagePicker _picker = ImagePicker();
  final ColorBloc colorBloc;

  PhotoBloc(this.colorBloc) : super(PhotoState.initial()) {
    on<ClickGetBasicPhotoEvent>(getBasicPhoto);
    on<ClickGetColorByPhotoEvent>(getPhotoByImage);
    on<ClickMoveButton>(moveTabEvent);
  }

  void getBasicPhoto(
      ClickGetBasicPhotoEvent event, Emitter<PhotoState> emit) async {
    emit(state.copyWith(basicPhoto: await getPhotoFromGallery('basic')));
  }

  void getPhotoByImage(
      ClickGetColorByPhotoEvent event, Emitter<PhotoState> emit) async {
    dynamic photoByColor = await getPhotoFromGallery('color');

    for (var i in colorBloc.state.selectedColorMap) {
      if (i['color'] == event.color) {
        i['images'] = photoByColor;
      }
    }
    emit(state.copyWith(photoByColor: photoByColor));
  }

  Future<dynamic> getPhotoFromGallery(String photoType) async {
    List<dynamic> imageList = [...state.basicPhoto];
    Image? photoByColor = state.photoByColor;

    XFile? pickedFile = (await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    ));

    if (pickedFile != null) {
      if (photoType == 'basic') {
        imageList.add(Image.file(
          File(pickedFile.path),
        ));
        return imageList;
      } else {
        photoByColor = Image.file(
          File(pickedFile.path),
        );
        return photoByColor;
      }
    }
  }

  void getPhotoFromCamera() async {}

  void moveTabEvent(ClickMoveButton event, Emitter<PhotoState> emit) {
    emit(state.copyWith(colorTabIndex: event.colorTabIndex));
  }
}
