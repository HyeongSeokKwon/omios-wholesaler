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
    on<SearchMyProductsEvent>(searchProducts);
    on<ClickPatchButtonEvent>(patchUserInfo);
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
          totalProducts: myproductsData['count'],
          productsData: myproductsData,
          userInfoData: userInfoData,
          fetchStatus: FetchStatus.fetched));
    } catch (e) {
      emit(state.copyWith(fetchStatus: FetchStatus.error));
    }
  }

  Future<void> searchProducts(
      SearchMyProductsEvent event, Emitter<MypageState> emit) async {
    Map<String, dynamic> productData = {};
    try {
      productData = await mypageRepository.searchProducts(event.searchWord);
      infinityBloc.state.getData = productData;
      infinityBloc.state.productData = productData['results'];
      emit(state.copyWith(
          fetchStatus: FetchStatus.fetched, productsData: productData));
    } catch (e) {
      emit(state.copyWith(fetchStatus: FetchStatus.error));
    }
  }

  Future<void> patchUserInfo(
      ClickPatchButtonEvent event, Emitter<MypageState> emit) async {
    Map response;
    try {
      response = await mypageRepository.patchUserInfo(state.userInfoData);
      if (response['code'] == 201) {
        emit(state.copyWith(fetchStatus: FetchStatus.fetched));
      }
    } catch (e) {
      emit(state.copyWith(fetchStatus: FetchStatus.error));
    }
  }
}
