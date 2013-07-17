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

