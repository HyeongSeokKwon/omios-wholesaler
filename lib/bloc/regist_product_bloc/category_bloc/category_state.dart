part of 'category_bloc.dart';

class CategoryState extends Equatable {
  List? categoryInfo;
  List subCategoryInfo;
  Map selectedMainCategory;
  Map selectedSubCategory;
  CategoryState({
    required this.categoryInfo,
    required this.selectedMainCategory,
    required this.selectedSubCategory,
    required this.subCategoryInfo,
  });

  factory CategoryState.initial() {
    return CategoryState(
      categoryInfo: const [],
      selectedMainCategory: const {},
      selectedSubCategory: const {},
      subCategoryInfo: const [],
    );
  }

  @override
  List<Object?> get props {
    return [
      categoryInfo,
      subCategoryInfo,
      selectedMainCategory,
      selectedSubCategory,
    ];
  }

  CategoryState copyWith({
    List? categoryInfo,
    List? subCategoryInfo,
    Map? selectedMainCategory,
    Map? selectedSubCategory,
  }) {
    return CategoryState(
      categoryInfo: categoryInfo ?? this.categoryInfo,
      subCategoryInfo: subCategoryInfo ?? this.subCategoryInfo,
      selectedMainCategory: selectedMainCategory ?? this.selectedMainCategory,
      selectedSubCategory: selectedSubCategory ?? this.selectedSubCategory,
    );
  }
}
