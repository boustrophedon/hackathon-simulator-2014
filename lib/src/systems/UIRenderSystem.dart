part of hacksim;

class UIRenderSystem extends RenderSystem {

  UIRenderSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,UI]);
  }

  void initialize() {
    set_context(world.globaldata['canvas']);

    renderers['ui button'] = new UIButtonRenderer(canvas, context);
    renderers['ui label'] = new UILabelRenderer(canvas, context);
  }

  void process() {
    // no clearRect
    for (Entity e in entities) {
      process_entity(e);
    }
    render_entities();
  }

  void process_entity(Entity e) {
    if (e.get_component(Kind).kind == 'ui label') {
      update_label(e);
    }
  }

  void update_label(Entity e) {
    UILabel label = e.get_component(UILabel);

    int i = 0;
    for (String s in label.update()) {
      label.rendered_text = label.text.replaceAll("{$i}", s);
      i++;
    }
  }

}
