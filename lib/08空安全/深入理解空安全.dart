//代码在默认情况下是安全的。 如果你写的新代码中没有显式使用不安全的特性，运行时将不会有空引用错误抛出。
//空安全的代码应可以轻松编写。 现有的大多数 Dart 代码都是动态正确的，并且不会抛出空引用错误。
//产出的空安全代码应该是非常健全的。 对于静态检查而言，“健全”有着多层含义。而对我们来说，在空安全的上下文里，“健全”意味着如果一个表达式声明了一个不允许值为 null 的静态类型，那么这个表达式的任何执行结果都不可能为 null。
//需要注意一点：目前我们只能完全保证使用了空安全的代码的健全性。 Dart 程序支持新的空安全代码和旧的传统代码混合。在这些使用混合空安全的程序版本中，空引用的错误仍有可能出现。
//因此，对于空安全而言，我们的目标是让你对代码中的 null 可见且可控，并且确保它不会传递至某些位置从而引发崩溃。

//类型系统中的可空性
//从类型理论的角度来说，Null 类型被看作是所有类型的子类

//非空和可空类型
//空安全通过修改了类型的层级结构，从根源上解决了这个问题。 Null 类型仍然存在，但它不再是所有类型的子类。
//此处我们希望 dairy 参数能传入任意字符串，或者一个 null 值。为了表达我们的想法，我们在原有类型 String 的尾部加上 ? 使得 dairy 成为可空的类型。
makeCoffee(String coffee, [String? dairy]) {
  if (dairy != null) {
    print('$coffee with $dairy');
  } else {
    print('Black $coffee');
  }
}

//使用可空类型
// 只允许你访问同时在原有类型及 Null 类下同时定义的方法和属性。所以只有 toString()、== 和 hashCode 可以访问。
bad(String? maybeString) {
  //print(maybeString.length);
}
main() {
  bad(null);
}

//隐式转换 在 Dart 中一直存在。假设你将类型为 Object 的实例传递给了需要 String 的函数，
requireStringNotObject(String definitelyString) {
  print(definitelyString.length);
}

main1() {
  Object maybeStrin1 = 'it is';
  //requireStringNotObject(maybeString);
}

//无效的返回值
//在空安全下，如果一个返回值为非空类型的函数，没有可靠地返回一个值，你就会看到编译错误。
// Using null safety:
String alwaysReturns(int n) {
  if (n == 0) {
    return 'zero';
  } else if (n < 0) {
    throw ArgumentError('Negative values not allowed.');
  } else {
    if (n > 1000) {
      return 'big';
    } else {
      return n.toString();
    }
  }
}

//未初始化的变量
//顶层变量和静态字段必须包含一个初始化方法。 由于它们能在程序里的任何位置被访问到，编译器无法保证它们在被使用前已被赋值。唯一保险的选项是要求其本身包含初始化表达式，以确保产生匹配的类型的值。
//都是使用空安全
int topLevel = 0;

class SomeClass {
  static int staticField = 0;
}

//实例的字段也必须在声明时包含初始化方法，可以为常见初始化形式，也可以在实例的构造方法中进行初始化。
// class SomeClass {
//   int atDeclaration = 0;
//   int initializingFormal;
//   int initializationList;
//   SomeClass(this.initializingFormal) : initializationList = 0;
// }
//局部变量的灵活度最高。一个非空的变量 不一定需要 一个初始化方法。
int tracingFibonacci(int n) {
  int result;
  if (n < 2) {
    result = n;
  } else {
    result = tracingFibonacci(n - 2) + tracingFibonacci(n - 1);
  }
  print(result);
  return result;
}
//可选参数必须具有默认值。 如果一个可选位置参数或可选命名参数没有传递内容，Dart 会自动使用默认值进行填充。在未指定默认值的情况下，默认的 默认值为 null

//流程分析
// With (or without) null safety:
bool isEmptyList(Object object) {
  if (object is List) {
    return object.isEmpty; // <-- OK!
  } else {
    return false;
  }
}

//可达性分析
//当我们在分析一个函数时，return、break、throw 以及任何可能提早结束函数的方式，都将被考虑进来。
// bool isEmptyList(Object object) {
//   if (object is! List) return false;
//   return object.isEmpty;
// }

//为不可达的代码准备的 Never
//你可以自己 码出 这项可达性分析。新的底层类型 Never 是没有任何值的。
//事实上，根据语言的细则，throw 表达式的静态类型就是 Never。该类型已在核心库中定义，你可以将它用于变量声明。
Never wrongType(String type, Object value) {
  throw ArgumentError('Expected $type, but was ${value.runtimeType}.');
}

//或者
class Point {
  //late是后加的
  late final double x, y;
  bool operator ==(Object other) {
    if (other is! Point) wrongType('Point', other);
    return x == other.x && y == other.y;
  }
}

//绝对的赋值分析
//Dart 需要确保一个非空的局部变量在它被读取前一定完成了初始化。我们使用了 绝对的赋值分析，从而保证尽可能灵活地处理变量的初始化。

//空检查的类型提升
//我们已经将类型划分成了可空和非空的集合，如果一个变量是一个可空的类型，你无法对它 做 任何有用的事情。所以在 值为 null 的情况下，这项限制是很有效的，它可以避免你的程序崩溃。
String makeCommand(String executable, [List<String>? arguments]) {
  var result = executable;
  if (arguments != null) {
    result += ' ' + arguments.join(' ');
  }
  return result;
}
//它也同时和更智能的分析一起进行检查工作。
String makeCommand1(String executable, [List<String>? arguments]) {
  var result = executable;
  if (arguments == null) return result;
  return result + ' ' + arguments.join(' ');
}
//除了显式的 == null 和 != null 以外，显式使用 as 或赋值，以及后置操作符 !也会进行类型提升

//无用代码的警告
//这些警告不仅仅是为了减少无意义的代码，通过移除 不必要 的 null 判断，我们得以确保其他有意义的判断能够脱颖而出。我们期望你能 看到 你代码中的 null 会向何处传递。

//空值断言操作符
//可以通过使用 as 转换来断言类型
String toString() {
  var code;
  if (code == 200) return 'OK';
  var error;
  return 'ERROR $code ${(error as String).toUpperCase()}';
}
//也就是
String toString1() {
  var code;
  if (code == 200) return 'OK';
  var error;
  return 'ERROR $code ${error!.toUpperCase()}';
}

//懒加载的变量
//可以将它声明为可空，接着使用空断言操作符
class Coffee {
  String? _temperature;
  void heat() {
    _temperature = 'hot';
  }
  void chill() {
    _temperature = 'iced';
  }
  String serve() => _temperature! + ' coffee';
}
//为了处理类似延迟初始化这样常见的行为，我们新增了一个修饰符：late。你可以这样使用：
class Coffee1 {
  late String _temperature;
  void heat() {
    _temperature = 'hot';
  }
  void chill() {
    _temperature = 'iced';
  }
  String serve() => _temperature + ' coffee';
}

//延迟初始化
//当你这么声明时，会让初始化 延迟 执行。实例的构造将会延迟到字段首次被访问时执行，而不是在实例构造时就初始化。
// class Weather {
//   late int _temperature = _readThermometer();
// }

//延迟的终值
//可以将 late 与 final 结合使用
// Using null safety:
class Coffee2 {
  late final String _temperature;
  void heat() {
    _temperature = 'hot';
  }
  void chill() {
    _temperature = 'iced';
  }
  String serve() => _temperature + ' coffee';
}

//必需的命名参数
//为了保证你永远不会看到一个非空类型的参数值为 null，类型检查器给所有的可选参数提出了要求，要么是一个可空的类型，要么包含一个默认值。
function({int? a, required int? b, int? c, required int? d}) {}
//这里的所有参数都必须通过命名来传递。参数 a 和 c 是可选的，可以省略。参数 b 和 d 是必需的，调用时必须传递。

//抽象字段
//意思是字段和拆分的 getter 和 setter 没有区别。这是 Dart 中一个类的「属性」是否进行计算和存储的实现细节。因为这项功能的存在，当你在定义抽象类的接口时，会经常使用字段声明的形式：
class Beverage {}
abstract class Cup {
  late Beverage contents;
}
//这样的字段定义语句只是一对 getter 和 setter 的简写形式：
abstract class Cup1 {
  Beverage get contents;
  set contents(Beverage);
}
//所以随着空安全的推出，我们一并增加了显式声明抽象字段的支持：
abstract class Cup2 {
  abstract Beverage contents;
}

//与可空字段共舞
//同时具有私有和 final 的可空字段可以进行类型提升（某些特殊原因 除外）。如果你由于某种原因无法将字段设为私有和 final，你就需要一种变通的办法。
//基于流程分析的类型提升只适用于 同时具备私有和 final 的字段。否则，静态分析就无法 证明 这个字段的值在你判断后和使用前没有发生变化。

//可空性和泛型
// Using null safety:
class Interval<T extends num> {
  T min, max;
  Interval(this.min, this.max);
  bool get isEmpty => max <= min;
}

class Intervala<T extends num?> {
  T min, max;
  Intervala(this.min, this.max);
  bool get isEmpty {
    var localMin = min;
    var localMax = max;
    if (localMin == null || localMax == null) return false;
    return localMax <= localMin;
  }
}



