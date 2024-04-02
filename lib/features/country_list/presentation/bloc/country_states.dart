import 'package:country_list_app/features/country_list/domain/entity/country_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CountryState extends Equatable{}

class CountryInitial extends CountryState {
  @override
  List<Object?> get props => [];
}

class CountryLoading extends CountryState {
  @override
  List<Object> get props => [];
}

class CountriesLoaded extends CountryState {
  final List<CountryEntity> countries;

  CountriesLoaded(this.countries);
  @override
  List<Object> get props => [countries];
}

class CountryError extends CountryState {
  final String message;

  CountryError(this.message);

  @override
  List<Object> get props => [message];
}
