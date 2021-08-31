
part of flutter_ble_server;

class BlePeripheralService {
  late final Map<String, dynamic> _data;

  BlePeripheralService(
      UuidValue _uiid, List<BlePeripheralCharacteristic> _characteristics) {
    _data = {
      "uuid": _uiid.toString(),
      "characteristics": _characteristics.map((e) => e.data).toList(),
    };
  }
  static _BlePeripheralServiceBuilder builder() {
    return _BlePeripheralServiceBuilder();
  }

  String get uuid => _data["uuid"];

  List<BlePeripheralCharacteristic> get characteristics =>
      _data["characteristics"];

  Map<String, dynamic> get data => _data;
}

class _BlePeripheralServiceBuilder {
  UuidValue _uuid = Uuid().v4obj();
  List<BlePeripheralCharacteristic> _characteristics = [];

  _BlePeripheralServiceBuilder uuid(UuidValue uuid) {
    _uuid = uuid;
    return this;
  }

  _BlePeripheralServiceBuilder addCharacteristics(
      BlePeripheralCharacteristic characteristics) {
    _characteristics.add(characteristics);
    return this;
  }

  BlePeripheralService build() {
    return BlePeripheralService(_uuid, _characteristics);
  }
}
