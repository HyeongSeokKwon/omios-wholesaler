part of 'inititem_bloc.dart';

enum FetchState { success, failure, loading, initial }
enum RegistMode { regist, edit }

class InititemState extends Equatable {
  final FetchState fetchState;
  late RegistMode? registMode;
  InititemState({required this.fetchState, this.registMode});

  factory InititemState.initial() {
    return InititemState(fetchState: FetchState.initial);
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
