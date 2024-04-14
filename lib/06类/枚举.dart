/* 
所有枚举都会自动扩展Enum类。它们也是密封的，这意味着它们不能被子类、实现、混合或以其他方式明确地实例化。
抽象类和混入可以显式实现或扩展Enum，但除非它们随后被枚举实现或混合到枚举声明中，否则任何对象都无法实际实现该类或混入的类型。
*/

//声明一个简单的枚举类型，请使用enum关键字并列出想要枚举的值
enum Color { red, green, blue }

//声明增强的枚举
/*
Dart还允许枚举声明声明带有字段、方法和const构造函数的类，这些类仅限于固定数量的已知常量实例。
要声明增强的枚举，请遵循类似于普通类的语法，但有一些额外的要求：

实例变量必须是final，包括混合添加的变量。
所有生成构造函数必须是恒定的。
工厂构造函数只能返回一个固定的已知枚举实例。
没有其他类可以扩展，因为Enum会自动扩展。
不能覆盖index、hashCode、相等运算符==。
成员命名values不能在枚举中声明，因为它会与自动生成的静态valuesgetter冲突。
枚举的所有实例必须在声明的开头声明，并且必须至少声明一个实例。

增强枚举中的实例方法可以this引用当前枚举值。
 */
enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}

//使用枚举
int main(){
  final favoriteColor = Color.blue;
  if (favoriteColor == Color.blue) {
    print('Your favorite color is blue!');
  }
  //枚举中的每个值都有一个index获取器，它返回枚举声明中值的零基位置。
  assert(Color.red.index == 0);
  assert(Color.green.index == 1);
  assert(Color.blue.index == 2);
  //要获取所有枚举值的列表，请使用枚举的values常数。
  List<Color> colors = Color.values;
  assert(colors[2] == Color.blue);
  //可以在switch语句中使用枚举
  var aColor = Color.blue;
  switch (aColor) {
    case Color.red:
      print('Red as roses!');
    case Color.green:
      print('Green as grass!');
    default: // Without this, you see a WARNING.
      print(aColor); // 'Color.blue'
  }

  //访问枚举值的名称
  print(Color.blue.name);
  //像访问普通对象一样访问枚举值的成员
  print(Vehicle.car.carbonFootprint);


  return 0;
}