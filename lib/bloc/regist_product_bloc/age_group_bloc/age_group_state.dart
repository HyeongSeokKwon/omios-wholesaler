part of 'age_group_bloc.dart';

class AgeGroupState extends Equatable {
  List ageGroupList;
  int selectedAgeGroupId;

  AgeGroupState({
    required this.ageGroupList,
    required this.selectedAgeGroupId,
  });

  factory AgeGroupState.initial() {
    return AgeGroupState(ageGroupList: [], selectedAgeGroupId: -1);
  }

  @override
  List<Object> get props => [ageGroupList, selectedAgeGroupId];

  AgeGroupState copyWith({
    List? ageGroupList,
    int? selectedAgeGroupId,
  }) {
    return AgeGroupState(
      ageGroupList: ageGroupList ?? this.ageGroupList,
      selectedAgeGroupId: selectedAgeGroupId ?? this.selectedAgeGroupId,
    );
  }
}
