part of hacksim;

class BoardRenderSystem extends RenderSystem {
  BoardRenderSystem(World world) : super(world) {
    components_wanted = new Set.from([Board,]);
  }

  void initialize() {
    set_context(world.globaldata['canvas']);
    renderers['board'] = new BoardRenderer(canvas, context);
  }

  void process() {
    context.clearRect(0, 0, screen_width, screen_height);
    render_entities();
  }

  void process_new_entity(Entity e) {
    // there really should only be one board entity so.
    renderers['board'].add_entity(e);
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}
