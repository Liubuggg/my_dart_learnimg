/*
扩展类型是一种编译时抽象，它用不同的、仅静态的接口“包装”现有类型。它们是静态JS互操作的主要组成部分，因为它们可以轻松修改现有类型的接口（对任何类型的互操作都至关重要），而不会产生实际包装的成本。
扩展类型对底层类型的对象（称为表示类型）的操作集（或接口）强制执行纪律。在定义扩展类型的接口时，您可以选择重用表示类型的一些成员，省略其他成员，替换其他成员，并添加新功能。
以下示例包装了int类型，以创建一个扩展类型，该类型只允许对ID号有意义的操作：
 */
extension type IdNumber(int id) {
  operator <(IdNumber other) => id < other.id;
}

void main() {
  int myUnsafeId = 42424242;
  myUnsafeId = myUnsafeId + 10;

  var safeId = IdNumber(42424242);
  //safeId + 10;
  myUnsafeId = safeId as int;
  myUnsafeId = safeId as int;
  safeId < IdNumber(42424241);

  E2(4);
  E2.n(3);
  E2.m(5, "Hello!");

  E4();
  const E4._(2);
  E4.otherName(3);

  var v1 = NumberT(1); // NumberT
  int v2 = NumberT(2); // int
  var v3 = v1.i - v1; //  int
  var v4 = v2 + v1; //  int
  var v5 = 2 + v1; //  int
  // Error
  //v2.i;
}

//使用extension type声明和名称定义一个新的扩展类型，后跟括号中的表示类型声明
/*
表示类型声明(int i)指定扩展类型E的底层类型是int，对表示对象的引用名为i。宣言还引入了：
以表示类型为返回类型的表示对象的隐式获取器：int get i。
隐式构造函数：E(int i) : i = i。
表示对象允许扩展类型访问底层类型的对象。该对象在扩展类型主体的范围内，您可以使用其名称作为获取器访问它：
在扩展类型主体中，使用i（或构造函数中的this.i）。
外部使用e.i进行属性提取（其中e的扩展类型作为其静态类型）。
*/
extension type E(int i) {}

//扩展类型声明也可以包括类型参数，就像类或扩展一样
extension type E1<T>(List<T> elements) {
  // ...
}

//扩展类型的主体中声明构造函数。表示声明本身是一个隐式构造函数，因此默认情况下，它取代了扩展类型的未命名构造函数。任何额外的非重定向生成构造函数必须在其初始化器列表或形式参数中使用this.i初始化表示对象的实例变量。
extension type E2(int i) {
  E2.n(this.i);
  E2.m(int j, String foo) : i = j + foo.length;
}

//可以命名表示声明构造函数，在这种情况下，正文中还有未命名构造函数的空间
extension type const E4._(int it) {
  E4() : this._(42);
  E4.otherName(this.it);
}

//完全隐藏构造函数，而不仅仅是定义一个新的构造函数，为类使用相同的私有构造函数语法，_。例如，只希望客户端使用String构造E，即使底层类型是int：
extension type E5._(int i) {
  E5.fromString(String foo) : i = int.parse(foo);
}

//在扩展类型的正文中声明成员，以定义其接口，就像定义类成员一样。扩展类型成员可以是方法、获取器、设置器或运算符
extension type NumberE(int value) {
  // Operator:
  NumberE operator +(NumberE other) => NumberE(value + other.value);
  // Getter:
  NumberE get myNum => this;
  // Method:
  bool isValid() => !value.isNegative;
}

//实施
/*
可以选择使用implements句来：
在扩展类型上引入子类型关系，以及
将表示对象的成员添加到扩展类型界面中。
implements子句引入了一种适用性关系，就像扩展方法及其类型之间的适用性关系一样。适用于超类型的成员也适用于子类型，除非子类型具有具有相同成员名称的声明。
*/
//它的表示类型。这使得表示类型的所有成员都隐式地可用于扩展类型。
extension type NumberI(int i) implements int {}
//其表示类型的超类型。这使得超类型的成员可用，而不一定是表示类型的所有成员。
extension type Sequence<T>(List<T> _) implements Iterable<T> {}
extension type Id(int _id) implements Object {
  static Id? tryParse(String source) => int.tryParse(source) as Id?;
}
//另一种在相同表示类型上有效的扩展类型。这允许您跨多个扩展类型（类似于多重继承）重用操作。
extension type const Opt<T>._(({T value})? _) {
  const factory Opt(T value) = Val<T>;
  const factory Opt.none() = Non<T>;
}
extension type const Val<T>._(({T value}) _) implements Opt<T> {
  const Val(T value) : this._((value: value));
  T get value => _.value;
}
extension type const Non<T>._(Null _) implements Opt<Never> {
  const Non() : this._(null);
}
//声明与超类型成员共享名称的扩展类型成员不是像类之间的覆盖关系，而是重新声明。扩展类型成员声明完全替换了任何具有相同名称的超类型成员。不可能为同一函数提供替代实现。
//您可以使用@redeclare注释告诉编译器您故意选择使用与超级类型成员相同的名称。然后，如果这不是真的，分析器会警告你，例如，如果其中一个名字打错了。
extension type MyString(String _) implements String {
  // Replaces 'String.operator[]'
  //@redeclare
  int operator [](int index) => codeUnitAt(index);
}

//要使用扩展类型，请创建一个与类相同的实例：通过调用构造函数
extension type NumberE1(int value) {
  NumberE1 operator +(NumberE1 other) => NumberE1(value + other.value);
  NumberE1 get next => NumberE1(value + 1);
  bool isValid() => !value.isNegative;
}
void testE() {
  var num = NumberE1(1);
}

//为现有类型提供扩展接口
//当扩展类型实现其表示类型时，您可以将其视为“透明”，因为它允许扩展类型“看到”底层类型。
//透明扩展类型可以调用表示类型的所有成员（被声明为”的所有成员，以及它定义的任何辅助成员。这为现有类型创建了一个新的扩展接口。新接口适用于静态类型为扩展类型的表达式。
//这意味着您可以调用表示类型的成员
extension type NumberT(int value) implements int {
  // Doesn't explicitly declare any members of 'int'.
  NumberT get i => this;
}

//为现有类型提供不同的接口
//不透明的扩展类型（不implement其表示类型）被静态地视为全新的类型，与其表示类型不同。您不能将其分配给其表示类型，也不会公开其表示类型的成员。
void testE1() {
  var num1 = NumberE1(1);
  //int num2 = NumberE(2); // Error
  num1.isValid();
//  num1.isNegative(); // Error1

  var sum1 = num1 + num1;
  //var diff1 = num1 - num1; // Error
  var diff2 = num1.value - 2;
  //var sum2 = num1 + 2; // Error

  List<NumberE1> numbers = [
    NumberE1(1),
    num1.next,
    //1, // Error
  ];
}
