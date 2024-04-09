import 'dart:io';
import 'package:flutter_application_1/01%E7%AE%80%E4%BB%8B/%E7%B1%BB.dart';
//异步
//使用 async 和 await 关键字可以让你避免回调地狱 (Callback Hell) 并使你的代码更具可读性。

const oneSecond = Duration(seconds: 1);
Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}
//相当于以下
/*
Future<void> printWithDelay(String message){
  return Future.delayed(oneSecond).then((_){
    print(message);
  });
}
*/

// /async 和 await 关键字有助于使异步代码变得易于阅读。
Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print('File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}

//可以使用 async* 关键字，其可以提供一个可读性更好的方式去生成 Stream。
Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (final object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} flies by $object';
  }
}
