
lookUpVersion11() {}
flushThenExit(exitCode) {}
runExecutable(entrypoint, args) {}
findEntryPoint() {}
void handleRequest(request) {}
class varOrType {}
Future<void> main() async {
  //处理期货
  //使用async和await的代码是异步的，但它看起来很像同步代码。
  await lookUpVersion11();
  //要使用await，代码必须处于async函数中——标记为async函数
  Future<void> checkVersion() async {
    var version = await lookUpVersion11();
    // Do something with version
  }
  //使用try、catch和finally来处理usesawait代码中的错误和清理：
  try {
    var version = await lookUpVersion11();
  } catch (e) {
  }
  //可以在异步函数中多次使用await
  var entrypoint = await findEntryPoint();
  var args;
  var exitCode = await runExecutable(entrypoint, args);
  await flushThenExit(exitCode);
  void main1() async {
    checkVersion();
    print('In main: version is ${await lookUpVersion11()}');
  }


  //声明异步函数
  //函数的主体不需要使用Future API
  //异步函数是一个函数，其主体标有async修饰符。将async关键字添加到函数中会使其返回Future。
  String lookUpVersion() => '1.0.0';
  //将其更改为async函数
  Future<String> lookUpVersion1() async => '1.0.0';


  //处理流
  //异步for循环
  //expression式的值必须具有Stream类型。执行过程如下：1、等到流发出一个值。2、执行for循环的主体，并将变量设置为该发射值。重复1和2，直到流关闭。
  var expression;
  await for (varOrType identifier in expression) {}
  //如果在实现异步for循环时遇到编译时错误，请确保await for在async函数中。
  void main2() async {
    // ...
    var requestServer;
    await for (final request in requestServer) {
      handleRequest(request);
    }
    // ...
  }
}