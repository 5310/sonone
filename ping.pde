class Ping {
  
  float x, y;
  
  color c;
  float a, aDecay;
  
  float radius, radiusGrowth;
  
  boolean alive;

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

    if (alive) {
      _canvas.beginDraw();
      _canvas.fill(color(hue(c), saturation(c), brightness(c), a));
      _canvas.ellipse(x, y, radius*2, radius*2);
      _canvas.endDraw();
    }

    a *= aDecay;
    if ( a <= 0.001 ) {
      alive = false;
    }

    radius += radiusGrowth;
  }
}

