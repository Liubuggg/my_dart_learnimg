class Television {
  @Deprecated('Use turnOn instead')
  void activate() {
    turnOn();
  }
}

  void turnOn() {}

//可以定义自己的元数据注释。这里有一个定义@Todo注释的例子，它需要两个参数：
class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}
//使用@Todo注释的例子：
@Todo('Dash', 'Implement this function')
void doSomething() {
  print('Do something');
}

void main(){
  //使用元数据提供有关代码的其他信息。元数据注释以字符@开头，然后是对编译时常量（如deprecated）的引用或对常量构造函数的调用。
 
}