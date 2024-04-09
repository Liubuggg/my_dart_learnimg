void main(){
  //数组是List对象，所以大多数人只是称它们为列表。
  var list = [1, 2, 3];
  var list1 = [
    'Car',
    'Boat',
    'Plane',
  ];
  assert(list.length == 3);
  assert(list[1] == 2);
  list[1] = 1;
  assert(list[1] == 1);
  //要创建编译时常量的列表，请在列表文字之前添加const：
  var constantList = const [1, 2, 3];

  //一个简单的Dart集，使用集合文字创建：
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
  //要创建空集，请使用{}前面有一个类型参数，或将{}分配给类型为Set的变量：
  var names = <String>{};
  // Set<String> names = {}; // This works, too.?
  // var names = {}; // Creates a map, not a set.?
  //使用add()或addAll()方法将项目添加到现有集中：
  var elements = <String>{};
  elements.add('fluorine');
  elements.addAll(halogens);
  //使用.length获取集合中的项目数量：
  var elements1 = <String>{};
  elements1.add('fluorine');
  elements1.addAll(halogens);
  assert(elements1.length == 5);
  //要创建一个编译时常量的集合，请在集合文字之前添加const：
  final constantSet = const {
    'fluorine',
    'chlorine',
    'bromine',
    'iodine',
    'astatine',
  };

  //一般来说，地图是关联键和值的对象。键和值都可以是任何类型的对象。每个键只出现一次，但您可以多次使用相同的值。
  var gifts = {
    // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings'
  };
  var nobleGases = {
    2: 'helium',
    10: 'neon',
    18: 'argon',
  };
  //使用地图构造函数创建相同的对象
  var gifts1 = Map<String, String>();
  gifts1['first'] = 'partridge';
  gifts1['second'] = 'turtledoves';
  gifts1['fifth'] = 'golden rings';
  var nobleGases1 = Map<int, String>();
  nobleGases1[2] = 'helium';
  nobleGases1[10] = 'neon';
  nobleGases1[18] = 'argon';
  //使用下标赋值运算符（[]=）将新的键值对添加到现有地图中
  var gifts2 = {'first': 'partridge'};
  gifts2['fourth'] = 'calling birds'; 
  //使用下标运算符从地图中检索值（[]）：
  var gifts3 = {'first': 'partridge'};
  assert(gifts3['first'] == 'partridge');
  //如果查找地图中没有的密钥，将得到null值作为回报：
  var gifts4 = {'first': 'partridge'};
  assert(gifts4['fifth'] == null);
  //使用.length获取地图中键值对的数量：
  var gifts5 = {'first': 'partridge'};
  gifts5['fourth'] = 'calling birds';
  assert(gifts5.length == 2);
  //要创建编译时常量的映射，请在映射文本之前添加const：
  final constantMap = const {
    2: 'helium',
    10: 'neon',
    18: 'argon',
  };
  //Dart支持传播运算符（...）和零感知传播运算符（...?）在列表、地图和设置文字中。传播运算符提供了一种在集合中插入多个值的简明方法。
  //可以使用扩展运算符（...）将列表的所有值插入到另一个列表中：
  var list3 = [1, 2, 3];
  var list2 = [0, ...list3];
  assert(list2.length == 4);
  //如果传播运算符右侧的表达式可能为空，可以通过使用空感知传播运算符（...?）来避免异常：、
  var list4 = [0, ...?list];
  assert(list4.length == 1);

  //以下是使用集合的示例，如果要创建一个包含三个或四个项目的列表
  var promoActive;
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  //Dart还支持集合文字中的if-case：
  var login;
  var nav1 = [
    'Home',
    'Furniture',
    'Plants',
    if (login case 'Manager') 'Inventory'
  ];
  //在将列表添加到另一个列表之前使用集合来操作列表项目的示例：
  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  assert(listOfStrings[1] == '#1');

  
}