part of 'photo_bloc.dart';

class PhotoState extends Equatable {
  List<dynamic> basicPhoto;
  Image? photoByColor;
  int colorTabIndex;

  PhotoState({
    required this.basicPhoto,
    required this.photoByColor,
    required this.colorTabIndex,
  });

  factory PhotoState.initial() {
    return PhotoState(basicPhoto: [], photoByColor: null, colorTabIndex: 0);
  }

  @override
  List<Object?> get props => [basicPhoto, photoByColor, colorTabIndex];

  PhotoState copyWith({
    List<dynamic>? basicPhoto,
    Image? photoByColor,
    int? colorTabIndex,
  }) {
    return PhotoState(
      basicPhoto: basicPhoto ?? this.basicPhoto,
      photoByColor: photoByColor ?? this.photoByColor,
      colorTabIndex: colorTabIndex ?? this.colorTabIndex,
    );
  }
}
