import 'dart:convert';
import 'package:http/http.dart';

import 'package:frontend/models/barber.dart';
import 'package:frontend/models/barber_store.dart';
import 'package:frontend/models/barber_store_service.dart';
import 'package:frontend/models/slot.dart';
import 'package:frontend/api/base_client_utility.dart';

abstract class ApiClient {
  static Future<List<BarberStore>> getBarberStore() async {
    final List<BarberStore> result = [];
    Response response = await BaseClientUtility.getData('/barber-stores/list', {});

    final Status status = BaseClientUtility.getStatusFromResponse(response);
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
    Response response = await BaseClientUtility.getData("/barber-stores/$barberStoreId/barbers/list", {});

    final Status status = BaseClientUtility.getStatusFromResponse(response);
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

  static Future<List<BarberStoreService>> getServices(int barberStoreId) async {
    final List<BarberStoreService> result = [];
    Response response = await BaseClientUtility.getData("/barber-stores/$barberStoreId/services/list", {});

    final Status status = BaseClientUtility.getStatusFromResponse(response);
    if(status == Status.ok) {
      final Map<String, dynamic> parsedBody = jsonDecode(response.body);

      if(parsedBody.containsKey('services')) {
        for (var service in (parsedBody['services'] as List<dynamic>)) {
          result.add(BarberStoreService(
            barberServiceId: service['barber_service_id'],
            serviceName: service['service_name'],
            servicePrice: service['service_price'],
            duration: service['duration']
          ));
        }
      }
    }

    return result;
  }

  static Future<List<Slot>> getSlots(int barberStoreId, DateTime day, int barberId, int serviceId) async {
    final List<Slot> result = [];
    Response response = await BaseClientUtility.getData(
      "/barber-stores/$barberStoreId/day/${day.day}/${day.month}/${day.year}/barber/$barberId/service/$serviceId/open-reservation", {},
    );
    
    final Status status = BaseClientUtility.getStatusFromResponse(response);
    if(status == Status.ok) {
      final Map<String, dynamic> parsedBody = jsonDecode(response.body);
      
      if(parsedBody.containsKey('slots')) {
        for(var slot in (parsedBody['slots'] as List<dynamic>)) {
          result.add(Slot(
            startTime: slot['startTime'],
            endTime: slot['endTime']
          ));
        }
      }
    }

    return result;
  }

  static Future<int?> bookAppointment(int barberStoreId, DateTime day, int barberId, int serviceId, String slotStart, String slotEnd, String phone) async {
    int ?reservationId;

    Response response = await BaseClientUtility.postData(
      "/barber-stores/$barberStoreId/day/${day.day}/${day.month}/${day.year}/barber/$barberId/service/$serviceId/slot/$slotStart/$slotEnd/book-reservation", {},
      {'phone': phone}
    );

    final Status status = BaseClientUtility.getStatusFromResponse(response);
    if(status == Status.ok) {
      var data = jsonDecode(response.body);

      reservationId = int.parse(data['reservationId'][0]);
    }

    return reservationId;
  }
}