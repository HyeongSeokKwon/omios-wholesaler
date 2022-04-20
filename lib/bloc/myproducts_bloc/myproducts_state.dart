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
  const MyproductsState({
    required this.productsData,
    required this.fetchStatus,
  });

  factory MyproductsState.initial() {
    return const MyproductsState(
        productsData: [], fetchStatus: FetchStatus.unfetched);
  }

  @override
  List<Object?> get props => [productsData, fetchStatus];

  MyproductsState copyWith({
    List<dynamic>? productsData,
    FetchStatus? fetchStatus,
  }) {
    return MyproductsState(
      productsData: productsData ?? this.productsData,
      fetchStatus: fetchStatus ?? this.fetchStatus,
    );
  }
}
