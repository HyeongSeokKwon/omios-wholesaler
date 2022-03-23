import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'manufacturecountry_event.dart';
part 'manufacturecountry_state.dart';

class ManufacturecountryBloc
    extends Bloc<ManufacturecountryEvent, ManufacturecountryState> {
  ManufacturecountryBloc() : super(ManufacturecountryState.initial()) {
    on<SelectCountryEvent>(selectCountry);
    on<EditCountryEvent>(editCountry);
  }

  void selectCountry(
      SelectCountryEvent event, Emitter<ManufacturecountryState> emit) {
    emit(state.copyWith(selectedCountry: event.country));
  }

  void editCountry(
      EditCountryEvent event, Emitter<ManufacturecountryState> emit) {
    List copy = [...state.countryList];
    copy.add(event.country);
    emit(state.copyWith(selectedCountry: event.country, countryList: copy));
  }
}
