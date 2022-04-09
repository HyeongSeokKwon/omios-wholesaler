part of 'laundry_bloc.dart';

class LaundryState extends Equatable {
  List<Map> selectedLaundry;
  List<dynamic> washingList;

  LaundryState({
    required this.selectedLaundry,
    required this.washingList,
  });

  factory LaundryState.initial() {
    return LaundryState(selectedLaundry: [], washingList: []);
  }

  @override
  List<Object> get props => [selectedLaundry, washingList];

  LaundryState copyWith({
    List<Map>? selectedLaundry,
    List<dynamic>? washingList,
  }) {
    return LaundryState(
      selectedLaundry: selectedLaundry ?? this.selectedLaundry,
      washingList: washingList ?? this.washingList,
    );
  }
}
