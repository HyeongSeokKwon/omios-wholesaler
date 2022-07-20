part of 'mypage_bloc.dart';

abstract class MypageEvent extends Equatable {
  const MypageEvent();

  @override
  List<Object> get props => [];
}

class LoadMyProductsEvent extends MypageEvent {}

class LoadMyInfovEvent extends MypageEvent {}

class SearchMyProductsEvent extends MypageEvent {
  final String searchWord;
  const SearchMyProductsEvent({required this.searchWord});
}

class GetWholeSalerInfoEvent extends MypageEvent {}

class ClickPatchButtonEvent extends MypageEvent {}
