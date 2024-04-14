class Performer {
  late String name;
}

class Person extends Performer {
  Person(String personName) {
    name = personName;
  }
}


//Mixins是一种定义可以在多个类层次结构中重用的代码的方式。它们旨在提供成员集体实施。
//要使用混合，请使用关键字后跟一个或多个混合名称。
//要定义混音，请使用mixin声明。在极少数情况下，您需要同时定义混合类和类，您可以使用mixin class声明。
class Musician extends Performer with Musical {
}

// class Maestro extends Person with Musical, Aggressive, Demented {
//   String name;
//   bool canConduct;
//   Maestro(String maestroName) : super('') {
//     name = maestroName;
//     canConduct = true;
//   }
// }
class Aggressive {
  bool isAggressive;
  Aggressive({this.isAggressive = false});
}

class Demented {
  bool isDemented;
  Demented({this.isDemented = false});
}
//Mixins和mixin类不能有extends子句，也不得声明任何生成构造函数。
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}
//限制可以使用混合的类型。例如，mixin可能取决于能否调用mixin没有定义的方法。可以使用on关键字指定所需的超类来限制混合的使用
class Musician1 {
  // ...
}
mixin MusicalPerformer on Musician1 {
  // ...
}
class SingerDancer extends Musician1 with MusicalPerformer {
  // ...
}

//abstract mixin class
//对于混合类，可以实现与on指令类似的行为。制作混合类abstract并定义其行为所依赖的抽象方法：
abstract mixin class Musician2 {
  // No 'on' clause, but an abstract method that other types must define if 
  // they want to use (mix in or extend) Musician: 
  void playInstrument(String instrumentName);
  void playPiano() {
    playInstrument('Piano');
  }
  void playFlute() {
    playInstrument('Flute');
  }
}
class Virtuoso with Musician2{ // Use Musician as a mixin
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName beautifully');
  }  
} 
class Novice extends Musician { // Use Musician as a class
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName poorly');
  }  
}
//通过将Musician混音声明为抽象，可以强制任何使用它的类型来定义其行为所依赖的抽象方法。