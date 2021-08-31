part of flutter_ble_server;

class BlePeripheralAdvertiser {
  late final Map<String, dynamic> _data;

  BlePeripheralAdvertiser(List<BlePeripheralService> services) {
    _data = {
      "services": services.map((e) => e.data).toList(),
    };
  }

  static _BlePeripheralAdvertiserBuilder builder() {
    return _BlePeripheralAdvertiserBuilder();
  }

  List<BlePeripheralService> get services => _data["services"];

  Map<String, dynamic> get data => _data;

  String toJson() => jsonEncode(_data);

  @override
  String toString() {
    return _prettyJson(_data);
  }

  String _prettyJson(dynamic json) {
    var spaces = ' ' * 4;
    var encoder = JsonEncoder.withIndent(spaces);
    return encoder.convert(json);
  }
}

class _BlePeripheralAdvertiserBuilder {
  List<BlePeripheralService> _services = [];

  _BlePeripheralAdvertiserBuilder addService(BlePeripheralService service) {
    _services.add(service);
    return this;
  }

  BlePeripheralAdvertiser build() {
    return BlePeripheralAdvertiser(_services);
  }
}
