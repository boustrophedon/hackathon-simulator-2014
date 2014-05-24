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
    render_entities();
  }

  void process_entity(Entity e) {}

}
