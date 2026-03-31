// ANGIE LIU

class PowerUp {
  PImage powerImage;
  int infStaminaTimer, speedUpTimer, x, y;
  String type;
  boolean collide;

  PowerUp(int x, int y, String type) {
    if (type == "InfiniteStamina") {
      powerImage = loadImage("timer.jpeg");
    } else if (type == "SpeedUp") {
      powerImage = loadImage("none.png");
    } else if (type == "StaminaOrb") {
      powerImage = loadImage("stamina.png");
    }
    this.x = x;
    this.y = y;
    this.type = type;
  }

  void display() {
    //placeholder
    image(powerImage, x, y, 50, 50);

  }
  
  boolean intersect(Player p) {
    float d = dist(x, y, p.x, p.y);
    if (d<120) {
      return true;
    } else {
      return false;
    }
  }
}
