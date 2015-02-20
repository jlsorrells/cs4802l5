int canvasWidth = MIN_INT; // this would be initialized in setup

void draw() {
  clearCanvas();

  /**
   ** Finish this:
   **
   **  Based on the variables you populate from the ResultSet in eventsHandler, 
   **  you should draw your visualization here. There is a white rectangle already 
   **  drawn in clearCanvas() at rect(0, 0, canvasWidth,canvasWidth) (CORNER)
   **/
   
  // Draw the scatter plot
  int plotSize = 300;
  int marginSize = 20;
  // background
  fill(200);
  rect(marginSize, marginSize, plotSize, plotSize);
  // labels
  fill(0);
  text("x position", plotSize / 2 + marginSize, plotSize + marginSize * 2);
  rotate(-PI / 2);
  text("y position", -plotSize / 2 - marginSize, marginSize / 2);
  rotate(PI / 2);
  text("Position of fires", plotSize / 2 + marginSize, marginSize / 2);
  // points
  stroke(0);
  strokeWeight(5);
  for (int i = 0; i < xValues.size(); i++) {
    float x = map(xValues.get(i), 0, 10, 0, plotSize);
    float y = map(yValues.get(i), 0, 10, plotSize, 0);
    point(x, y);
  }
}
