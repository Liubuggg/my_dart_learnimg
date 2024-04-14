import 'dart:html';
import 'dart:math';

class Point {
  double? x;
  double? y;
  double z = 0;

  // 初始化非late实例变量，在创建实例时，在构造函数及其初始化器列表执行之前，将其声明为值。因此，非late实例变量的初始化表达式（在=之后）无法访问this。
  double initialX = 1.5;
}

class Point1 {
  // OK, can access declarations that do not depend on `this`:
  double? x = initialX;

  // ERROR, can't access `this` in non-`late` initializer:
  //double? y = this.x;

  // OK, can access `this` in `late` initializer:
  late double? z = this.x;

  // OK, `this.fieldName` is a parameter declaration, not an expression:
  Point1(this.x, this.z);
  
  static double? get initialX => null;
  
  get y => null;
  
  static fromJson(Map<String, int> map) {}
}

// 实例变量可以是final的，在这种情况下，它们必须精确设置一次。在声明时初始化final的非late实例变量，使用构造函数参数或使用构造函数的初始化器列表：
class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}

// 隐式接口
// 每个类都隐式定义了一个接口，其中包含该类及其实现的任何接口的所有实例成员。如果您想创建一个支持B类API的类A而不继承B的实现，类A应该实现B接口。
// 类通过在implements句中声明它们，然后提供接口所需的API来实现一个或多个接口。
// A person. The implicit interface contains greet().
class Person {
  // In the interface, but visible only in this library.
  final String _name;
  // Not in the interface, since this is a constructor.
  Person(this._name);
  // In the interface.
  String greet(String who) => 'Hello, $who. I am $_name.';
}

// An implementation of the Person interface.
class Impostor implements Person {
  String get _name => '';
  String greet(String who) => 'Hi $who. Do you know who I am?';
}

String greetBob(Person person) => person.greet('Bob');

// 指定一个类实现多个接口的示例：
//  class Point4 implements Comparable, Location {
//   // ...
// }

// 类变量和方法
// 静态变量（类变量）对类范围的状态和常量很有用：
class Queue {
  static const initialCapacity = 16;
  // ...
}

// 静态方法
// 静态方法（类方法）不在实例上操作，因此无法访问this。然而，他们确实可以访问静态变量，直接在类上调用静态方法：
class Point3 {
  double x, y;
  Point3(this.x, this.y);

  static double distanceBetween(Point3 a, Point3 b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}


class ImmutablePoint {
  final double x;
  final double y;
  const ImmutablePoint(this.x, this.y);
}

void main() {
  // 使用点（.）来引用实例变量或方法：
  var p = Point1(2, 2);
  // 获取y的值
  assert(p.y == 2);
  //double distance = p.distanceTo(Point(4, 4));
  // 当最左边的操作数为空时，使用？.而不是.来避免异常：
  var a = p?.y;

  // 使用构造函数
  // 使用构造函数创建对象。构造函数名称可以是ClassName或ClassName.identifier。
  var p1 = Point1(2, 2);
  var p2 = Point1.fromJson({'x': 1, 'y': 2});
  // //以下代码具有相同的效果，但在构造函数名称之前使用可选new关键字：
  // var p1 = new Point(2, 2);
  // var p2 = new Point.fromJson({'x': 1, 'y': 2});

  // 一些类提供常量构造函数。要使用常量构造函数创建编译时常量，请将const关键字放在构造函数名称之前：
  var p3 = const ImmutablePoint(2, 2);
  // 构造两个相同的编译时常量会产生一个单一的规范实例：
  var a1 = const ImmutablePoint(1, 1);
  var b1 = const ImmutablePoint(1, 1);
  assert(identical(a1, b1)); // They are the same instance!

  // 在常量上下文中，可以在构造函数或文字之前省略const。
  // Lots of const keywords here.
  const pointAndLine = const {
    'point': const [const ImmutablePoint(0, 0)],
    'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
  };
  // 除了第一次使用const关键字外，可以省略所有内容：
  // Only one const, which establishes the constant context.
  const pointAndLine2 = {
    'point': [ImmutablePoint(0, 0)],
    'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
  };
  // 如果常量构造函数在常量上下文之外，并且在没有const的情况下被调用，它会创建一个非常量对象：
  var a2 = const ImmutablePoint(1, 1); // Creates a constant
  var b2 = ImmutablePoint(1, 1); // Does NOT create a constant
  assert(!identical(a2, b2)); // NOT the same instance!

  // 获取对象的类型
  // 要在运行时获取对象的类型，可以使用Object属性runtimeType，该属性返回Type对象。
  print('The type of a is ${a.runtimeType}');

  var a4 = Point3(2, 2);
  var b4 = Point3(4, 4);
  //var distance4 = Point3.distanceBetween(a, b);
  //assert(2.8 < distance && distance < 2.9);
  //print(distance);
}
