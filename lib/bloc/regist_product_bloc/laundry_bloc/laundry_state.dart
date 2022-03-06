part of 'laundry_bloc.dart';

class LaundryState extends Equatable {
  final List<String> selectedLaundry;
  List<String> washingList;

  LaundryState({
    required this.selectedLaundry,
    required this.washingList,
  });

  factory LaundryState.initial() {
    List<String> getWashingList = [
      "손세탁",
      "드라이클리닝",
      "물세탁",
      "단독세탁",
      "울세탁",
      "표백제 사용금지",
      "다림질 금지",
      "세탁기 금지"
    ];
    return LaundryState(selectedLaundry: [], washingList: getWashingList);
  }

  @override
  List<Object> get props => [selectedLaundry];

  LaundryState copyWith({
    List<String>? selectedLaundry,
  }) {
    return LaundryState(
      selectedLaundry: selectedLaundry ?? this.selectedLaundry,
      washingList: washingList,
    );
  }
}
