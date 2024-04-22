import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
//基本端口示例
//步骤1：定义工人类
//该类公开了两种公共方法：一种是生成工人隔离，一种是处理向该工人隔离发送消息的方法。
//第2步：生成工人隔离
//Worker.spawn方法将对创建worker隔离的代码进行分组，并确保它可以接收和发送消息。
//第3步：在工人隔离上执行代码
//在此步骤中，您定义了发送到工人隔离的方法_startRemoteIsolate，以便在生成时执行。这种方法就像工人隔离的“主要”方法。
//第4步：处理主隔离上的消息
//最后，您需要告诉主隔离如何处理从工人隔离发回主隔离的消息。
//第5步：添加一个完成器，以确保您的隔离设置完成
//要完成该类，请定义一个名为parseJson的公共方法，该方法负责向worker隔离发送消息。

void main() async {
  final worker = Worker();
  await worker.spawn();
  await worker.parseJson('{"key":"value"}');
}

class Worker {
  late SendPort _sendPort;
  final Completer<void> _isolateReady = Completer.sync();

  Future<void> spawn() async {
    final receivePort = ReceivePort();
    receivePort.listen(_handleResponsesFromIsolate);
    await Isolate.spawn(_startRemoteIsolate, receivePort.sendPort);
  }

  void _handleResponsesFromIsolate(dynamic message) {
    if (message is SendPort) {
      _sendPort = message;
      _isolateReady.complete();
    } else if (message is Map<String, dynamic>) {
      print(message);
    }
  }

  static void _startRemoteIsolate(SendPort port) {
    final receivePort = ReceivePort();
    port.send(receivePort.sendPort);

    receivePort.listen((dynamic message) async {
      if (message is String) {
        final transformed = jsonDecode(message);
        port.send(transformed);
      }
    });
  }

  Future<void> parseJson(String message) async {
    await _isolateReady.future;
    _sendPort.send(message);
  }
}
