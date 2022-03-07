part of 'additionalinfo_bloc.dart';

class AdditionalInfoState extends Equatable {
  final Map<String, String> selectedAdditionalInfo;

  final List<String> thicknessList;
  final List<String> seeThroughList;
  final List<String> elasticityList;
  final List<String> liningList;
  const AdditionalInfoState({
    required this.selectedAdditionalInfo,
    required this.thicknessList,
    required this.seeThroughList,
    required this.elasticityList,
    required this.liningList,
  });

  factory AdditionalInfoState.initial() {
    List<String> thickness = ["두꺼움", "중간", "없음"];
    List<String> seeThrough = ["높음", "중간", "없음"];
    List<String> elasticity = ["높음", "중간", "없음"];
    List<String> lining = ["있음", "없음"];

    return AdditionalInfoState(
      selectedAdditionalInfo: const {},
      thicknessList: thickness,
      seeThroughList: seeThrough,
      elasticityList: elasticity,
      liningList: lining,
    );
  }

  @override
  List<Object> get props {
    return [
      selectedAdditionalInfo,
      thicknessList,
      seeThroughList,
      elasticityList,
      liningList,
    ];
  }

  AdditionalInfoState copyWith({
    Map<String, String>? selectedAdditionalInfo,
    List<String>? thicknessList,
    List<String>? seeThroughList,
    List<String>? elasticityList,
    List<String>? liningList,
  }) {
    return AdditionalInfoState(
      selectedAdditionalInfo:
          selectedAdditionalInfo ?? this.selectedAdditionalInfo,
      thicknessList: thicknessList ?? this.thicknessList,
      seeThroughList: seeThroughList ?? this.seeThroughList,
      elasticityList: elasticityList ?? this.elasticityList,
      liningList: liningList ?? this.liningList,
    );
  }
}
