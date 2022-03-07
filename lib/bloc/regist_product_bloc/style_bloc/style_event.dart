part of 'style_bloc.dart';

abstract class StyleEvent extends Equatable {
  const StyleEvent();

  @override
  List<Object> get props => [];
}

class ClickStyleButtonEvent extends StyleEvent {
  final int styleIndex;
  const ClickStyleButtonEvent({
    required this.styleIndex,
  });
}
