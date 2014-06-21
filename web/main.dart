import 'package:hack_sim_2014/hacksim.dart';
import 'package:hack_sim_2014/loaders.dart';
import 'package:entity_component/entity_component.dart';

import 'dart:html';

void main() {
  World w = create_world();

  CanvasElement canvas = querySelector('#area');
  // make the canvas the full size of the window
  canvas.height = 1080;
  canvas.width = 1920;
  
  w.globaldata['canvas'] = canvas;

  load_assets_and_run(w);
}

// i kind of don't like this but whatever.
// there's definitely a cleaner way to do it, probably by having the loaders just return futures
// rather than being classes, and then doing wait on all the futures
void load_assets_and_run(World w) {
  load_images(w);
}
void load_images(World w) {
  w.globaldata['image_assets'] = new ImageLoader( ()=>(load_videos(w)), {'russfrank':'media/russfrank.png'});
}
void load_videos(World w) {
  w.globaldata['video_assets'] = new VideoLoader( ()=>(w.run()), {'hackru':'media/hackru_site.webm'});
}
