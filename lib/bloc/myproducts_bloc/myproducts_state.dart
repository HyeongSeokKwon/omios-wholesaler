part of 'myproducts_bloc.dart';

enum FetchStatus {
  unfetched,
  loading,
  fetched,
  error,
}

class MyproductsState extends Equatable {
  List<dynamic> productsData;
  FetchStatus fetchStatus;
  MyproductsState({
    required this.productsData,
    required this.fetchStatus,
  });

  factory MyproductsState.initial() {
    return MyproductsState(
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
