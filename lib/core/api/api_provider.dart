import 'package:country_list_app/core/api/api_exception.dart';
import 'package:country_list_app/core/network/network_exception.dart';
import 'package:http/http.dart' as http;
import 'api_response.dart';
import '../network/network_connectivity.dart';

abstract class ApiProvider{
  Future<ApiResponse> get(String url);
}

class ApiProviderImpl extends ApiProvider{
  final http.Client client;
  final NetworkConnectivity networkInfo;

  ApiProviderImpl(this.networkInfo,this.client);

  @override
  Future<ApiResponse> get(String url) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await client.get(Uri.parse(url));
        return ApiResponse(statusCode: response.statusCode,data: response.body);
      } catch (error) {
        // Handle network errors, JSON parsing errors, etc.
        throw ApiException('API Request Error: $error');
      }
    }else {
      throw NetworkException('Please check internet connection and try again');
    }
  }
}