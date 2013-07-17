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

