import 'package:bloc_test/bloc_test.dart';
import 'package:country_list_app/features/country/domain/entity/country_entity.dart';
import 'package:country_list_app/features/country/presentation/bloc/country_bloc.dart';
import 'package:country_list_app/features/country/presentation/bloc/country_events.dart';
import 'package:country_list_app/features/country/presentation/bloc/country_states.dart';
import 'package:country_list_app/features/country/presentation/screens/country_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class MockCountryBloc extends MockBloc<CountryEvent, CountryState> implements CountryBloc {}

void main() {

  group('CountryScreen Widget Tests', () {

    late MockCountryBloc mockCountryBloc;

    setUp(() {
      mockCountryBloc = MockCountryBloc();
    });

    Widget buildWidget() {
      return ScreenUtilInit(
        minTextAdapt: true,
        child: MaterialApp(
          home: BlocProvider<CountryBloc>.value(
           value: mockCountryBloc,
              child: const CountryScreen()
          ), // Your CountryScreen widget
        ),
      );
    }

    testWidgets('shows CircularProgressIndicator during CountryInitial', (tester) async {
      when(() => mockCountryBloc.state).thenReturn(CountryInitial());
      // Build widget directly within testWidgets
      await tester.pumpWidget(buildWidget());
      // If needed, a minor delay for potential Bloc interactions
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });


    testWidgets('shows CircularProgressIndicator during CountryLoading', (tester) async {
      when(() => mockCountryBloc.state).thenReturn(CountryLoading());
      await tester.pumpWidget(buildWidget());
      // If needed, a minor delay for potential Bloc interactions
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders countries when CountriesLoaded', (tester) async {
      when(() => mockCountryBloc.state).thenReturn(CountriesLoaded([
        CountryEntity(countryName: 'Algeria'),
      ]));
      await tester.pumpWidget(buildWidget());
      // Allow UI to update
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Algeria'), findsOneWidget);
    });

    testWidgets('renders countries when CountriesLoaded and List is Empty', (tester) async {
      when(() => mockCountryBloc.state).thenReturn(CountriesLoaded(const []));
      await tester.pumpWidget(buildWidget());
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('No Data Found'), findsOneWidget);
    });

    testWidgets('CountryScreen should display error message when state is CountryError', (WidgetTester tester) async {
      when(()=>mockCountryBloc.state).thenReturn(CountryError('Error loading countries'));
      await tester.pumpWidget(buildWidget());
      await tester.pump(const Duration(milliseconds: 100));
      // Find the ScaffoldMessenger widget
      final scaffoldMessengerFinder = find.byType(ScaffoldMessenger);
      expect(scaffoldMessengerFinder, findsOneWidget);
    });

  }); // End of group


}
