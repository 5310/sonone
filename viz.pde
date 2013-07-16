class Viz {

  PGraphics canvas;
  color background;
  
  ArrayList<Ping> pings;

  Viz( color _background ) {

    canvas = createGraphics(16, 16);
    background = _background;
        
    pings = new ArrayList<Ping>();
    
  }

  void draw() {
    
    for ( int i = 0; i < pings.size(); i++ ) {
      Ping ping = pings.get(i);
      ping.draw(canvas);
      if (!ping.alive) {
        pings.remove(i);
      }
    }

    canvas.beginDraw();
    canvas.noStroke();
    canvas.fill(background);
    canvas.rect(0, 0, canvas.width, canvas.height);
    canvas.endDraw();
    canvas.filter(BLUR, 0.75);

    image(canvas, 0, 0, width, height);
  }

  void ping( int _x, int _y ) {
    color c = color(map(_x, 0, canvas.width, 0, 1), 0.75, 1);
    pings.add(new Ping( _x+0.5, _y+0.5, c));
  }
  
}

