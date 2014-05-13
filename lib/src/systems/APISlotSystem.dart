part of hacksim;

class APISlotSystem extends System {
  
  APISlotSystem(World world) : super(world) {
    components_wanted = new Set.from([APISlot,]);
  }

  void initialize() {}

  void process_entity(Entity e) {}
