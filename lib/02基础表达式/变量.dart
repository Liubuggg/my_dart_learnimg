void main() {
  //name 变量包含一个值为 "Bob" 的 String 对象的引用。
  var name1 = 'Bob';

  //如果一个对象不受限于单一类型，可以指定为 Object 类型
  Object name2 = 'Bob';

  //另一种选择是显式声明将要被推断的类型：
  String name3 = 'Bob';

  //当你为变量、参数或另一个相关组件指定类型时，可以控制该类型是否允许 null 。要让一个变量可以为空，你可以在类型声明的末尾添加 ?
  //String? name 可以为空
  //String name   不可以为空
  //Dart 不会为非可空类型设置初始值，它强制要求你设置初始值。

  //具有可空类型的未初始化变量的初始值为 null
  //具有数值类型的变量，初始值也为空，因为数字都是对象。
  int? lineCount;
  assert(lineCount == null);

  //必须在使用非空变量之前初始化它们的值：
  int lineCount1 = 0;

  //不必在声明变量时初始化变量，但在使用之前需要为其赋值。
  int lineCount2;
  bool weLikeToCount=true;
  if (weLikeToCount) {
//    lineCount = countLines();
  } else {
    lineCount = 0;
  }
  print(lineCount);

  //延迟初始化变量   1声明一个非空变量，但不在声明时初始化。  2延迟初始化一个变量。
  late String description;
  void main() {
    description = 'Feijoada!';
    print(description);
  }//如果你没有初始化一个 late 变量，那么当变量被使用时会发生运行时错误。
  //当一个 late 修饰的变量在声明时就指定了初始化方法，那么内容会在第一次使用变量时运行初始化。
//  late String temperature = readThermometer(); 

  //终值 (final) 和常量 (const)
  //不打算更改一个变量，可以使用 final 或 const 修饰它，
  //一个 final 变量只能设置一次，const 变量是编译时常量。
  final name = 'Bob'; 
  final String nickname = 'Bobby';

  //请使用 const 修饰编译时常量的变量。
  //如果 const 变量位于类级别，请将其标记为 static const（静态常量）。
  //在声明变量的位置，将其值设置为编译时常量，比如数字、字符串、const 常量或在常量数字上进行的算术运算的结果：
  const bar = 1000000; 
  const double atm = 1.01325 * bar; 
  //可以使用它来创建常量 值，以及声明 创建常量值的构造函数
  //任何变量都可以拥有常量值。
  var foo = const [];
  final bar1 = const [];
  const baz = []; 
  //如果变量的值没有被final或者const修饰，即使它以前被 const 修饰，你也可以修改这个变量：
  foo = [1, 2, 3]; 
  //在定义常量时使用 类型检查和转换、 集合中的 if 和 展开操作符
  const Object i = 3;
  const list = [i as int]; 
  const map = {if (i is int) i: 'int'}; 
  const set = {if (list is List<int>) ...list}; 

  //虽然 final 对象不能被修改，但它的字段可能可以被更改。相比之下，const 对象及其字段不能被更改：它们是 不可变的。
}
