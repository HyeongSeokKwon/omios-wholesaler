part of 'name_bloc.dart';

class NameState extends Equatable {
  final String name;
  final String errorMessage;
  const NameState({
    required this.name,
    required this.errorMessage,
  });

  factory NameState.initial() {
    return const NameState(name: "", errorMessage: "");
  }

  @override
  List<Object> get props => [name];

  NameState copyWith({
    String? name,
    String? errorMessage,
  }) {
    return NameState(
      name: name ?? this.name,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
