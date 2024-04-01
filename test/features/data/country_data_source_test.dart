import 'package:country_list_app/core/api/api_provider.dart';
import 'package:country_list_app/core/api/api_response.dart';
import 'package:country_list_app/core/network/network_connectivity.dart';
import 'package:country_list_app/features/country/data/data_source/country_data_source.dart';
import 'package:country_list_app/features/country/data/model/country_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworkConnectivityImpl extends Mock
    implements NetworkConnectivityImpl {}

class MockClient extends Mock implements ApiProviderImpl {}

void main() {

  group('country_data_source - ', () {

    late CountryDataSourceImpl dataSource;
    late MockClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockClient();
      dataSource = CountryDataSourceImpl(mockHttpClient);
      registerFallbackValue(Uri());
    });

    group('fetchCountries function', () {

      // Successful Scenario
      test('fetchCountries_success_returnsListOfCountries', () async {
        var mockSuccessResponse = ApiResponse(
            statusCode: 200,
            data: '{"status": "OK","status-code": 200,"version": "1.0","access": "public","data":{"DZ":{"country":"Algeria","region":"Africa"}, "AO": {"country": "Angola", "region": "Africa"}}}',
            );
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => mockSuccessResponse);
        // Act
        final result = await dataSource.fetchCountries();
        // Assert
        expect(result.first, isA<Country>());
      });

      // Error: API response with non-200 status code
      var mockErrorResponse = ApiResponse(
        statusCode: 404,
        data: null,
      );
      test('fetchCountries_apiError_throwsException', () async {
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => mockErrorResponse); // Example non-200 response
        // Act & Assert
        expect(dataSource.fetchCountries(), throwsException);
      });

    });

  });

}
