part of 'inititem_bloc.dart';

class InitEditItemState extends Equatable {
  final FetchState fetchState;
  final Map data;

  const InitEditItemState({
    required this.fetchState,
    required this.data,
  });

  factory InitEditItemState.initial() {
    return const InitEditItemState(fetchState: FetchState.initial, data: {});
  }

  @override
  List<Object> get props => [fetchState, data];

  InitEditItemState copyWith({
    FetchState? fetchState,
    Map? data,
  }) {
    return InitEditItemState(
      fetchState: fetchState ?? this.fetchState,
      data: data ?? this.data,
    );
  }
}
