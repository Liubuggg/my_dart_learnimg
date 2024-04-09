//函数
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}
void main(){
  var result = fibonacci(20);
  //=>简写语法用于仅包含一条语句的函数。该语法在将匿名函数作为参数传递时非常有用：
  //将顶层函数 print() 作为参数传给了 forEach() 函数。
  var flybyObjects;
  flybyObjects.where((name) => name.contains('turn')).forEach((print));

}