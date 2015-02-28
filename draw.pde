import java.util.Map;

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
  int xyGraphSize = 350;
  int marginSize = 40;
  // background
  fill(200);
  rect(marginSize, marginSize, xyGraphSize, xyGraphSize);
  // labels
  fill(0);
  text("x Position", xyGraphSize / 2 + marginSize, xyGraphSize + marginSize * 3/2 + 5);
  rotate(-PI / 2);
  text("y Position", -xyGraphSize / 2 - marginSize, marginSize / 2);
  rotate(PI / 2);
  textSize(15);
  text("Position of Fires", xyGraphSize / 2 + marginSize, marginSize / 2);
  textSize(12);
  for (int i = 0; i <= 10; i++) {
    text(i, marginSize + xyGraphSize / 10 * i, marginSize + xyGraphSize + 10);
    text(i, marginSize - 5, marginSize + xyGraphSize / 10 * (10 - i) + 5);
  }
  // points
  stroke(0);
  strokeWeight(5);
  for (int i = 0; i < xValues.size(); i++) {
    float x = map(xValues.get(i), 0, 10, marginSize, marginSize + xyGraphSize);
    float y = map(yValues.get(i), 0, 10, marginSize + xyGraphSize, marginSize);
    point(x, y);
  }
  strokeWeight(0);
  
  // Draw a bar chart of fire months
  int monthGraphSize = 350;
  // background
  fill(200);
  rect(marginSize, marginSize * 3 + xyGraphSize, monthGraphSize, monthGraphSize);
  // labels
  fill(0);
  text("Month", monthGraphSize / 2 + marginSize, xyGraphSize + marginSize * 7/2 + monthGraphSize + 5);
  rotate(-PI / 2);
  text("Number of Fires", -xyGraphSize - monthGraphSize / 2 - marginSize * 3, marginSize / 2);
  rotate(PI / 2);
  textSize(15);
  text("Fires by Month", monthGraphSize / 2 + marginSize, marginSize / 2 + xyGraphSize + marginSize * 2);
  textSize(12);
  // y axis
  for (int i = 0; i <= 10; i++) {
    text(i * 25, marginSize - 5, marginSize * 3 + xyGraphSize + monthGraphSize / 10 * (10 - i) + 5);
  }
  // draw things for each month
  float y = xyGraphSize + marginSize * 3 + monthGraphSize;
  float x = marginSize;
  for (String m : months) {
    // label
    fill(0);
    strokeWeight(0);
    text(m, x + 12, y + 10);
    // rectangle
    Integer i = fireMonths.get(m);
    float h = map(i == null ? 0 : i, 0, 250, 0, monthGraphSize);
    fill(#FF0000);
    strokeWeight(1);
    rect(x, y, monthGraphSize / 12, -h);
    x += monthGraphSize / 12;
  }
}
