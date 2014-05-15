part of hacksim;

class BoardRenderer extends Renderer {
  // i'm not sure if i want this class to hold the APIRenderer and APISlotRenderers and then call render entities on them or not
  // because it's using the render_entities method even though it's not actually rendering any entities.
  Board board;

  BoardRenderer(CanvasElement canv, CanvasRenderingContext2D ctx, Board bd) : super(canv, ctx) {
     board = bd;
  }

  void render_entities() {
    context.strokeStyle = 'rgb(0,0,0)';
    context.beginPath();
    context.moveTo(board.purchase_area.right, 0);
    context.lineTo(board.purchase_area.right, board.purchase_area.bottom);
    context.stroke();

    context.beginPath();
    context.moveTo(0, board.ui_area.top);
    context.lineTo(board.ui_area.right, board.ui_area.top);
    context.stroke();

    //context.fillRect(board.purchase_area.left, board.purchase_area.top, board.purchase_area.width, board.purchase_area.height);
    //context.fillRect(board.hack_area.left, board.hack_area.top, board.hack_area.width, board.hack_area.height);
    //context.fillRect(board.ui_area.left, board.ui_area.top, board.ui_area.width, board.ui_area.height);
  }
}
