part of 'manufacturecountry_bloc.dart';

abstract class ManufacturecountryEvent extends Equatable {
  const ManufacturecountryEvent();

  @override
  List<Object> get props => [];
}

class SelectCountryEvent extends ManufacturecountryEvent {
  final String country;
  const SelectCountryEvent({
    required this.country,
  });
}

class EditCountryEvent extends ManufacturecountryEvent {
  final String country;
  const EditCountryEvent({
    required this.country,
  });
}
