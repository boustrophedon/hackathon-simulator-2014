part of hacksim;

class APISlotSystem extends System {
  
  List<List<int>> colorpool;
  math.Random rng;

  APISlotSystem(World world) : super(world) {
    components_wanted = new Set.from([APISlot,]);
  }
  
  void initialize() {}

  void process_entity(Entity e) {}
}
