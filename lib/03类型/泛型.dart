//泛型允许您在多种类型之间共享单个接口和实现，同时仍然利用静态分析。
import 'package:flutter/material.dart';

abstract class ObjectCache {
  Object getByKey(String key);
  void setByKey(String key, Object value);
}
abstract class StringCache {
  String getByKey(String key);
  void setByKey(String key, String value);
}
//通用类型可以为您省去创建所有这些接口的麻烦，T是备用类型，这是一个占位符
abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}

//希望限制可以作为参数提供的类型，因此参数必须是特定类型的子类型。您可以使用extends来执行此行此行。
class Foo<T extends Object> {}
//可以将extends与其他类型一起使用
class Foo1<T extends SomeBaseClass> {
  String toString() => "Instance of 'Foo1<$T>'";
}

class SomeBaseClass {
}
class Extender extends SomeBaseClass {}
//使用SomeBaseClass或其任何子类型作为通用参数是可以的
var someBaseClassFoo = Foo<SomeBaseClass>();
var extenderFoo = Foo<Extender>();
//也可以不指定通用参数
var foo = Foo();
print(foo) {
  // TODO: implement print
  throw UnimplementedError();
} 

//方法和函数也允许类型参数：
T first<T>(List<T> ts) {
  T tmp = ts[0];
  return tmp;
}

void main(){
  //使用集合文字
  var names = <String>['Seth', 'Kathy', 'Lars'];
  var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
  var pages = <String, String>{
    'index.html': 'Homepage',
    'robots.txt': 'Hints for web robots',
    'humans.txt': 'We are people, not machines'
  };

  //要在使用构造函数时指定一个或多个类型，请将类型放在类名之后的角括号中（<...>）
  var nameSet = Set<String>.from(names);
  //创建一个具有整数键和视图类型值的映射
  var views = Map<int, View>();

  //泛型类型被重新化，这意味着它们在运行时携带其类型信息。
  var names1 = <String>[];
  names1.addAll(['Seth', 'Kathy', 'Lars']);
  print(names1 is List<String>); // true



}