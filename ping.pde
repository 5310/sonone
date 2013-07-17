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

