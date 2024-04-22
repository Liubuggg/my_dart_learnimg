class Foo {}
String getFileName() {
  return "123";
}
void main(){
  //下面代码中所有的变量都是非空的
  var i = 42; 
  String name = getFileName();
  final b = Foo();
  //若你想让变量可以为 null，只需要在类型声明后加上 ?。
  int? aNullableInt = null;
  //空安全的原则
  //默认不可空。除非你将变量显式声明为可空，否则它一定是非空的类型。
  //完全可靠。Dart 的空安全是非常可靠的，意味着编译期间包含了很多优化。如果类型系统推断出某个变量不为空，那么它 永远 不为空。


}