import 'package:get/get.dart';
import '../constants/api_constants.dart';

class ApiService extends GetxService {
  final GetConnect _connect = GetConnect();

  @override
  void onInit() {
    super.onInit();
    _connect.baseUrl = ApiConstants.baseUrl;
    _connect.timeout = const Duration(milliseconds: ApiConstants.connectTimeout);
    
    // Add request modifiers, authentications, etc.
    _connect.httpClient.addRequestModifier<dynamic>((request) {
      // e.g. inject token here
      return request;
    });
  }

  // Generic wrapper for GET
  Future<Response> getRequest(String url) async {
    try {
      final response = await _connect.get(url);
      return _validateResponse(response);
    } catch (e) {
      return Response(statusCode: 500, statusText: e.toString());
    }
  }

  // Generic wrapper for POST
  Future<Response> postRequest(String url, dynamic body) async {
    try {
      final response = await _connect.post(url, body);
      return _validateResponse(response);
    } catch (e) {
      return Response(statusCode: 500, statusText: e.toString());
    }
  }

  Response _validateResponse(Response response) {
    if (response.hasError) {
      // global error logging can go here
    }
    return response;
  }
}
