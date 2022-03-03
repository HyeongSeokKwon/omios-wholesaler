part of 'size_bloc.dart';

abstract class SizeEvent extends Equatable {
  const SizeEvent();

  @override
  List<Object> get props => [];
}

class ClickSizeButton extends SizeEvent {
  final String size;
  const ClickSizeButton({
    required this.size,
  });
}

class ClickRemoveSizeButton extends SizeEvent {
  final String size;
  const ClickRemoveSizeButton({
    required this.size,
  });
}
