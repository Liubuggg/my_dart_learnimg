//枚举类型
enum PlanetType { terrestrial, gas, ice }

//一个增强型枚举的示例，定义了一组行星类的常量实例，即太阳系的行星：
enum Planet {
  mercury(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  venus(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  uranus(planetType: PlanetType.ice, moons: 27, hasRings: true),
  neptune(planetType: PlanetType.ice, moons: 14, hasRings: true);

  // 常量构造函数
  const Planet(
      {required this.planetType, required this.moons, required this.hasRings});

  // 枚举实例的属性都是final的
  final PlanetType planetType;
  final int moons;
  final bool hasRings;

  // 增强枚举支持getters和其他方法
  // 判断行星是否是巨大的气体行星或冰巨星
  bool get isGiant =>
      planetType == PlanetType.gas || planetType == PlanetType.ice;
}

void main(){
  final yourPlanet = Planet.mercury;

  if (!yourPlanet.isGiant) {
    print('Your planet is not a "giant planet".');
  }

 }