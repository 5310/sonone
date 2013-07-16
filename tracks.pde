class Tracks {

  boolean[][] keys; 
  float tempo;
  int position;

  Tracks() {
    
    keys = new boolean[16][16];
    for ( var i = 0; i < keys.length; i++ ) {
      for ( var j = 0; j < keys[0].length; j++ ) {
        keys[i][j] = false;
      }
    }
    
    tempo = 1/4;
    position = 0;
    wait = true;
    
  }
  
  void draw() {
    
    
    pushStyle();
    strokeWeight(4);
    stroke(color(0, 0, 1, 0.5));
    float y = ( position + 0.5 + map((frameCount-1)%floor(fps*tempo), 0, floor(fps*tempo), 0, 1) ) * 30;
    line( 0, y, width, y );
    popStyle();
    
    for ( var i = 0; i < keys.length; i++ ) {
      for ( var j = 0; j < keys[0].length; j++ ) {
        if (keys[i][j]) {
          pushStyle();
          if ( j == position ) {
            fill(1);
            stroke(color(0, 0, 1, 0.5));
          } else {
            fill(#222222); 
            stroke(color(0, 0, 0.2, 0.5));
          }
          strokeWeight(5);
          ellipse((i+0.5)*30, (j+0.5)*30, 15, 15);
          popStyle();
        }
      }
    }
    
    if ( frameCount%floor(fps*tempo) == 0 ) {
      position++;
      position%=keys[0].length;
      for ( var i = 0; i < keys.length; i++ ) {
        if ( keys[i][position] ) {
          viz.ping(i, position);
          notes.play(i);
        }
      }
    }
    
  }
  
  boolean getKey( float _x, float _y ) {
    int x = (int)map(_x, 0, width, 0, viz.canvas.width);
    int y = (int)map(_y, 0, height, 0, viz.canvas.height);
    return keys[x][y];
  }
  
  void setKey( float _x, float _y, boolean _value) {
    int x = (int)map(_x, 0, width, 0, viz.canvas.width);
    int y = (int)map(_y, 0, height, 0, viz.canvas.height);
    keys[x][y] = _value;
  }
  
}

