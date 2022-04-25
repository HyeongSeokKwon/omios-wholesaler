part of 'inititem_bloc.dart';

enum FetchState { success, failure, loading, initial, error }
enum RegistMode { regist, edit }

class InititemState extends Equatable {
  FetchState fetchState;
  late RegistMode? registMode;
  final String error;
  InititemState(
      {required this.fetchState, this.registMode, required this.error});

  factory InititemState.initial() {
    return InititemState(fetchState: FetchState.initial, error: '');
  }

  @override
  List<Object> get props => [fetchState, error];

  InititemState copyWith({
    FetchState? fetchState,
    String? error,
  }) {
    return InititemState(
      fetchState: fetchState ?? this.fetchState,
      error: error ?? this.error,
    );
  }
}
