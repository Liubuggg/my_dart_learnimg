
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
class _readAndParseJson {}
class _startRemoteIsolate {}
class _handleResponsesFromIsolate {}
void main(){
  //实施一个简单的工人隔离
  ///在新的隔离中运行现有方法
  //1\调用run()直接在主隔离中生成一个新的隔离（后台工作），而main()等待结果：
  const String filename = 'with_keys.json';
  void main1() async {
    final jsonData = await Isolate.run(_readAndParseJson as FutureOr Function());
    print('Number of JSON keys: ${jsonData.length}');
  }
  //2\传递worker隔离您希望它执行的函数作为其第一个参数。
  Future<Map<String, dynamic>> _readAndParseJson1() async {
    final fileData = await File(filename).readAsString();
    final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
    return jsonData;
  }
  //3\Isolate.run()获取结果_readAndParseJson()返回并将值发回主隔离，关闭工人隔离。
  //4\工人隔离将保存结果的内存转移到主隔离。它不会复制数据。工人隔离执行验证通行证，以确保允许转移对象。

  //发送带有隔离的闭包
  //可以直接在主隔离中使用函数文字或闭包使用run()创建简单的worker隔离。
  //现在隔离发送了一个关闭。闭包在如何运作和如何写入代码方面都比典型的命名函数小。
  //在本例中，Isolate.run()同时执行看起来像本地代码的东西。从这个意义上说，run()像“并行运行”的控制流运算符一样工作。
  const String filename1 = 'with_keys.json';
  void main() async {
    final jsonData = await Isolate.run(() async {
      final fileData = await File(filename1).readAsString();
      final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
      return jsonData;
    });
    print('Number of JSON keys: ${jsonData.length}');
  }

  //在带有端口的隔离区之间发送多条消息
  //短寿命隔离件使用方便，但需要性能开销来生成新的隔离件，并将对象从一个隔离件复制到另一个隔离件。
  //代码依赖于使用Isolate.run反复运行相同的计算，可能会通过创建不会立即退出的长寿命隔离来提高性能。
  //在隔离之间设置长时间通信需要两个类（除了Isolate）：ReceivePort和SendPort。这些端口是隔离相互通信的唯一方式。
  //ReceivePort是一个处理从其他隔离器发送的消息的对象。这些消息是通过SendPort发送的。

  //设置端口
  //新生成的隔离仅具有它通过Isolate.spawn调用接收的信息。如果需要主隔离在初始创建后继续与生成隔离进行通信，则必须设置一个通信通道，让生成的隔离可以向主隔离发送消息。隔离只能通过消息传递进行通信。
  //要设置此双向通信，首先在主隔离中创建一个ReceivePort，然后在使用Isolate.spawn生成新隔离时将其SendPort作为参数传递给新隔离。
  //然后，新的隔离器创建自己的ReceivePort，并将其SendPort发送回主隔离器传递的SendPort上。
  //主隔离接收此SendPort，现在双方都有一个发送和接收消息的开放通道。
  

}

