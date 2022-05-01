import 'package:deepy_wholesaler/repository/mypage_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mypage_event.dart';
part 'mypage_state.dart';

class MypageBloc extends Bloc<MypageEvent, MypageState> {
  final MypageRepository mypageRepository;
  MypageBloc({required this.mypageRepository}) : super(MypageState.initial()) {
    on<LoadMyProductsEvent>(getMyproducts);
  }

  Future<void> getMyproducts(
      LoadMyProductsEvent event, Emitter<MypageState> emit) async {
    try {
      Map<String, dynamic> userInfoData = await mypageRepository.getUserInfo();
      List<dynamic> myproductsData = await mypageRepository.getMyproducts();

      print(userInfoData);
      print(myproductsData);
      emit(state.copyWith(
          productsData: myproductsData,
          userInfoData: userInfoData,
          fetchStatus: FetchStatus.fetched));
    } catch (e) {
      emit(state.copyWith(fetchStatus: FetchStatus.error));
    }
  }
}
