part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object> get props => [];
}

class ClickGetBasicPhotoEvent extends PhotoEvent {}

class ClickGetColorByPhotoEvent extends PhotoEvent {
  final String color;

  const ClickGetColorByPhotoEvent({
    required this.color,
  });
}

class ClickMoveButton extends PhotoEvent {
  final int colorTabIndex;
  const ClickMoveButton({
    required this.colorTabIndex,
  });
}

class ReorderPhotoEvent extends PhotoEvent {
  final int oldIndex;
  final int newIndex;
  const ReorderPhotoEvent({
    required this.oldIndex,
    required this.newIndex,
  });
}

class ClickBasicPhotoRemoveEvent extends PhotoEvent {
  final int photoIndex;
  const ClickBasicPhotoRemoveEvent({
    required this.photoIndex,
  });
}

class ClickColorPhotoRemoveEvent extends PhotoEvent {
  final int photoIndex;
  const ClickColorPhotoRemoveEvent({
    required this.photoIndex,
  });
}
