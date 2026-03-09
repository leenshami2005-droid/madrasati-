/* 
import 'package:dio/dio.dart';
import 'package:weather_app/models/weathermodel.dart';

class weatherservice {
  final Dio dio;
  weatherservice(this.dio);

  Future<WeatherModel?> getcurrentweather({required String cityname}) async {
    try {
      String baseUrl = "http://api.weatherapi.com/v1";
      String key = "9f77a047524c4a159e283335260402";

      Response response = await dio.get(
        "$baseUrl/forecast.json?key=$key&q=$cityname&days=1&aqi=no&alerts=no",
      );

      WeatherModel weathermodel = WeatherModel.fromJson(response.data);

      return weathermodel;
    } on DioException catch (e) {
      final String errormsg =
          e.response?.data['error']['message'] ??
          "sorry theres error try later";
      throw Exception(errormsg);
    } catch (e) {
      throw Exception("ops theres error");
    }
  }
}




















*/