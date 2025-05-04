import 'dart:async';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class CircleMainLogic extends GetxController {
  Timer? _timer;
  var dialType = 0;
  var hmStr = '00:00'.obs;
  var hmdStr = ''.obs;
  var apmStr = 'AM'.obs;
  var fahrenheit = true.obs;
  var c = 22.0.obs;
  var f = 71.6.obs;

  var colorType = 0;

  var cityName  = 'NewYork'.obs;

  var type = 0.obs;
  var typeStr = 'Sunny'.obs;

  RxList<Color> colorList = <Color>[].obs;

  void startTimer() {
    _timer?.cancel();
    _timer = null;
    getData();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getData();
    });
  }

  bool isValidCoordinate(double lat, double lng) {
    return (lat >= -90 && lat <= 90) && (lng >= -180 && lng <= 180);
  }

  double cToFahrenheit(double c) {
    return (c * 9 / 5) + 32;
  }

  double fToCelsius(double f) {
    return (f - 32) * 5 / 9;
  }

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse('http://wttr.in/$city?format=j1');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        ),
      );

      String? city = '';
      if (isValidCoordinate(position.latitude, position.longitude)) {
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );

          if (placemarks.isEmpty) {
            return;
          }

          Placemark place = placemarks.first;
          city = place.locality;
          if (city == null || city.isEmpty) {
            city = place.subAdministrativeArea ?? place.administrativeArea;
          }
        } catch (_) {

        }
        if (city == null || city.isEmpty) {
          city = 'NewYork';
        }
        cityName.value = city!;
        final data = await fetchWeather(city!);
        final current = data['current_condition'][0];
        final weatherDec = '${current['weatherDesc'][0]['value']}';
        final weatherC = '${current['temp_C']}';
        c.value = double.parse(weatherC);
        f.value = cToFahrenheit(double.parse(weatherC));
        if (weatherDec == 'Sunny') {
          type.value = 0;
          typeStr.value = 'Sunny';
        } else if (weatherDec == 'Rain') {
          type.value = 2;
          typeStr.value = 'Rain';
        } else if (weatherDec == 'Snow') {
          type.value = 3;
          typeStr.value = 'Snow';
        } else if (weatherDec == 'Cloudy') {
          type.value = 1;
          typeStr.value = 'Cloudy';
        }
      }
    } else {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: Get.context!,
      builder: (ctx) => AlertDialog(
        title: const Text('Location permissions required'),
        content: const Text('Please grant location permission to get location'),
        actions: [
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('Setting'),
          ),
        ],
      ),
    );
  }

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final time24 = prefs.getBool('time24') ?? true;
    colorType = prefs.getInt('colorType') ?? 0;
    dialType = prefs.getInt('dialType') ?? 0;
    fahrenheit.value = prefs.getBool('fahrenheit') ?? true;

    colorList.value = graList[colorType];

    final now = DateTime.now();
    hmStr.value = DateFormat(time24 ? 'HH:mm' : 'hh:mm').format(now);
    apmStr.value = DateFormat('a').format(now);
    hmdStr.value = DateFormat("MM/dd/yyyy").format(now);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _checkLocationPermission();
    startTimer();
    super.onInit();
  }
}
