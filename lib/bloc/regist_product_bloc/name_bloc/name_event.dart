part of 'name_bloc.dart';

abstract class NameEvent extends Equatable {
  const NameEvent();

  @override
  List<Object> get props => [];
}

class ChangeNameEvent extends NameEvent {
  final String name;
  const ChangeNameEvent({required this.name});
}
