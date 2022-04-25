part of 'inititem_bloc.dart';

class InitEditItemState extends Equatable {
  final FetchState fetchState;
  final Map data;
  final List color;
  final List size;

  const InitEditItemState({
    required this.fetchState,
    required this.data,
    required this.color,
    required this.size,
  });

  factory InitEditItemState.initial() {
    return const InitEditItemState(
        fetchState: FetchState.initial, data: {}, color: [], size: []);
  }

  @override
  List<Object> get props => [fetchState, data, color, size];

  InitEditItemState copyWith({
    FetchState? fetchState,
    Map? data,
    List? color,
    List? size,
  }) {
    return InitEditItemState(
      fetchState: fetchState ?? this.fetchState,
      data: data ?? this.data,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }
}
