part of 'manufacturecountry_bloc.dart';

class ManufacturecountryState extends Equatable {
  String selectedCountry;
  final List countryList;

  ManufacturecountryState({
    required this.selectedCountry,
    required this.countryList,
  });

  factory ManufacturecountryState.initial() {
    return ManufacturecountryState(
        selectedCountry: '', countryList: const ['한국', '중국', '기타']);
  }

  @override
  List<Object> get props => [selectedCountry, countryList];

  ManufacturecountryState copyWith({
    String? selectedCountry,
    List? countryList,
  }) {
    return ManufacturecountryState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      countryList: countryList ?? this.countryList,
    );
  }
}
