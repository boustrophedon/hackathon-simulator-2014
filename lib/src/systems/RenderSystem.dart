part of hacksim;

class RenderSystem extends System {

  CanvasRenderingContext2D context;

  RenderSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,]);
  }

  void initialize() {
    context = world.globaldata['canvas'].context2D;
  }

  void process_entity(Entity entity) {

  }
}

