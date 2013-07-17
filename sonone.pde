// Main script.

Notes notes; // Plays all the notes.
Viz viz; // Visualizes all the notes.
Tracks tracks; // Tracks the loop's pattern.

boolean add; // A state for whether to add or remove keys.

void setup() {

  // Set-up sketch.
  size(WIDTH*SIZE, HEIGHT*SIZE);
  center(); // Centers the sketch on the page.
  colorMode(HSB, 1.0); 
  background(color(0, 0, 0.9));
  frameRate(FPS);
  //noSmooth();

  // Initialize the objects.
  notes = new Notes();
  viz = new Viz(color(0, 0, 0.88, 0.05));
  tracks = new Tracks();
  
  // Randomize a pattern.
  if ( RANDOMIZE ) {
    for ( int k = 20; k > 0; k-- ) {
      tracks.setKey( floor(random(0, width)), floor(random(0, height)), true);
    }
  }
  
}

void draw() {
  viz.draw();
  tracks.draw();
}

void mousePressed() {
  // Checks to see if the mouse is pressed over an empty or set key in order to set add/remove state.
  if ( tracks.getKey( mouseX, mouseY ) ) {
    add = false;
  } 
  else {
    add = true;
  }
}

void mouseDragged() {
  // Draws or erases keys on drag.
  if ( add ) {
    tracks.setKey(mouseX, mouseY, true);
  } 
  else {
    tracks.setKey(mouseX, mouseY, false);
  }
}

void mouseReleased() {
  // Adds or removes key on click.
  if ( add ) {
    tracks.setKey(mouseX, mouseY, true);
  } 
  else {
    tracks.setKey(mouseX, mouseY, false);
  }
}
