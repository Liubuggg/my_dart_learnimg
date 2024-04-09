//类型别名——通常称为typedef，因为它是用关键字typedef声明的——是引用类型的简明方式。
typedef IntList = List<int>;
IntList il = [1, 2, 3];
//类型别名可以有类型参数：
typedef ListMapper<X> = Map<X, List<X>>;
Map<String, List<String>> m1 = {}; 
ListMapper<String> m2 = {}; 
//建议对函数使用内联函数类型而不是typedefs。然而，函数typedefs仍然有用：
typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;

void main() {
  assert(sort is Compare<int>); // True!
}
