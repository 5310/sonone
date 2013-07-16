int FPS = 60;
int TEMPO = 1/6;
int WIDTH = 16;
int HEIGHT = 16;

Notes notes;
Viz viz;
Tracks tracks;

boolean add;

void setup() {

  size(480, 480);
  colorMode(HSB, 1.0); 
  background(color(0, 0, 0.9));
  frameRate(FPS);
  //noSmooth();

  notes = new Notes();
  viz = new Viz(color(0, 0, 0.88, 0.05));
  tracks = new Tracks();
  
  for ( int k = 0; k < 20; k++ ) {
    //tracks.keys[floor(random(0, tracks.keys.length))][floor(random(0, tracks.keys[0].length))] = true;
  }
}

void draw() {
  viz.draw();
  tracks.draw();
}

void mousePressed() {
  if ( tracks.getKey( mouseX, mouseY ) ) {
    add = false;
  } else {
    add = true;
  }
}

void mouseDragged() {
  if ( add ) {
    tracks.setKey(mouseX, mouseY, true);
  } else {
    tracks.setKey(mouseX, mouseY, false);
  }
}

void mouseReleased() {
  if ( add ) {
    tracks.setKey(mouseX, mouseY, true);
  } else {
    tracks.setKey(mouseX, mouseY, false);
  }
  /*viz.ping( 
  (int)map(mouseX, 0, width, 0, viz.canvas.width), 
  (int)map(mouseY, 0, height, 0, viz.canvas.height)
    );*/
}

