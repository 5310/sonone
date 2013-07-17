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

// Configuration constants.

int FPS = 60;
int TEMPO = 1/6;

int WIDTH = 16;
int HEIGHT = 16;
int SIZE = 30;

boolean RANDOMIZE = true;

String[] SAMPLES = {
  "4f.mp3", 
  "4g.mp3", 
  "4a.mp3", 
  "4b.mp3", 
  "5c.mp3", 
  "5d.mp3", 
  "5e.mp3", 
  "5f.mp3", 
  "5g.mp3", 
  "5a.mp3", 
  "5b.mp3", 
  "6c.mp3", 
  "6d.mp3", 
  "6e.mp3", 
  "6f.mp3", 
  "6g.mp3",
};

// Loads and plays the notes.

Maxim maxim = new Maxim(this);

class Notes {

  AudioPlayer[] notes;

  Notes() {
    // Load ALL the samples!
    notes = new AudioPlayer[SAMPLES.length];
    for ( int i = 0; i < SAMPLES.length; i++ ) {
       notes[i] = maxim.loadFile(SAMPLES[i]); 
    }
  }

  void play( int _index ) {
    // In order to replay a note it has to be stopped, rewound, and then played again.
    notes[_index].stop();
    notes[_index].cue(0);
    notes[_index].play();
  }
}

// Visualizes the individual notes playing on the viz surface.

class Ping {

  float x, y; // Center of the ping.

  color c; // Color of the ping.
  float a, aDecay; // Alpha of the ping's color, and decay rate.

  float radius, radiusGrowth; // Radius of the ping's circle, and growth rate.

  boolean alive; // Signifies whether the ping is still visible.

  Ping( float _x, float _y, color _c ) {

    x = _x;
    y = _y;

    c = _c;
    a = 0.25;
    aDecay = 0.95;

    radius = 0.5;
    radiusGrowth = 0.1;

    alive = true;
  }

  void draw( PGraphics _canvas ) {

    // Draw the ping if alive.
    if (alive) {
      _canvas.beginDraw();
      _canvas.fill(color(hue(c), saturation(c), brightness(c), a));
      _canvas.ellipse(x, y, radius*2, radius*2);
      _canvas.endDraw();
    }

    // Decay the alpha, as well as set alive to false if it's invisible.
    a *= aDecay;
    if ( a <= 0.001 ) {
      alive = false;
    }

    // Grow the ping.
    radius += radiusGrowth;
  }
}

// The loop tracker.

class Tracks {

  boolean[][] keys; // An array of all the keys on the tracker.
  float tempo; // Locally stores the tempo of the tracker rows.
  int position; // Active row of the tracker.

  Tracks() {

    keys = new boolean[WIDTH][HEIGHT];
    for ( var i = 0; i < keys.length; i++ ) {
      for ( var j = 0; j < keys[0].length; j++ ) {
        keys[i][j] = false;
      }
    }

    tempo = TEMPO;
    position = 0;
    wait = true;
  }

  void draw() {

    // First, get size of the keys dynamically. 
    float keyWidth = width/WIDTH;
    float keyHeight = height/HEIGHT;

    // A value that interpolates the time between two discrete rows.
    float lerp = map((frameCount-1)%floor(FPS*tempo), 0, floor(FPS*tempo), 0, 1);

    // Draw the tracker position line.
    pushStyle();
    strokeWeight(SIZE/8);
    stroke(color(0, 0, 1, 0.5));
    float y = ( position + 0.5 + lerp ) * keyHeight;
    line( 0, y, width, y );
    popStyle();

    // Draw all keys on the pattern.
    for ( var i = 0; i < keys.length; i++ ) {
      for ( var j = 0; j < keys[0].length; j++ ) {
        if (keys[i][j]) {
          pushStyle();
          if ( j == position ) { // An active key will glow.
            fill(1);
            stroke(color(0, 0, 1, 0.5));
          } 
          else { // An inactive one will be dark.
            fill(#222222); 
            stroke(color(0, 0, 0.2, 0.5));
          }
          strokeWeight(SIZE/6);
          ellipse((i+0.5)*keyWidth, (j+0.5)*keyHeight, keyWidth/2, keyHeight/2);
          popStyle();
        }
      }
    }

    // Increment the active row of the pattern according to tempo.
    if ( frameCount%floor(FPS*tempo) == 0 ) {
      position++;
      position%=keys[0].length;
      for ( var i = 0; i < keys.length; i++ ) {
        if ( keys[i][position] ) { // Play note and create ping for each active key.
          viz.ping(i, position);
          notes.play(i);
        }
      }
    }
  }

  // Returns a specific key on the pattern given a screen coordinate. 
  boolean getKey( float _x, float _y ) {
    int x = (int)map(_x, 0, width, 0, viz.canvas.width);
    int y = (int)map(_y, 0, height, 0, viz.canvas.height);
    return keys[x][y];
  }

  // Sets a key on a specific location on the pattern given a screen coordinate.
  void setKey( float _x, float _y, boolean _value) {
    int x = (int)map(_x, 0, width, 0, viz.canvas.width);
    int y = (int)map(_y, 0, height, 0, viz.canvas.height);
    keys[x][y] = _value;
  }
}

// The visualization surface.

class Viz {

  PGraphics canvas; // A canvas to draw the pings to.
  color background; // Color of the background to fade to.
  
  ArrayList<Ping> pings; // A list of pings being visualized.

  Viz( color _background ) {

    canvas = createGraphics(WIDTH, HEIGHT);
    background = _background;
        
    pings = new ArrayList<Ping>();
    
  }

  void draw() {
    
    // Draw all the pings to the canvas.
    // Remove ping if it's invisible.
    for ( int i = 0; i < pings.size(); i++ ) {
      Ping ping = pings.get(i);
      ping.draw(canvas);
      if (!ping.alive) {
        pings.remove(i);
      }
    }

    // Face the canvas to background color and smoother it.
    canvas.beginDraw();
    canvas.noStroke();
    canvas.fill(background);
    canvas.rect(0, 0, canvas.width, canvas.height);
    canvas.endDraw();
    canvas.filter(BLUR, 0.75);

    // Draw the canvas to screen.
    image(canvas, 0, 0, width, height);
  }

  // Create a ping on specific location on the viz.
  void ping( int _x, int _y ) {
    // Get color from location, too.
    color c = color(map(_x, 0, canvas.width, 0, 1), 0.75, 1);
    pings.add(new Ping( _x+0.5, _y+0.5, c));
  }
  
}


