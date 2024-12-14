import 'dart:convert';

import 'package:frontend/models/barber.dart';
import 'package:frontend/models/barber_store.dart';
import 'package:http/http.dart';
import 'package:frontend/meta/constants.dart';

enum Status { ok, forbidden, error }

abstract class ApiClient {

  static Future<Uri> _buildUrl(String path) async {
    return Uri.parse(await Constants.baseUrl()+path);
  }

  static Map<String,String> _parseHeaders(Map<String, dynamic> header) {
    final Map<String, String> parsedHeader = {};

    header.forEach((key, value) {
      parsedHeader[key] = value.toString();
    });

    return parsedHeader;
  }

  static Status _getStatusFromResponse(Response response) {
    if (response.statusCode == 200) {
      return Status.ok;
    } else if (response.statusCode == 403) {
      return Status.forbidden;
    } else {
      return Status.error;
    }
  }

  static Future<Response> getData(String path, Map<String, dynamic> headers) async {
    final url = await _buildUrl(path);

    //ToDo: implement authentication

    return await get(
      url,
      headers: _parseHeaders(headers)
    );
  }

  static Future<List<BarberStore>> getBarberStore() async {
    final List<BarberStore> result = [];
    Response response = await getData('/barber-stores/list', {});

    final Status status = _getStatusFromResponse(response);
    if(status == Status.ok) {
      final Map<String, dynamic> parsedBody = jsonDecode(response.body);

      if(parsedBody.containsKey('barberStores')) {
        for (var store in (parsedBody['barberStores'] as List<dynamic>)) {
          result.add(BarberStore(
              barberStoreId: store['barber_store_id'],
              name: store['name'],
              address: store['address']
          ));
        }
      }
    }

    return result;
  }

  static Future<List<Barber>> getBarbers(int barberStoreId) async {
    final List<Barber> result = [];
    Response response = await getData("/barber-stores/$barberStoreId/barbers/list", {});

    final Status status = _getStatusFromResponse(response);
    if(status == Status.ok) {
      final Map<String, dynamic> parsedBody = jsonDecode(response.body);

      if(parsedBody.containsKey('barbers')) {
        for (var barber in (parsedBody['barbers'] as List<dynamic>)) {
          result.add(Barber(
            barberId: barber['barber_id'],
            name: barber['name'],
            imgUrl: barber['img_url']
          ));
        }
      }
    }

    return result;
  }
}