import 'package:characters/characters.dart';
void main() {
  //一些定义整数文字的示例
  var x = 1;
  var hex = 0xDEADBEEF;
  //一些定义的double例子
  var y = 1.1;
  var exponents = 1.42e5;
  //将变量声明为num。可以同时具有整数值和double值。
  num x1 = 1;
  x1 += 2.5;
  double z = 1; // 实际上z是1.0
  //将字符串转换为数字的方法
  // String -> int
  var one = int.parse('1');
  assert(one == 1);
  // String -> double
  var onePointOne = double.parse('1.1');
  assert(onePointOne == 1.1);
  // int -> String
  String oneAsString = 1.toString();
  assert(oneAsString == '1');
  // double -> String
  String piAsString = 3.14159.toStringAsFixed(2);
  assert(piAsString == '3.14');
  //int类型指定了传统的（<<，>>，>>>）、补码（~）、AND（&）、OR（|）和XOR（^）运算符，这些运算符可用于操作和屏蔽位字段中的标志。
  assert((3 << 1) == 6); // 0011 << 1 == 0110
  assert((3 | 4) == 7); // 0011 | 0100 == 0111
  assert((3 & 4) == 0); // 0011 & 0100 == 0000

  //字面数字它们的操作数是计算为数字的编译时常数。
  const msPerSecond = 1000;
  const secondsUntilRetry = 5;
  const msUntilRetry = secondsUntilRetry * msPerSecond;

  //String对象包含UTF-16代码单元的序列。使用单引号或双引号来创建字符串
  var s1 = 'Single quotes work well for string literals.';
  var s2 = "Double quotes work just as well.";
  var s3 = 'It\'s easy to escape the string delimiter.';
  var s4 = "It's even easier to use the other delimiter.";
  //使用${expression}将表达式的值放入字符串中
  //如果表达式是标识符，您可以跳过{}。
  //要获取与对象对应的字符串，Dart调用object'stoStringtoString()方法。
  var s = 'string interpolation';

  assert('Dart has $s, which is very handy.' ==
      'Dart has string interpolation, '
          'which is very handy.');
  assert('That deserves all caps. '
          '${s.toUpperCase()} is very handy!' ==
      'That deserves all caps. '
          'STRING INTERPOLATION is very handy!');
  //可以使用相邻的字符串文字或+运算符连接字符串：
  var s11 = 'String '
      'concatenation'
      " works even over line breaks.";
  assert(s11 ==
      'String concatenation works even over '
          'line breaks.');
  var s21 = 'The + operator ' + 'works, as well.';
  assert(s21 == 'The + operator works, as well.');
  //要创建多行字符串，请使用带有单引号或双引号的三重引号
  var s12 = '''
  You can create
  multi-line strings like this one.
  ''';
  var s22 = """This is also a
  multi-line string.""";
  //可以通过在前缀为r来创建“原始”字符串
  var s5 = r'In a raw string, not even \n gets special treatment.';

  //字面字符串是编译时常量，只要任何插值表达式都是编译时常量，其计算为空值或数字、字符串或布尔值。
  const aConstNum = 0;
  const aConstBool = true;
  const aConstString = 'a constant string';
  var aNum = 0;
  var aBool = true;
  var aString = 'a string';
  const aConstList = [1, 2, 3];
  const validConstString = '$aConstNum $aConstBool $aConstString';

  //Dart有一个名为bool的类型。只有两个对象具有布尔类型：布尔文字true和false
  var fullName = '';
  assert(fullName.isEmpty);
  var hitPoints = 0;
  assert(hitPoints <= 0);
  var unicorn = null;
  assert(unicorn == null);
  var iMeantToDoThis = 0 / 0;
  assert(iMeantToDoThis.isNaN);

  //符文和字素簇
  var hi = 'Hi 🇩🇰';
  print(hi);
  print('The end of the string: ${hi.substring(hi.length - 1)}');
  print('The last character: ${hi.characters.last}');


}
