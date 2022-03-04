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
