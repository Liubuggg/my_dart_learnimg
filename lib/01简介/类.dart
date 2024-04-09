//类
class Spacecraft {
  String name;
  DateTime? launchDate;
  // 读取器属性，用于获取发射年份，属性不可变且不是final
  // 如果发射日期不为空，则返回其年份，否则返回null
  int? get launchYear => launchDate?.year;
  // 构造方法，使用语法糖直接为成员变量赋值
  Spacecraft(this.name, this.launchDate) {
    //
  }
  // 命名构造函数，将名称传递给默认构造函数，发射日期设置为null
  Spacecraft.unlaunched(String name) : this(name, null);

  // 方法，用于描述航天器
  void describe() {
    print('Spacecraft: $name');
    // 尝试将getter转换为变量，但类型提升在getter上不起作用
    // 获取launchDate
    var launchDate = this.launchDate;
    if (launchDate != null) {
      // 计算从发射日期至今的年数
      // 使用 ~/ 来进行向下取整的整数除法
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

//继承
class Orbiter extends Spacecraft {
  double altitude;

  Orbiter(super.name, DateTime super.launchDate, this.altitude);
}

//Mixin 是一种在多个类层次结构中重用代码的方法。？
mixin Piloted {
  int astronauts = 1;

  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

//使用 Mixin 的方式继承这个类就可将该类中的功能添加给其它类
//自此，PilotedCraft 类中就包含了 astronauts 字段以及 describeCrew() 方法。
class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft(super.name, super.launchDate);
  //具体实现
}


//接口与抽象类
//所有的类都隐式定义成了一个接口。因此，任意类都可以作为接口被实现。
class MockSpaceship implements Spacecraft {
  @override
  DateTime? launchDate;

  @override
  late String name;

  @override
  void describe() {
    // TODO: implement describe
  }

  @override
  // TODO: implement launchYear
  int? get launchYear => throw UnimplementedError();
  // ···
}

//一个被任意具体类扩展（或实现）的抽象类，抽象类可以包含抽象方法（不含方法体的方法）。
//任意一个扩展了 Describable 的类都拥有 describeWithEmphasis() 方法，这个方法又会去调用实现类中实现的 describe() 方法。
abstract class Describable {
  void describe();
  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}

void main(){
  //使用 Spacecraft 类
  var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  voyager.describe();
  var voyager3 = Spacecraft.unlaunched('Voyager III');
  voyager3.describe();
}