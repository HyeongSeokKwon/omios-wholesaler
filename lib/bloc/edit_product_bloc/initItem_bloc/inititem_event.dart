part of 'inititem_bloc.dart';

abstract class InitEditItemEvent extends Equatable {
  const InitEditItemEvent();

  @override
  List<Object> get props => [];
}

class LoadEditProductDataEvent extends InitEditItemEvent {
  final int productId;
  const LoadEditProductDataEvent({required this.productId});
}
