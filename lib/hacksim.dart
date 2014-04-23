library hacksim;

import 'dart:html';

import 'package:entity_component/entity_component.dart';

part 'src/components.dart';
part 'src/systems/TestSystem.dart';
part 'src/systems/InputSystem.dart';

World create_world() {
  World world = new World();
  world.register_system(new TestSystem(world));
  world.register_system(new InputSystem(world));
  return world;
}

