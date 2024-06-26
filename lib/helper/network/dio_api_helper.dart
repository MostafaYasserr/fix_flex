import 'package:dio/dio.dart';
import 'package:fix_flex/helper/network/dio_interceptors.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../constants/end_points/end_points.dart';

class DioApiHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );

    dio.interceptors.add(DioInterceptors());
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    try {
      return await dio.post(url,
          queryParameters: query,
          data: data,
          options: Options(
            validateStatus: (_) => true,
          ));
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  static Future<Response> putData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    try {
      Response response = await dio.put(
        url,
        data: data,
        queryParameters: query,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }




  static Future<Response> patchData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    try {
      Response response = await dio.patch(
        url,
        data: data,
        queryParameters: query,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.get(url,
          queryParameters: query,
          options: Options(
            validateStatus: (_) => true,
          ));
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    try {
      return await dio.delete(url, queryParameters: query, data: data);
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
