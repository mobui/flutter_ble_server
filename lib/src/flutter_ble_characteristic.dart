part of flutter_ble_server;

class BlePeripheralCharacteristic {
  late final Map<String, dynamic> _data;

  BlePeripheralCharacteristic(UuidValue uuid, bool read, bool write,
      bool notify, List<int> value, String description) {
    _data = {
      'uiid': uuid.toString(),
      'read': read,
      'write': write,
      'notify': notify,
      'value': value
    };
  }

  static _BlePeripheralCharacteristicBuilder builder() {
    return _BlePeripheralCharacteristicBuilder();
  }

  String get uuid => _data['uuid'];

  bool get read => _data['read'];

  bool get write => _data['write'];

  bool get notify => _data['notify'];

  Uint8List get value => _data['value'];

  Map<String, dynamic> get data => _data;
}

class _BlePeripheralCharacteristicBuilder {
  UuidValue _uuid = Uuid().v4obj();
  bool _read = false;
  bool _write = false;
  bool _notify = false;
  String _description = '';
  List<int> _value = [];

  _BlePeripheralCharacteristicBuilder uuid(UuidValue uuid) {
    _uuid = uuid;
    return this;
  }

  _BlePeripheralCharacteristicBuilder readable() {
    _read = true;
    return this;
  }

  _BlePeripheralCharacteristicBuilder writable() {
    _write = true;
    return this;
  }

  _BlePeripheralCharacteristicBuilder description(String description) {
    _description = description;
    return this;
  }

  _BlePeripheralCharacteristicBuilder notifiable() {
    _notify = true;
    return this;
  }

  _BlePeripheralCharacteristicBuilder initValue(List<int> value) {
    _value = value;
    return this;
  }

  BlePeripheralCharacteristic build() {
    return BlePeripheralCharacteristic(
        _uuid, _read, _write, _notify, _value, _description);
  }
}
