//RYAN OLIVER
//ANGIE LIU

class Obstacle {

  // --- Position ---
  float x, y;

  PImage spike;

  Obstacle(float x, float y) {
    this.x = x;
    this.y = y;
    
    //placeholder
    spike = loadImage("spike.png");
  }

  void display() {
    image(spike, x, y, 200, 200);
  }
  
  boolean intersect(Player p) {
    float d = dist(x, y, p.x, p.y);
    if (d<130) {
      return true;
    } else {
      return false;
    }
  }

}
