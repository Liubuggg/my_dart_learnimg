// void main(){
//   if (isRaining()) {
//     you.bringRainCoat();
//   } else if (isSnowing()) {
//     you.wearJacket();
//   } else {
//     car.putTopDown();
//   }

//   //Dart if语句支持case句，后跟模式
//   if (pair case [int x, int y]) return Point(x, y);//列表模式[int x, int y]与值pair匹配，因此分支return Point(x, y)与模式定义的变量x和y一起执行。
//   //if-case语句提供了一种针对单个模式匹配和解构的方法。
//   if (pair case [int x, int y]) {
//     print('Was coordinate array $x,$y');
//   } else {
//     throw FormatException('Invalid coordinates.');
//   }

//   //switch语句根据一系列案例计算值表达式。每个case句都是值匹配的模式。您可以为案例使用任何类型的模式。
//   //当case子句不匹配时，使用default或通配符_子句执行代码
//   var command = 'OPEN';
//   switch (command) {
//     case 'CLOSED':
//       executeClosed();
//     case 'PENDING':
//       executePending();
//     case 'APPROVED':
//       executeApproved();
//     case 'DENIED':
//       executeDenied();
//     case 'OPEN':
//       executeOpen();
//     default:
//       executeUnknown();
//   }
//   //对于没有失败的空案例，请使用break作为其主体。对于非顺序下降，您可以使用continue语句和标签：
//   switch (command) {
//     case 'OPEN':
//       executeOpen();
//       continue newCase; 
//     case 'DENIED':
//     case 'CLOSED':
//       executeClosed();
//     newCase:
//     case 'PENDING':
//       executeNowClosed(); 
//   }

//   //如果您想在表达式语句的开头使用开关，请使用aswitch语句。
//   //切换表达式允许您像这样重写切换语句：
//   switch (charCode) {
//     case slash || star || plus || minus: // Logical-or pattern
//       token = operator(charCode);
//     case comma || semicolon: // Logical-or pattern
//       token = punctuation(charCode);
//     case >= digit0 && <= digit9: // Relational and logical-and patterns
//       token = number();
//     default:
//       throw FormatException('Invalid');
//   }
//   //变成一个表达，
//   token = switch (charCode) {
//     slash || star || plus || minus => operator(charCode),
//     comma || semicolon => punctuation(charCode),
//     >= digit0 && <= digit9 => number(),
//     _ => throw FormatException('Invalid')
//   };

//   //详尽性检查是一项功能，如果值可能进入开关，但与任何情况不匹配，则会报告编译时错误。
//   switch (nullableBool) {
//     case true:
//       print('yes');
//     case false:
//       print('no');
//   }

//   //要在case子句之后设置可选的guard子句，请使用关键字when。
//   //if case，则可以跟随保护子句，同时switch语句和表达式。

// }



// //枚举和密封类型对交换机特别有用，因为即使没有默认情况，其可能的值也是已知且完全可枚举的。
// //在类上使用sealed修饰符，在切换该类的子类型时启用详尽性检查：
// sealed class Shape {}

// class Square implements Shape {
//   final double length;
//   Square(this.length);
// }

// class Circle implements Shape {
//   final double radius;
//   Circle(this.radius);
// }

// double calculateArea(Shape shape) => switch (shape) {
//       Square(length: var l) => l * l,
//       Circle(radius: var r) => math.pi * r * r
//     };
