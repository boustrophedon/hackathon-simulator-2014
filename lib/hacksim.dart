library hacksim;

import 'package:entity_component/entity_component.dart';

part 'src/components.dart';
part 'src/systems/test_system.dart';

World create_world() {
  World world = new World();
  world.register_system(new TestSystem(world));
  return world;
}

