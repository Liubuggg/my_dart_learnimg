// void main(){
//   var message = StringBuffer('Dart is fun');
//   for (var i = 0; i < 5; i++) {
//     message.write('!');
//   }

//   //Dart的for循环内部的闭包捕获索引的值
//   var callbacks = [];
//   for (var i = 0; i < 2; i++) {
//     callbacks.add(() => print(i));
//   }
//   for (final c in callbacks) {
//     c();
//   }//输出是0，然后是1。相比之下，该示例将在JavaScript中打印2，然后打印2。
//   //在迭代Iterable类型,可能不需要知道当前迭代计数器。在这种情况下，请使用for-in循环
//   for (final candidate in candidates) {
//     candidate.interview();
//   }
//   //要处理从可重用性获得的值，您也可以在for-in循环中使用apattern
//   for (final Candidate(:name, :yearsExperience) in candidates) {
//     print('$name has $yearsExperience of experience.');
//   }
//   //可以iterable类还有一个forEach()方法作为另一个选项
//   var collection = [1, 2, 3];
//   collection.forEach(print); // 1 2 3

//   while (!isDone()) {
//     doSomething();
//   }
//   do {
//     printLine();
//   } while (!atEndOfPage());
//   while (true) {
//     if (shutDownRequested()) break;
//     processIncomingRequests();
//   }
//   for (int i = 0; i < candidates.length; i++) {
//     var candidate = candidates[i];
//     if (candidate.yearsExperience < 5) {
//       continue;
//     }
//     candidate.interview();
//   }
  
//   //使用的是Iterable的，例如列表或集合，那么您编写上一个示例的方式可能会有所不同：
//   candidates.where((c) => c.yearsExperience >= 5).forEach((c) => c.interview());
// }