part of hacksim;

class RecruiterSystem extends System {
  RecruiterSystem(World world) : super(world) {
    components_wanted = new Set.from([Recruiter,]);
  }

  void initialize() {}

  void process_entity() {}
}
