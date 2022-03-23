part of 'manufacturecountry_bloc.dart';

class ManufacturecountryState extends Equatable {
  final String selectedCountry;
  final List countryList;

  const ManufacturecountryState({
    required this.selectedCountry,
    required this.countryList,
  });

  factory ManufacturecountryState.initial() {
    return const ManufacturecountryState(
        selectedCountry: '', countryList: ['한국', '중국', '기타']);
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
