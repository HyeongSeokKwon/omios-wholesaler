part of 'data_gather_bloc.dart';

class DataGatherState extends Equatable {
  final FetchState fetchState;
  final bool isAllVerified;
  final Map registData;
  final String error;
  const DataGatherState(
      {required this.fetchState,
      required this.isAllVerified,
      required this.registData,
      required this.error});

  factory DataGatherState.initial() {
    return const DataGatherState(
        fetchState: FetchState.initial,
        isAllVerified: false,
        registData: {},
        error: '');
  }

  DataGatherState copyWith({
    FetchState? fetchState,
    bool? isAllVerified,
    Map? registData,
    String? error,
  }) {
    return DataGatherState(
      fetchState: fetchState ?? this.fetchState,
      isAllVerified: isAllVerified ?? this.isAllVerified,
      registData: registData ?? this.registData,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [fetchState, isAllVerified, registData, error];
}
