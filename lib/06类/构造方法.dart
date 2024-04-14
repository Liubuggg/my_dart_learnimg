//使用最常见的构造函数，生成构造函数，来创建类的新实例，并在必要时初始化形式参数以实例化任何实例变量：
class Point {
  double x = 0;
  double y = 0;
  // Generative constructor with initializing formal parameters:
  Point(this.x, this.y);
}

//初始化正式参数
//Dart初始化了形式参数，以简化将构造函数参数分配给实例变量的常见模式。直接在构造函数声明中使用this.propertyName，并省略正文。
//初始化参数还允许您初始化不可空变量或final实例变量，这两个变量都必须初始化或提供默认值：
class Point1 {
  final double x;
  final double y;
  // Sets the x and y instance variables
  // before the constructor body runs.
  Point1(this.x, this.y);
}


//默认构造函数
//如果不声明构造函数，则会为提供默认构造函数。默认构造函数没有参数，并调用超类中的无参数构造函数。


//构造函数不是继承的
//子类不会从其超类继承构造函数。声明没有构造函数的子类只有默认（无参数，无名称）构造函数。


//命名的构造函数
//使用命名构造函数为类实现多个构造函数或提供额外的清晰度
//构造函数不是继承的，这意味着超类的命名构造函数不是由子类继承的。如果您希望使用超类中定义的命名构造函数创建子类，则必须在子类中实现该构造函数。
const double xOrigin = 0;
const double yOrigin = 0;

class Point3 {
  final double x;
  final double y;

  // Sets the x and y instance variables
  // before the constructor body runs.
  Point3(this.x, this.y);

  // Named constructor
  Point3.origin()
      : x = xOrigin,
        y = yOrigin;
}


//调用非默认超类构造函数
/*
默认情况下，子类中的构造函数调用超类的无命名、无参数构造函数。超类的构造函数在构造函数体的开头被调用。如果初始化器列表也在使用，它会在调用超类之前执行。总之，执行顺序如下：
初始化器列表
超类的no-arg构造函数
主类的no-arg构造函数
如果超类没有未命名的、无参数的构造函数，那么您必须手动调用超类中的一个构造函数。在冒号（:）之后指定超类构造函数，就在构造函数主体（如果有的话）之前。
 */
class Person {
  String? firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson().
  Employee.fromJson(super.data) : super.fromJson() {
    print('in Employee');
  }
}


int main(){
  var employee = Employee.fromJson({});
  print(employee);

  return 0;
}