part of 'color_bloc.dart';

abstract class ColorEvent extends Equatable {
  const ColorEvent();

  @override
  List<Object> get props => [];
}

class ClickColorButtonEvent extends ColorEvent {
  final String color;
  final int colorId;
  const ClickColorButtonEvent({
    required this.color,
    required this.colorId,
  });
}

class ClickColorAddButtonEvent extends ColorEvent {
  final String color;
  final String customedName;
  final int colorId;
  const ClickColorAddButtonEvent({
    required this.color,
    required this.customedName,
    required this.colorId,
  });
}

class ClickColorRemoveButtonEvent extends ColorEvent {
  final String color;
  final String customedName;
  final int colorId;
  const ClickColorRemoveButtonEvent({
    required this.color,
    required this.customedName,
    required this.colorId,
  });
}

class ChangeColorCustomedNameEvent extends ColorEvent {
  final String customedName;
  final int selectedColorIndex;
  const ChangeColorCustomedNameEvent({
    required this.customedName,
    required this.selectedColorIndex,
  });
}
