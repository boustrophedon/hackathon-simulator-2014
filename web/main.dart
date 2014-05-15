import 'package:hack_sim_2014/hacksim.dart';
import 'package:entity_component/entity_component.dart';

import 'dart:html';

void main() {
  World w = create_world();

  CanvasElement canvas = querySelector('#area');
  // make the canvas the full size of the window
  canvas.height = window.innerHeight;
  canvas.width = window.innerWidth;
  
  w.globaldata['canvas'] = canvas;
  w.run();
}
