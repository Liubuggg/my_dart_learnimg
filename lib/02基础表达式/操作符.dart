import 'package:flutter/material.dart';
class Person {}
void main(){
  var a1=1;
  int b1=2;
  var c;
  a1++;
  a1 + b1;
  a1 = b1;
  a1 == b1;
  c ? a1 : b1;
  a1 is Texture;

  var n=20;
  var i=2;
  var d=24;
  //同样方法执行
  if ((n % i == 0) && (d % i == 0)) ;
  if (n % i == 0 && d % i == 0) ;

  //算术运算符
  assert(2 + 3 == 5);
  assert(2 - 3 == -1);
  assert(2 * 3 == 6);
  assert(5 / 2 == 2.5); 
  assert(5 ~/ 2 == 2); 
  assert(5 % 2 == 1); 
  assert('5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1');

  int a;
  int b;
  a = 0;
  b = ++a; 
  assert(a == b); // 1 == 1
  a = 0;
  b = a++; 
  assert(a != b); // 1 != 0
  a = 0;
  b = --a; 
  assert(a == b); // -1 == -1
  a = 0;
  b = a--; 
  assert(a != b); // -1 != 0

  assert(2 == 2);
  assert(2 != 3);
  assert(3 > 2);
  assert(2 < 3);
  assert(3 >= 3);
  assert(2 <= 3);

  /*as	Typecast（也用于指定库前缀）
  is	如果对象具有指定类型，则为真
  is!	如果对象没有指定类型，则为真
  */
  // var employee;
  // (employee as Person).firstName = 'Bob';
  // if (employee is Person) {
  //   // Type check
  //   employee.firstName = 'Bob';
  // }

  //您可以使用=运算符来赋值。若要仅在被赋值变量为null时进行赋值，请使用？？=操作
  a = 1;
  b ??= 2;

  //复合运算符
  a = 2;
  a *= 3; 
  assert(a == 6);

  //!expr	反转以下表达式（将false更改为true，反之亦然）
  bool done=true;
  var col= 0;
  if (!done && (col == 0 || col == 3)) {

  }
  final value = 0x22;
  final bitmask = 0x0f;
  assert((value & bitmask) == 0x02); 
  assert((value & ~bitmask) == 0x20); 
  assert((value | bitmask) == 0x2f); 
  assert((value ^ bitmask) == 0x2d); 
  assert((value << 4) == 0x220);
  assert((value >> 4) == 0x02); 
  assert((-value >> 4) == -0x03);
  assert((value >>> 4) == 0x02); 
  assert((-value >>> 4) > 0); 

  // //condition ? expr1 : expr2  如果条件为真，则计算expr1（并返回其值）；否则，计算并返回expr2的值。根据布尔表达式分配值时
  // var visibility = isPublic ? 'public' : 'private';
  // //expr1 ?? expr2  如果expr1非空，则返回其值；否则，计算并返回expr2的值。布尔表达式测试为空值，请考虑使用??
  // String playerName(String? name) => name ?? 'Guest';
  // //其他写法
  // String playerName(String? name) => name != null ? name : 'Guest';
  // String playerName(String? name) {
  //   if (name != null) {
  //     return name;
  //   } else {
  //     return 'Guest';
  //   }
  // }

  // //级联（.., ?..）允许您对同一对象进行一系列操作。除了访问实例成员外，您还可以在同一对象上调用实例方法
  // var paint = Paint()
  //   ..color = Colors.black
  //   ..strokeCap = StrokeCap.round
  //   ..strokeWidth = 5.0;
  // //构造函数Paint()返回一个Paint对象。级联符号后面的代码在此对象上运行，忽略可能返回的任何值。
  // var paint = Paint();
  // paint.color = Colors.black;
  // paint.strokeCap = StrokeCap.round;
  // paint.strokeWidth = 5.0;
  // //如果级联操作的对象可以是空的，则在第一次操作时使用空短路级联（?..）。从?..保证不会对该空对象进行任何级联操作。
  // querySelector('#confirm') 
  //   ?..text = 'Confirm' 
  //   ..classes.add('important')
  //   ..onClick.listen((e) => window.alert('Confirmed!'))
  //   ..scrollIntoView();
  // //等同于
  // var button = querySelector('#confirm');
  // button?.text = 'Confirm';
  // button?.classes.add('important');
  // button?.onClick.listen((e) => window.alert('Confirmed!'));
  // button?.scrollIntoView();
  // //筑巢级联
  // final addressBook = (AddressBookBuilder()
  //       ..name = 'jenny'
  //       ..email = 'jenny@example.com'
  //       ..phone = (PhoneNumberBuilder()
  //             ..number = '415-555-0100'
  //             ..label = 'home')
  //           .build())
  //     .build();

  // //小心在返回实际对象的函数上构建级联，以下代码报错
  // var sb = StringBuffer();
  // sb.write('foo')
  //   ..write('bar'); // Error: method 'write' isn't defined for 'void'.



}