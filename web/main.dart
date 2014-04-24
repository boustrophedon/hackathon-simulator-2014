import 'package:hack_sim_2014/hacksim.dart';
import 'package:entity_component/entity_component.dart';

import 'dart:html';

void main() {
  World w = create_world();
  w.globaldata['canvas'] = querySelector('#area');
  w.run();
}
