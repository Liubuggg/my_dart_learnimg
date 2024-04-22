import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
//通过创建一个具有这些附加功能等的长寿工人隔离，并遵循更好的设计模式。
//步骤1：定义工人类
//三种公共方法：一种是创建工作隔离，一种是处理向该工作隔离发送消息的方法，一种是在端口不再使用时可以关闭端口。
//步骤2：在Worker.spawn方法中创建RawReceivePort
//在生成隔离之前，需要创建一个RawReceivePort，这是一个较低级别的ReceivePort。
//使用RawReceivePort是首选模式，因为它允许您将隔离启动逻辑与处理隔离上传递消息的逻辑分开。
//通过先创建RawReceivePort，然后创建RecevePort，您将能够稍后向ReceivePort.listen添加新的回调。
//步骤3:创建工人隔离Isolate.spawn
//此步骤继续填充Worker.spawn方法。您将添加生成隔离所需的代码，并从该类返回Worker实例。
//步骤4：完成隔离设置过程
//在此步骤中，您将完成基本的隔离设置过程。这几乎完全与隔离事例相关，没有新概念。
//步骤5：同时处理多条消息
//在此步骤中，您将通过给每条消息一个id来解决这个问题，并使用Completer对象来确保当外部代码调用parseJson时，返回给该调用者的响应是正确的响应。
//更新parseJson方法，在向工作隔离发送消息之前创建完成器。
//还需要更新_handleResponsesFromIsolate和_handleCommandsToIsolate来处理此系统。
//步骤6:添加关闭端口的功能
//当您的代码不再使用隔离时，您应该关闭主隔离和工作隔离上的端口。

void main() async {
  final worker = await Worker.spawn();
  print(await worker.parseJson('{"key":"value"}'));
  print(await worker.parseJson('"banana"'));
  print(await worker.parseJson('[true, false, null, 1, "string"]'));
  print(
      await Future.wait([worker.parseJson('"yes"'), worker.parseJson('"no"')]));
  worker.close();
}

class Worker {
  final SendPort _commands;
  final ReceivePort _responses;
  final Map<int, Completer<Object?>> _activeRequests = {};
  int _idCounter = 0;
  bool _closed = false;

  Future<Object?> parseJson(String message) async {
    if (_closed) throw StateError('Closed');
    final completer = Completer<Object?>.sync();
    final id = _idCounter++;
    _activeRequests[id] = completer;
    _commands.send((id, message));
    return await completer.future;
  }

  static Future<Worker> spawn() async {
    // Create a receive port and add its initial message handler
    final initPort = RawReceivePort();
    final connection = Completer<(ReceivePort, SendPort)>.sync();
    initPort.handler = (initialMessage) {
      final commandPort = initialMessage as SendPort;
      connection.complete((
        ReceivePort.fromRawReceivePort(initPort),
        commandPort,
      ));
    };

    // Spawn the isolate.
    try {
      await Isolate.spawn(_startRemoteIsolate, (initPort.sendPort));
    } on Object {
      initPort.close();
      rethrow;
    }

    final (ReceivePort receivePort, SendPort sendPort) =
        await connection.future;

    return Worker._(receivePort, sendPort);
  }

  Worker._(this._responses, this._commands) {
    _responses.listen(_handleResponsesFromIsolate);
  }

  void _handleResponsesFromIsolate(dynamic message) {
    final (int id, Object? response) = message as (int, Object?);
    final completer = _activeRequests.remove(id)!;

    if (response is RemoteError) {
      completer.completeError(response);
    } else {
      completer.complete(response);
    }

    if (_closed && _activeRequests.isEmpty) _responses.close();
  }

  static void _handleCommandsToIsolate(
    ReceivePort receivePort,
    SendPort sendPort,
  ) {
    receivePort.listen((message) {
      if (message == 'shutdown') {
        receivePort.close();
        return;
      }
      final (int id, String jsonText) = message as (int, String);
      try {
        final jsonData = jsonDecode(jsonText);
        sendPort.send((id, jsonData));
      } catch (e) {
        sendPort.send((id, RemoteError(e.toString(), '')));
      }
    });
  }

  static void _startRemoteIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    _handleCommandsToIsolate(receivePort, sendPort);
  }

  void close() {
    if (!_closed) {
      _closed = true;
      _commands.send('shutdown');
      if (_activeRequests.isEmpty) _responses.close();
      print('--- port closed --- ');
    }
  }
}
