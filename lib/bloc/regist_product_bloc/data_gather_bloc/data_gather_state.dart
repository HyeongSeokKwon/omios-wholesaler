part of 'data_gather_bloc.dart';

class DataGatherState extends Equatable {
  final bool isAllVerified;
  final Map registData;
  final String error;
  const DataGatherState(
      {required this.isAllVerified,
      required this.registData,
      required this.error});

  factory DataGatherState.initial() {
    return const DataGatherState(
        isAllVerified: false, registData: {}, error: '');
  }

  DataGatherState copyWith({
    bool? isAllVerified,
    Map? registData,
    String? error,
  }) {
    return DataGatherState(
      isAllVerified: isAllVerified ?? this.isAllVerified,
      registData: registData ?? this.registData,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [isAllVerified, registData, error];
}
