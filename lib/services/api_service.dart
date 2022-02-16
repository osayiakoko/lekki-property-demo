import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lekki_proj_demo/models/api_response.dart';
import 'package:lekki_proj_demo/utils/constants.dart';
import 'package:lekki_proj_demo/utils/dio_exceptions.dart';
import 'package:lekki_proj_demo/utils/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class ApiService{
  late Dio dio;
  final String v1BaseUrl = "https://sfc-lekki-property.herokuapp.com/api/v1/";
  final endpoints = ApiEndpoints;

  ApiService(){
    final options = BaseOptions(
      baseUrl: v1BaseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
      headers: {
        "Content-Type": 'application/json'
      },
      validateStatus: (status) => true,
    );

    dio = Dio(options);

    dio.interceptors.add(PrettyDioLogger());

  }


  Future<APIResponse> _makeRequest(Future<Response> request) async {
    try {
      Response res = await request;

      logger.d('Status code Logger: ${res.statusCode.toString()}');
      logger.d('Data Logger: ${res.data.toString()}');


      if (res.statusCode! >= 200 && res.statusCode! <= 299){
        return APIResponse(
          status: res.data['status'], 
          message: res.data['message'],
          code: res.statusCode!,
          data: res.data['data']
        );
      }
      return APIResponse.error(res.data['error']['message']);
      
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      return APIResponse.error(errorMessage);
    } on SocketException catch (e) {
      logger.d(e.toString());
       return APIResponse.error('Please check your connection.');
    }
  }


  Future<APIResponse> get(path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> headers = const {},
  }) async {

    return _makeRequest(
      dio.get(
        "$path",
        queryParameters: queryParameters,
        options: Options(
          headers: {
            ...headers,
          },
        ),
      ),
    );
  }


  Future<APIResponse> post(path, {
    dynamic data,
    Map<String, dynamic> headers = const {},
  }) async {
    
    logger.d('Request data: $data');
    return _makeRequest(dio.post(
      "$path",
      data: data,
      options: Options(
        headers: {
          ...headers,
        },
      ),
    ));
  }

  
  Future<APIResponse> patch(path, {
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
  }) async {


    logger.d('Request data: $data');
    return _makeRequest(dio.patch(
      "$path",
      data: data,
      options: Options(
        headers: {
          ...headers,
        },
      ),
    ));
  }

  Future<APIResponse> put(path, {
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
  }) async {
    
    logger.d('Request data: $data');
    return _makeRequest(
      dio.put(
        "$path",
        data: data,
        options: Options(
          headers: {
            ...headers,
          },
        ),
      ),
    );
  }


  Future<APIResponse> delete(path, {
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
  }) async {

    logger.d('Request data: $data');
    return _makeRequest(
      dio.delete(
        "$path",
        data: data,
        options: Options(
          headers: {
            ...headers,
          },
        ),
      ),
    );
  }
}
