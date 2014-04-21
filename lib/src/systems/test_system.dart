part of hacksim;

class TestSystem extends System {
  TestSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,]);

    Position pos = new Position(1,2);
    Entity e = world.new_entity();
    e.add_component(pos);
    e.add_to_world();

    world.subscribe_event('TestEvent', test_callback);
    world.subscribe_event('TestEvent2', test_callback);
    world.send_event('TestEvent2', {'test_attr': 'maaaaaaaaaaaaaaa'});
  }

  void test_callback(Map event) {
    print(event['test_attr']);
    print(event['EVENT_TYPE']);
  }

  void process_entity(Entity entity) {
    world.send_event('TestEvent', {'test_attr': 'this is a test'});
    world.send_event('TestEvent2', {'test_attr': 'this is a test'});
  }
}
