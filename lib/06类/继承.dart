//使用extends来创建子类，使用super来引用超级类
class Television {
  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }
  // ···
}
class _activateIrSensor {
}
class _illuminateDisplay {
}
class SmartTelevision extends Television {
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }
  // ···
}
class _upgradeApps {
}
class _initializeMemory {
}
class _bootNetworkInterface {
}

//子类可以覆盖实例方法（包括运算符）、获取器和设置器。可以使用@override注释来指示故意覆盖成员：
/*
 重写方法声明必须与它以几种方式重写的方法（或多种方法）匹配：
返回类型必须与重写方法的返回类型相同（或子类型）。
参数类型必须与重写方法的参数类型相同（或超类型）。在前面的示例中，SmartTelevision的contrast设置器将参数类型从int更改为超类型num。
如果重写方法接受n个位置参数，那么重写方法也必须接受n个位置参数。
通用方法不能覆盖非通用方法，非通用方法不能覆盖通用方法。
有时，可能想缩小方法参数或实例变量的类型。这违反了正常规则，它类似于downcast，因为它可能会在运行时导致类型错误。尽管如此，如果代码可以保证不会发生类型错误，则可以缩小类型范围。在这种情况下，可以在参数声明中使用covariant关键字。有关详细信息，请参阅Dart语言规范。
 */
class Television1 {
  // ···
  set contrast(int value) {}
}
class SmartTelevision1 extends Television {
  @override
  set contrast(num value) {}
  // ···
}

//noSuchMethod（）
//每当代码尝试使用不存在的方法或实例变量时，都可以检测或做出反应，可以覆盖noSuchMethod()
class A {
  // Unless you override noSuchMethod, using a
  // non-existent member results in a NoSuchMethodError.
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: '
        '${invocation.memberName}');
  }
}
