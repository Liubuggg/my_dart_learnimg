import 'dart:io';

void main(){
  //异常
  //使用 throw 关键字抛出一个异常：
  var astronauts=0;
  if (astronauts == 0) {
    throw StateError('No astronauts');
  }
  //使用 try 语句配合 on 或 catch（两者也可同时使用）关键字来捕获一个异常:
  Future<void> describeFlybyObjects(List<String> flybyObjects) async {
    try {
      for (final object in flybyObjects) {
        var description = await File('$object.txt').readAsString();
        print(description);
      }
    } on IOException catch (e) {
      print('Could not describe object: $e');
    } finally {
      flybyObjects.clear();
    }
  }
}