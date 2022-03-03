part of 'size_bloc.dart';

class SizeState extends Equatable {
  final List<String> selectedSize;
  const SizeState({required this.selectedSize});

  factory SizeState.initial() {
    return const SizeState(selectedSize: []);
  }

  @override
  List<Object> get props => [selectedSize];

  SizeState copyWith({
    List<String>? selectedSize,
  }) {
    return SizeState(
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }
}
