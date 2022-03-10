part of 'inititem_bloc.dart';

enum FetchState { success, dynamicSuccess, failure, loading, initial }

class InititemState extends Equatable {
  final FetchState fetchState;
  const InititemState({
    required this.fetchState,
  });

  factory InititemState.initial() {
    return const InititemState(fetchState: FetchState.initial);
  }

  @override
  List<Object> get props => [fetchState];

  InititemState copyWith({
    FetchState? fetchState,
  }) {
    return InititemState(
      fetchState: fetchState ?? this.fetchState,
    );
  }
}
