part of 'regist_product_bloc.dart';

enum RegistStatus { init, success, fail, loading }

class RegistProductState extends Equatable {
  RegistStatus registStatus;
  RegistProductState({
    required this.registStatus,
  });
  factory RegistProductState.initial() {
    return RegistProductState(registStatus: RegistStatus.init);
  }
  RegistProductState copyWith({
    RegistStatus? registStatus,
  }) {
    return RegistProductState(
      registStatus: registStatus ?? this.registStatus,
    );
  }

  @override
  List<Object> get props => [registStatus];
}
