part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class ClickMainCategoryEvent extends CategoryEvent {
  final int mainCategoryIndex;
  const ClickMainCategoryEvent({
    required this.mainCategoryIndex,
  });
}

class ClickSubCategoryEvent extends CategoryEvent {
  final int subCategoryIndex;
  const ClickSubCategoryEvent({
    required this.subCategoryIndex,
  });
}
