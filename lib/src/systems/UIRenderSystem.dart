part of hacksim;

class UIRenderSystem extends RenderSystem {

  UIRenderSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,UI]);
  }

  void initialize() {
    set_context(world.globaldata['canvas']);

    renderers['ui button'] = new UIButtonRenderer(canvas, context);
    renderers['ui label'] = new UILabelRenderer(canvas, context);
    renderers['ui progressbar'] = new UIProgressBarRenderer(canvas, context);
    renderers['recruiter popup'] = new UIPopupRenderer(canvas, context);
    renderers['popup button'] = new UIButtonRenderer(canvas, context);
  }

  void process() {
    // no clearRect
    for (Entity e in entities) {
      process_entity(e);
    }
    render_entities();
  }

  void process_entity(Entity e) {
    Kind kind = e.get_component(Kind);
    if (kind.kind == 'ui label') {
      update_label(e);
    }
    else if (kind.kind == 'ui progressbar') {
      update_bar(e);
    }
  }

  void update_label(Entity e) {
    UILabel label = e.get_component(UILabel);

    if (label.update == null) {
      label.rendered_text = label.text;
    }
    else {
      int i = 0;
      for (String s in label.update()) {
        label.rendered_text = label.text.replaceAll("{$i}", s);
        i++;
      }
    }
  }

  void update_bar(Entity e) {
    UIProgressBar bar = e.get_component(UIProgressBar);

    bar.progress = bar.update();
  }
}
