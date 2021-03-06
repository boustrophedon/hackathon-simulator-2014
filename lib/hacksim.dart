library hacksim;

import 'dart:html';
import 'dart:math' as math;
import 'dart:collection';

import 'dart:async';

import 'package:entity_component/entity_component.dart';

part 'src/components.dart';
part 'src/animations.dart';

part 'src/systems/TestSystem.dart';
part 'src/systems/InputSystem.dart';
part 'src/systems/RenderSystem.dart';
part 'src/systems/BoardRenderSystem.dart';
part 'src/systems/UIRenderSystem.dart';
part 'src/systems/EntityLoadSystem.dart';
part 'src/systems/PickingSystem.dart';
part 'src/systems/DragSystem.dart';
part 'src/systems/APISystem.dart';
part 'src/systems/APISlotSystem.dart';
part 'src/systems/UISystem.dart';
part 'src/systems/BoardSystem.dart';
part 'src/systems/MoneySystem.dart';
part 'src/systems/KeyboardMashSystem.dart';
part 'src/systems/DeviceShakeSystem.dart';
part 'src/systems/HackSystem.dart';
part 'src/systems/CaffeineSystem.dart';
part 'src/systems/AdSystem.dart';
part 'src/systems/AnimationSystem.dart';
part 'src/systems/RecruiterSystem.dart';

part 'src/renderers/Renderer.dart';
part 'src/renderers/APIRenderer.dart';
part 'src/renderers/APISlotRenderer.dart';
part 'src/renderers/RectPickingRenderer.dart';
part 'src/renderers/BoardRenderer.dart';
part 'src/renderers/UIButtonRenderer.dart';
part 'src/renderers/UIPopupRenderer.dart';
part 'src/renderers/UILabelRenderer.dart';
part 'src/renderers/UIProgressBarRenderer.dart';

World create_world() {
  World world = new World();
  world.register_system(new BoardSystem(world));
  world.register_system(new BoardRenderSystem(world));
  world.register_system(new RenderSystem(world));
  world.register_system(new UIRenderSystem(world));
  world.register_system(new AnimationSystem(world));
  world.register_system(new InputSystem(world));
  world.register_system(new PickingSystem(world));
  world.register_system(new DragSystem(world));
  world.register_system(new APISystem(world));
  world.register_system(new APISlotSystem(world));
  world.register_system(new MoneySystem(world));
  world.register_system(new HackSystem(world));
  world.register_system(new RecruiterSystem(world));
  world.register_system(new CaffeineSystem(world));
  world.register_system(new AdSystem(world));
  world.register_system(new KeyboardMashSystem(world));
  world.register_system(new DeviceShakeSystem(world));
  world.register_system(new UISystem(world));
  world.register_system(new EntityLoadSystem(world));
  return world;
}

