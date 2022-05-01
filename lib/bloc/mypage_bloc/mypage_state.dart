part of 'mypage_bloc.dart';

enum FetchStatus {
  unfetched,
  loading,
  fetched,
  error,
}

class MypageState extends Equatable {
  final Map<String, dynamic> productsData;
  final Map<String, dynamic> userInfoData;
  final FetchStatus fetchStatus;
  final String error;

  const MypageState({
    required this.productsData,
    required this.userInfoData,
    required this.fetchStatus,
    required this.error,
  });

  factory MypageState.initial() {
    return const MypageState(
        productsData: {},
        userInfoData: {},
        fetchStatus: FetchStatus.unfetched,
        error: '');
  }

  @override
  List<Object?> get props => [productsData, userInfoData, fetchStatus, error];

  MypageState copyWith({
    Map<String, dynamic>? productsData,
    Map<String, dynamic>? userInfoData,
    FetchStatus? fetchStatus,
    String? error,
  }) {
    return MypageState(
      productsData: productsData ?? this.productsData,
      userInfoData: userInfoData ?? this.userInfoData,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      error: error ?? this.error,
    );
  }
}
