part of hacksim;

class BoardRenderer extends Renderer {
  // i'm not sure if i want this class to hold the APIRenderer and APISlotRenderers and then call render entities on them or not
  // because it's using the render_entities method even though it's not actually rendering any entities.
  Board board;

  BoardRenderer(CanvasElement canv, CanvasRenderingContext2D ctx, Board bd) : super(canv, ctx) {
     board = bd;
  }

  void render_entities() {
    context.strokeStyle = 'rgba(0,0,0,1)';
    context.beginPath();
    context.moveTo(board.purchase_area.right, 0);
    context.lineTo(board.purchase_area.right, board.purchase_area.bottom);
    context.stroke();

    context.beginPath();
    context.moveTo(0, board.ui_area.top);
    context.lineTo(board.ui_area.right, board.ui_area.top);
    context.stroke();

    var ha = board.hack_area;
    context.drawImageScaled(board.background, ha.left, ha.top, ha.width, ha.height);
  }
}
