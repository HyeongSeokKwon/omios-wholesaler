part of 'myproducts_bloc.dart';

enum FetchStatus {
  unfetched,
  loading,
  fetched,
  error,
}

class MyproductsState extends Equatable {
  final List<dynamic> productsData;
  final FetchStatus fetchStatus;
  final String error;
  const MyproductsState({
    required this.productsData,
    required this.fetchStatus,
    required this.error,
  });

  factory MyproductsState.initial() {
    return const MyproductsState(
        productsData: [], fetchStatus: FetchStatus.unfetched, error: '');
  }

  @override
  List<Object?> get props => [productsData, fetchStatus, error];

  MyproductsState copyWith({
    List<dynamic>? productsData,
    FetchStatus? fetchStatus,
    String? error,
  }) {
    return MyproductsState(
      productsData: productsData ?? this.productsData,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      error: error ?? this.error,
    );
  }
}
