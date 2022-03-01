part of 'myproducts_bloc.dart';

abstract class MyproductsEvent extends Equatable {
  const MyproductsEvent();

  @override
  List<Object> get props => [];
}

class LoadMyproductsEvent extends MyproductsEvent {}
