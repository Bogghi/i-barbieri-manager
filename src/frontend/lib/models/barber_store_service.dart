class BarberStoreService {
  int barberServiceId;
  String serviceName;
  int servicePrice;
  int duration;

  BarberStoreService({
    required this.barberServiceId,
    required this.serviceName,
    required this.servicePrice,
    required this.duration
  });

  String formattedPrice() {
    return "${servicePrice/100} €";
  }
  String formattedDuration() {
    return "$duration min";
  }
}