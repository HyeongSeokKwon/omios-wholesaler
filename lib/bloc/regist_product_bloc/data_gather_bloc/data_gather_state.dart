part of 'data_gather_bloc.dart';

enum GatherState { initial, progress, success, failure }

class DataGatherState extends Equatable {
  final FetchState fetchState;
  final bool isAllVerified;
  final GatherState gatherState;
  final Map registData;
  final String error;
  const DataGatherState(
      {required this.fetchState,
      required this.isAllVerified,
      required this.gatherState,
      required this.registData,
      required this.error});

  factory DataGatherState.initial() {
    return const DataGatherState(
        fetchState: FetchState.initial,
        isAllVerified: false,
        gatherState: GatherState.initial,
        registData: {},
        error: '');
  }

  DataGatherState copyWith({
    FetchState? fetchState,
    bool? isAllVerified,
    GatherState? gatherState,
    Map? registData,
    String? error,
  }) {
    return DataGatherState(
      fetchState: fetchState ?? this.fetchState,
      isAllVerified: isAllVerified ?? this.isAllVerified,
      gatherState: gatherState ?? this.gatherState,
      registData: registData ?? this.registData,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props =>
      [fetchState, isAllVerified, gatherState, registData, error];
}
