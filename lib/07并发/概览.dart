import 'dart:io';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
void main0() {
  //事件循环
  //Dart的运行时模型基于事件循环。事件循环负责执行程序的代码、收集和处理事件等。
  //应用程序运行时，所有事件都会添加到队列中，称为事件队列。事件可以是任何东西，从重新绘制UI的请求，到用户点击和按键，再到磁盘的I/O。
  var eventQueue;
  while (eventQueue.waitForEvent()) {
    eventQueue.processNextEvent();
  }
//当此代码到达事件循环时，它会立即调用第一个子句http.get，并返回一个Future。它还告诉事件循环保留then()子句中的回调，直到HTTP请求解决。
  // http.get('https://example.com').then((response) {
  //   if (response.statusCode == 200) {
  //     print('Success!')'
  //   }
  // }

  //异步编程
  ///期货
  //Future表示异步操作的结果，该异步操作最终将以值或错误完成。
  //Future<String>的返回类型表示最终提供String值（或错误）的承诺。
  Future<String> _readFileAsync(String filename) {
    final file = File(filename);
    // .readAsString() returns a Future.
    // .then() registers a callback to be executed when `readAsString` resolves.
    return file.readAsString().then((contents) {
      return contents.trim();
    });
  }
  ///异步等待语法
  //async和await关键字提供了一种声明性方式来定义异步函数并使用其结果。
  //一些在等待文件I/O时阻止的同步代码
  const String filename = 'with_keys.json';
  String _readFileSync() {
    final file = File(filename);
    final contents = file.readAsStringSync();
    return contents.trim();
  }
  void main1() {
    final fileData = _readFileSync();
    final jsonData = jsonDecode(fileData);
    print('Number of JSON keys: ${jsonData.length}');
  }
  //类似的代码，但有更改（突出显示）使其异步
  const String filename1 = 'with_keys.json';
  Future<String> _readFileAsync1() async {
    final file = File(filename);
    final contents = await file.readAsString();
    return contents.trim();
  }
  void main2() async {
    final fileData = await _readFileAsync1();
    final jsonData = jsonDecode(fileData);
    print('Number of JSON keys: ${jsonData.length}');
  }
  ///溪流
  //Dart还支持流形式的异步代码。流在未来提供价值，并随着时间的推移反复提供价值。随着时间的推移提供一系列int值的承诺具有Stream<int>类型。
  //使用Stream.periodic创建的流每秒重复发出一个新的int值。
  Stream<int> stream =
      Stream.periodic(const Duration(seconds: 1), (i) => i * i);
  ///等待和屈服
  //Await-for是一种for循环，在提供新值时执行循环的每次后续迭代。用于“循环”流
  //从函数sumStream发出新值，因为新值将从作为参数提供的流中发出。在返回值流的函数中使用yield关键字，而不是return。
  Stream<int> sumStream(Stream<int> stream) async* {
    var sum = 0;
    await for (final value in stream) {
      yield sum += value;
    }
  }


  //隔离
  //所有Dart代码都在隔离内运行，而不是线程。使用隔离，您的Dart代码可以同时执行多个独立任务。
  //每个隔离区都有自己的全局字段，确保隔离区中的任何状态都无法从任何其他隔离区访问。隔离只能通过消息传递相互通信。
  ///主要的隔离
  //在继续下一行代码之前，这些应用程序使用async-await等待异步操作完成。一个行为良好的应用程序快速启动，尽快进入事件循环。然后，该应用程序会及时响应每个排队事件，必要时使用异步操作。
  ///隔离生命周期
  //每个隔离都从运行一些Dart代码开始，例如main()函数。此Dart代码可能会注册一些事件侦听器——例如，响应用户输入或文件I/O。当隔离的初始函数返回时，如果需要处理事件，隔离将保留在周围。处理完事件后，隔离站退出。
  ///事件处理
  //主隔离的事件队列可能包含重新绘制请求以及点击和其他UI事件的通知。事件循环从队列中按先进先出的顺序获取事件
  //事件处理发生在main()退出后的主隔离上。如果同步操作需要太多的处理时间，该应用程序可能会变得无响应。
  ///背景工作者
  //如果您的应用程序的用户界面由于耗时的计算而变得无响应，请考虑将该计算卸载到工人隔离，通常称为后台工人。
  //隔离工人可以执行I/O（例如，读取和写入文件），设置计时器等。它有自己的内存，与主隔离不共享任何状态。工人隔离可以阻止而不影响其他隔离。
  //Isolate.run()
  int slowFib(int n) => n <= 1 ? 1 : slowFib(n - 1) + slowFib(n - 2);
  void fib40() async {
    var result = await Isolate.run(() => slowFib(40));
    print('Fib(40) = $result');
  }
  ///表现和隔离群体
  //当隔离调用Isolate.spawn()两个隔离具有相同的可执行代码，并且位于同一隔离组中。隔离组启用了共享代码等性能优化；一个新的隔离会立即运行隔离组拥有的代码。此外，仅当隔离位于同一隔离组时，Isolate.exit()才有效。
  ///隔离物的局限
  //每个隔离点都有自己的状态，确保隔离点中的任何状态都无法从任何其他隔离点访问。因此，隔离物受到他们访问自己记忆的限制。
  ///网络上的并发
  //所有Dart应用程序都可以使用async-await、Future和Stream进行非阻塞、交错计算。然而，Dart网络平台不支持隔离。
  //Dart Web应用程序可以使用Web工作者在类似于隔离的后台线程中运行脚本。
  


}
