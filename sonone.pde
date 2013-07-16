Notes notes;
Viz viz;

void setup() {

  size(480, 480);
  colorMode(HSB, 1.0); 
  background(color(0, 0, 0.9));
  frameRate(60);
  //noSmooth();

  notes = new Notes();
  viz = new Viz(color(0, 0, 0.88, 0.05));
}

void draw() {
  viz.draw();
  notes.draw();
}

void mousePressed() {
}

void mouseDragged() {
}

void mouseReleased() {
  viz.ping( 
  (int)map(mouseX, 0, width, 0, viz.canvas.width), 
  (int)map(mouseY, 0, height, 0, viz.canvas.height), 
  color(map(mouseX, 0, width, 0, 1), 0.75, 1)
    );
}

