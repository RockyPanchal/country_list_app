import 'package:bloc_test/bloc_test.dart';
import 'package:country_list_app/features/country/domain/use_cases/countries_usecase.dart';
import 'package:country_list_app/features/country/domain/entity/country_entity.dart';
import 'package:country_list_app/features/country/presentation/bloc/country_bloc.dart';
import 'package:country_list_app/features/country/presentation/bloc/country_events.dart';
import 'package:country_list_app/features/country/presentation/bloc/country_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockCountriesUseCase extends Mock implements CountriesUseCase {} // Mock use case


void main() {

  group('CountryBloc', () {

    late MockCountriesUseCase mockCountriesUseCase;
    late CountryBloc countryBloc;

    setUp(() {
      mockCountriesUseCase = MockCountriesUseCase();
      countryBloc = CountryBloc(countriesUseCase: mockCountriesUseCase);
    });

    tearDown(() {
      countryBloc.close(); // Clean up BLoC instance
    });

    test('initial state is CountryInitial', () {
      expect(countryBloc.state, CountryInitial());
    });

    final mockCountryData = [CountryEntity( countryName: 'india')];

    blocTest<CountryBloc, CountryState>(
      'emits [CountryLoading, CountriesLoaded] when LoadCountriesEvent is added successfully',
      build: () {
        when(() => mockCountriesUseCase.execute()).thenAnswer((_) async => mockCountryData);
        return countryBloc;
      },
      act: (bloc) => bloc.add(LoadCountriesEvent()),
      expect: () => [
        isA<CountryLoading>(),
        isA<CountriesLoaded>(),
      ],
    );

    blocTest<CountryBloc, CountryState>(
      'emits [CountryLoading, CountryError] when LoadCountriesEvent fails',
      build: () {
        when(() => mockCountriesUseCase.execute()).thenThrow(Exception('Failed to load countries'));
        return countryBloc;
      },
      act: (bloc) => bloc.add(LoadCountriesEvent()),
      expect: () => [
        isA<CountryLoading>(),
        isA<CountryError>(),
      ],
    );

  });
}

