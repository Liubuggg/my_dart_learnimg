void main(){

    //变量，可以用var定义，支持类型推断
  //String
  var name = 'Voyager I';
  //int
  var year = 1977;
  //double
  var antennaDiameter = 3.7;
  //List<String>
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  //Map<String, Object>
  var image = {
    'tags': ['saturn'],
    'url': '//path/to/saturn.jpg'
  };
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  }

  //final object关键字
  for (final object in flybyObjects) {
    print(object);
  }

  for (int month = 1; month <= 12; month++) {
    print(month);
  }

  while (year < 2016) {
    year += 1;
  }
}