import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/repository/mypage_repository.dart';
import 'package:equatable/equatable.dart';

part 'mypage_event.dart';
part 'mypage_state.dart';

class MypageBloc extends Bloc<MypageEvent, MypageState> {
  final MypageRepository mypageRepository;
  final InfinityScrollBloc infinityBloc;
  MypageBloc({required this.mypageRepository, required this.infinityBloc})
      : super(MypageState.initial()) {
    on<LoadMyProductsEvent>(getMyproducts);
  }

  Future<void> getMyproducts(
      LoadMyProductsEvent event, Emitter<MypageState> emit) async {
    try {
      Map<String, dynamic> userInfoData = await mypageRepository.getUserInfo();
      Map<String, dynamic> myproductsData =
          await mypageRepository.getMyproducts();

      infinityBloc.state.getData = myproductsData;
      infinityBloc.state.productData = myproductsData['results'];

      emit(state.copyWith(
          productsData: myproductsData,
          userInfoData: userInfoData,
          fetchStatus: FetchStatus.fetched));
    } catch (e) {
      emit(state.copyWith(fetchStatus: FetchStatus.error));
    }
  }
}
