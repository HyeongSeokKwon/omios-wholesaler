part of 'name_bloc.dart';

class NameState extends Equatable {
  String name;
  TextEditingController textEditingController;
  final String errorMessage;
  NameState({
    required this.textEditingController,
    required this.name,
    required this.errorMessage,
  });

  factory NameState.initial() {
    return NameState(
        name: "",
        textEditingController: TextEditingController(),
        errorMessage: "");
  }

  @override
  List<Object> get props => [name];

  NameState copyWith({
    String? name,
    TextEditingController? textEditingController,
    String? errorMessage,
  }) {
    return NameState(
      name: name ?? this.name,
      textEditingController:
          textEditingController ?? this.textEditingController,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
