part of flutter_ble_server;


const NAMESPACE = "com.agroinvest.ble_peripheral";

class FlutterBleServer {
  final MethodChannel _channel = const MethodChannel('$NAMESPACE/methods');
  final EventChannel _stateChannel = const EventChannel('$NAMESPACE/state');
  final EventChannel _notifyChannel = const EventChannel('$NAMESPACE/notify');
  final EventChannel _advertiseChannel = const EventChannel('$NAMESPACE/advertise');

  final StreamController<MethodCall> _methodStreamController =
  new StreamController.broadcast(); // ignore: close_sinks
  Stream<MethodCall> get _methodStream => _methodStreamController
      .stream; // Used internally to dispatch methods from platform.

  /// Singleton boilerplate
  FlutterBleServer._() {
    _channel.setMethodCallHandler((MethodCall call) async {
      _methodStreamController.add(call);
    });
  }

  static FlutterBleServer _instance = new FlutterBleServer._();
  static FlutterBleServer get instance => _instance;

  Future<bool> startServer(BlePeripheralAdvertiser server) async {
    final bool? version = await _channel.invokeMethod('startServer', server.toJson());
    return true;
  }

  Future<bool> stopServer(BlePeripheralAdvertiser server) async {
    final bool? version = await _channel.invokeMethod('stopServer');
    return true;
  }

  Future<bool> readCharacteristic(BlePeripheralAdvertiser server) async {
    final bool? version = await _channel.invokeMethod('stopServer', server.toJson());
    return true;
  }


  Future<bool> writeCharacteristic(BlePeripheralAdvertiser server) async {
    final bool? version = await _channel.invokeMethod('stopServer', server.toJson());
    return true;
  }
}