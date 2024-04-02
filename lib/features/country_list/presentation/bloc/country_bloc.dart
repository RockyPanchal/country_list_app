import 'package:country_list_app/features/country_list/domain/use_cases/countries_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'country_events.dart';
import 'country_states.dart';


class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountriesUseCase countriesUseCase;

  CountryBloc({required this.countriesUseCase}) : super(CountryInitial()) {
    on<LoadCountriesEvent>((event, emit) => _onLoadCountriesEvent(event, emit));
  }

  Future<void> _onLoadCountriesEvent(LoadCountriesEvent event, Emitter<CountryState> emit) async {
    emit(CountryLoading());
    try {
      final data = await countriesUseCase.execute();
      emit(CountriesLoaded(data));
    } catch (error) {
      emit(CountryError(error.toString()));
    }
  }
}
