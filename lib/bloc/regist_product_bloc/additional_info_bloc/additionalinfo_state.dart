part of 'additionalinfo_bloc.dart';

class AdditionalInfoState extends Equatable {
  Map<String, dynamic> selectedAdditionalInfo;

  List<dynamic>? thicknessList;
  List<dynamic>? seeThroughList;
  List<dynamic>? elasticityList;
  List<dynamic>? liningList;
  AdditionalInfoState({
    required this.selectedAdditionalInfo,
    required this.thicknessList,
    required this.seeThroughList,
    required this.elasticityList,
    required this.liningList,
  });

  factory AdditionalInfoState.initial() {
    return AdditionalInfoState(
      selectedAdditionalInfo: {},
      thicknessList: const [],
      seeThroughList: const [],
      elasticityList: const [],
      liningList: const [],
    );
  }

  @override
  List<Object?> get props {
    return [
      selectedAdditionalInfo,
      thicknessList,
      seeThroughList,
      elasticityList,
      liningList,
    ];
  }

  AdditionalInfoState copyWith({
    Map<String, dynamic>? selectedAdditionalInfo,
    List<dynamic>? thicknessList,
    List<dynamic>? seeThroughList,
    List<dynamic>? elasticityList,
    List<dynamic>? liningList,
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
