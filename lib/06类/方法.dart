//实例方法
//对象上的实例方法可以访问实例变量和this。
import 'dart:math';

class Point {
  final double x;
  final double y;
  // Sets the x and y instance variables
  // before the constructor body runs.
  Point(this.x, this.y);
  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}

//运算符声明是使用内置标识符operator来识别的。以下示例定义了向量加法（+）、减法（-）和相等（==）：
class Vector {
  final int x, y;
  Vector(this.x, this.y);
  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);
  @override
  bool operator ==(Object other) =>
      other is Vector && x == other.x && y == other.y;
  @override
  int get hashCode => Object.hash(x, y);
}


//getter setter
class Rectangle {
  double left, top, width, height;
  Rectangle(this.left, this.top, this.width, this.height);
  // Define two calculated properties: right and bottom.
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}


//抽象方法
//Instance、getter和setter方法可以是抽象的，定义一个接口，但将其实现留给其他类。抽象方法只能存在于抽象类或混合中。
abstract class Doer {
  // Define instance variables and methods...
  void doSomething(); // Define an abstract method.
}
class EffectiveDoer extends Doer {
  void doSomething() {
    // Provide an implementation, so the method is not abstract here...
  }
}

void main() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);
  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));


  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);

}
