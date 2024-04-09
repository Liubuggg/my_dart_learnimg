void main(){
  //记录表达式是以逗号分隔的命名或位置字段列表，括在括号中
  var record = ('first', a: 2, b: true, 'last');

  //记录类型注释是括在括号中的逗号分隔的类型列表。可以使用记录类型注释来定义返回类型和参数类型。
  (int, int) swap((int, int) record) {
    var (a, b) = record;
    return (b, a);
  }

  //记录表达式和类型注释中的字段反映了参数和参数在函数中的工作方式。
  (String, int) record1;
  record1 = ('A string', 123);

  //在记录表达式中，名称在每个字段值之前，后面有一个冒号：
  ({int a, bool b}) record3;
  record3 = (a: 123, b: true);

  //记录类型中命名字段的名称是记录类型定义或其形状的一部分。两个具有不同名称的命名字段的记录具有不同的类型
  ({int a, int b}) recordAB = (a: 1, b: 2);
  ({int x, int y}) recordXY = (x: 3, y: 4);

  //可以为位置字段命名，但这些名称纯粹用于文档，不影响记录的类型
  (int a, int b) recordAB1 = (1, 2);
  (int x, int y) recordXY1 = (3, 4);
  recordAB1 = recordXY1; // 相同

  //记录字段可以通过内置获取器访问。记录是不可变的，因此字段没有设置器。
  var record4 = ('first', a: 2, b: true, 'last');
  print(record4.$1); //first
  print(record4.a); // 2
  print(record4.b); // true
  print(record4.$2); // last

  //记录中的每个字段都有自己的类型。在同一记录中，字段类型可能不同。无论从记录何处访问，类型系统都能知道每个字段的类型
  (num, Object) pair = (42, 'a');
  var first = pair.$1;//int
  var second = pair.$2; //String

  //如果两个记录具有相同的形状（字段集），并且其相应的字段具有相同的值，则它们是相等的
  //命名字段的顺序不影响相等
  (int x, int y, int z) point = (1, 2, 3);
  (int r, int g, int b) color = (1, 2, 3);
  print(point == color); // 相等.
  ({int x, int y, int z}) point1 = (x: 1, y: 2, z: 3);
  ({int r, int g, int b}) color1 = (r: 1, g: 2, b: 3);
  print(point1 == color1); //不想等

  //记录允许函数返回捆绑在一起的多个值
  (String name, int age) userInfo(Map<String, dynamic> json) {
    return (json['name'] as String, json['age'] as int);
  }
  final json = <String, dynamic>{
    'name': 'Dash',
    'age': 10,
    'color': 'blue',
  };
  var (name, age) = userInfo(json);

//   //可以使用其命名字段对记录进行解构，使用冒号:语法
//   ({String name, int age}) userInfo(Map<String, dynamic> json)
//   final (:name, :age) = userInfo(json);
// }
}