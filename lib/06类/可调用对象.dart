//call()方法允许定义它的任何类的实例来模拟函数。此方法支持与正常函数相同的功能，如参数和返回类型。
class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

var wf = WannabeFunction();
var out = wf('Hi', 'there,', 'gang');

void main() => print(out);
