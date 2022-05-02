part of 'mypage_bloc.dart';

enum FetchStatus {
  unfetched,
  loading,
  fetched,
  error,
}

class MypageState extends Equatable {
  final int totalProducts;
  final Map<String, dynamic> productsData;
  final Map<String, dynamic> userInfoData;
  final FetchStatus fetchStatus;
  final String error;

  const MypageState({
    required this.totalProducts,
    required this.productsData,
    required this.userInfoData,
    required this.fetchStatus,
    required this.error,
  });

  factory MypageState.initial() {
    return const MypageState(
        totalProducts: 0,
        productsData: {},
        userInfoData: {},
        fetchStatus: FetchStatus.unfetched,
        error: '');
  }

  @override
  List<Object?> get props =>
      [totalProducts, productsData, userInfoData, fetchStatus, error];

  MypageState copyWith({
    int? totalProducts,
    Map<String, dynamic>? productsData,
    Map<String, dynamic>? userInfoData,
    FetchStatus? fetchStatus,
    String? error,
  }) {
    return MypageState(
      totalProducts: totalProducts ?? this.totalProducts,
      productsData: productsData ?? this.productsData,
      userInfoData: userInfoData ?? this.userInfoData,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      error: error ?? this.error,
    );
  }
}
