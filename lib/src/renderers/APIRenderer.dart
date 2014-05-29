part of hacksim;

class APIRenderer extends Renderer {
  APIRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx);

  void render_entity(Entity e) {
    Position pos = e.get_component(Position);
    Size size = e.get_component(Size);
    API api = e.get_component(API);

    context.fillStyle = 'rgb(${api.color_string})';
    context.fillRect(pos.x, pos.y, size.width, size.height);

    // this is a hack but whatever
    // i guess i could create like a uilabel but i didn't really design them to be mobile
    int xoffset = (context.measureText("${api.name}").width)~/2;
    int yoffset = 10; // hardcoded and bad
    context.fillStyle = 'black';
    context.fillText("${api.name}", pos.x+(size.width~/2)-xoffset, pos.y+size.height+yoffset);
  }
} 
