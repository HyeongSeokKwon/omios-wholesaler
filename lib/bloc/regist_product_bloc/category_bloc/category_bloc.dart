import 'package:equatable/equatable.dart';

import '../../bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState.initial()) {
    on<ClickMainCategoryEvent>(clickMainCategory);
    on<ClickSubCategoryEvent>(clickSubCategory);
  }

  void clickMainCategory(
      ClickMainCategoryEvent event, Emitter<CategoryState> emit) {
    emit(
      state.copyWith(
        selectedMainCategory: state.categoryInfo![event.mainCategoryIndex],
        subCategoryInfo: state.categoryInfo![event.mainCategoryIndex]
            ['sub_category'],
        selectedSubCategory: {},
      ),
    );
  }

  Future<void> clickSubCategory(
      ClickSubCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(
        selectedSubCategory: state.subCategoryInfo[event.subCategoryIndex]));
  }
}
