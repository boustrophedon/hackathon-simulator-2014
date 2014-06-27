part of hacksim;

void pivot_animation(Entity e, num dt) {
  var ui = e.get_component(UI);
  ui.font_size =  (ui.font_size+(dt/10)).toInt();
}
