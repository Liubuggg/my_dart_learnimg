// //Dart是一种真正的面向对象语言，因此即使是函数也是对象，并且具有类型，Function。

// bool isNoble(int atomicNumber) {
//   return _nobleGases[atomicNumber] != null;
// }
// //如果您省略了类型，该函数仍然有效：
// isNoble1 (atomicNumber) {
//   return _nobleGases[atomicNumber] != null;
// }
// //只有表达式（而不是语句）可以出现在箭头（=>）和分号（;）之间
// bool isNoble2(int atomicNumber) => _nobleGases[atomicNumber] != null;

// //定义函数时，使用{param1, param2, …}指定命名参数。
// //如果不提供默认值或按required标记命名参数，则其类型必须为空，因为它们的默认值将为null：
// void enableFlags({bool? bold, bool? hidden}) {}
// //要为null参数定义默认值，请使用=指定默认值。指定的值必须是编译时常量。
// void enableFlags1({bool bold = false, bool hidden = false}) {}
// // bold true; hidden false.
// enableFlags2(bold:true);
// //如果命名参数是强制性的，要求调用者为参数提供值，请用required的注释他们：
// const Scrollbar({super.key, required Widget child});

// //包装一组函数参数在[]将它们标记为可选的位置参数。
// //如果您不提供默认值，则它们的类型必须为空，因为它们的默认值将为null：
// String say(String from, String msg, [String? device]) {
//   var result = '$from says $msg';
//   if (device != null) {
//     result = '$result with a $device';
//   }
//   return result;
// }
//   //在没有可选参数的情况下调用此函数的示例：
//   assert(say('Bob', 'Howdy') == 'Bob says Howdy');
//   //使用第三个参数调用此函数的示例：
//   assert(say('Bob', 'Howdy', 'smoke signal') ==
//     'Bob says Howdy with a smoke signal');

// //要为null以外的可选位置参数定义默认值，请使用=指定默认值。指定的值必须是编译时常量。
// String say(String from, String msg, [String device = 'carrier pigeon']) {
//   var result = '$from says $msg with a $device';
//   return result;
// }
// //调用say
//   assert(say('Bob', 'Howdy') == 'Bob says Howdy with a carrier pigeon');


// //可以将一个函数作为参数传递给另一个函数
// void printElement(int element) {
//   print(element);
// }
// var list = [1, 2, 3];
// list.forEach(printElement);
// //为变量分配一个函数
// var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
// assert(loudify('hello') == '!!! HELLO !!!');
// //如果函数仅包含单个表达式或返回语句，您可以使用箭头表示法缩短它。
// list
//     .map((item) => item.toUpperCase())
//     .forEach((item) => print('$item: ${item.length}'));


// //创建一个名为匿名函数的无名函数，或者有时是lambda或闭包。您可以将匿名函数分配给变量
// //示例定义了一个带有未类型参数、item的匿名函数，并将其传递给map函数。
// const list = ['apples', 'bananas', 'oranges'];
// list.map((item) {
//   return item.toUpperCase();
// }).forEach((item) {
//   print('$item: ${item.length}');
// });



// //每个应用程序都必须有一个顶级的main()函数，作为应用程序的入口点。
// //main()函数返回void并有一个可选的List<String>参数用于参数。
// void main(){
//   //Dart允许在适合您的API时将命名参数放置在参数列表的任何地方：
//   repeat(times: 2, () {
//   });
  
// }

// //以下是接受参数的命令行应用程序的main()函数示例：
// void main(List<String> arguments) {
//   print(arguments);

//   assert(arguments.length == 2);
//   assert(int.parse(arguments[0]) == 1);
//   assert(arguments[1] == 'test');
// }

// //Dart是一种词法作用域语言，这意味着变量的作用域是静态决定的，只需由代码的布局决定。
// //您可以“向外跟随大括号”，看看变量是否在范围内。
// bool topLevel = true;
// void main() {
//   var insideMain = true;
//   void myFunction() {
//     var insideFunction = true;

//     void nestedFunction() {
//       var insideNestedFunction = true;

//       assert(topLevel);
//       assert(insideMain);
//       assert(insideFunction);
//       assert(insideNestedFunction);
//     }
//   }
// }

// //闭包是一个函数对象，可以访问其词法作用域中的变量，即使该函数在其原始作用域之外使用。
// Function makeAdder(int addBy) {
//   return (int i) => addBy + i;
// }
// void main() {
//   var add2 = makeAdder(2);
//   var add4 = makeAdder(4);
//   assert(add2(3) == 5);
//   assert(add4(3) == 7);
// }

// //测试顶级函数、静态方法和实例方法相等的示例：
// void foo() {} 
// class A {
//   static void bar() {} 
//   void baz() {} 
// }
// void main() {
//   Function x;
//   x = foo;
//   assert(foo == x);
//   x = A.bar;
//   assert(A.bar == x);
//   var v = A(); 
//   var w = A(); 
//   var y = w;
//   x = w.baz;
//   assert(y.baz == x);
//   assert(v.baz != w.baz);
// }

// //所有函数都返回一个值。如果没有指定返回值，语句return null;隐式附加到函数主体。
// foo() {}
// assert(foo() == null);
// //要返回函数中的多个值，请聚合记录中的值。
// (String, int) foo() {
//   return ('something', 42);
// }

// //要实现同步生成器函数，请将函数体标记为sync*，并使用yield语句传递值：
// Iterable<int> naturalsTo(int n) sync* {
//   int k = 0;
//   while (k < n) yield k++;
// }
// //要实现异步生成器函数，请将函数体标记为async*，并使用yield语句传递值：
// Stream<int> asynchronousNaturalsTo(int n) async* {
//   int k = 0;
//   while (k < n) yield k++;
// }
// //生成器是递归的，您可以通过使用yield*来提高其性能：
// Iterable<int> naturalsDownFrom(int n) sync* {
//   if (n > 0) {
//     yield n;
//     yield* naturalsDownFrom(n - 1);
//   }
// }

// //外部函数是其主体与其声明分开实现的函数。在函数声明之前包含external关键字
// external void someFunc(int i);