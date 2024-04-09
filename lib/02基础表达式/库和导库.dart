// import 'dart:html';
// //import的唯一必要参数是指定库的URI。
// //可以使用文件系统路径或软件包package:方案
// //import 'package:test/test.dart';

// //如果您导入两个具有冲突标识符的库，那么您可以为一个或两个库指定前缀
// import 'package:lib1/lib1.dart';
// import 'package:lib2/lib2.dart' as lib2;
// //使用lib1
// Element element1 = Element();
// //使用lib2
// lib2.Element element2 = lib2.Element();

// //只想使用库的一部分，您可以有选择地导入库
// import 'package:lib1/lib1.dart' show foo;
// import 'package:lib2/lib2.dart' hide foo;

// //延迟加载（也称为延迟加载）允许Web应用程序在需要库时按需加载库。
// import 'package:greetings/hello.dart' deferred as hello;
// //当要库时，使用库的标识符调用loadLibrary()。
// Future<void> greet() async {
//   await hello.loadLibrary();
//   hello.printGreeting();
// }
// //library指令，要指定库级文档注释或元数据注释，请在文件开头将它们附加到library声明中。
// @TestOn('browser')
// library;
