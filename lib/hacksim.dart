library hacksim;

import 'dart:html';

import 'package:entity_component/entity_component.dart';

part 'src/components.dart';
part 'src/systems/TestSystem.dart';
part 'src/systems/InputSystem.dart';
part 'src/systems/RenderSystem.dart';
part 'src/systems/EntityLoadSystem.dart';
part 'src/systems/PickingSystem.dart';

World create_world() {
  World world = new World();
  world.register_system(new EntityLoadSystem(world));
  world.register_system(new InputSystem(world));
  world.register_system(new RenderSystem(world));
  world.register_system(new PickingSystem(world));
  return world;
}

