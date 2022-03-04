part of 'size_bloc.dart';

abstract class SizeEvent extends Equatable {
  const SizeEvent();

  @override
  List<Object> get props => [];
}

class ClickSizeButton extends SizeEvent {
  final String size;
  final int sizeId;
  const ClickSizeButton({required this.size, required this.sizeId});
}

class ClickRemoveSizeButton extends SizeEvent {
  final String size;
  int? sizeId;
  ClickRemoveSizeButton({required this.size, this.sizeId});
}
