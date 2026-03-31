//ANGIE LIU
//GRACE PERRY

class Player {
  float x, y, speed, gravity, yVelocity, groundY, jumpStrength;
  int stamina;
  int maxStamina = 150;
  int health;
  int maxHealth = 100;

  boolean isMovingLeft, isMovingRight, isGrounded;
  PImage test;

  Player(float x, float y, float speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    gravity = 0.6;
    yVelocity = 0;
    groundY = 650;
    jumpStrength = -21;
    isMovingLeft = false;
    isMovingRight = false;
    isGrounded = true;
    
    //placeholder
    test = loadImage("testCharacter.png");
    stamina = 150;
    health = 100;
  }

  void display() {
    image(test, x, y);
    test.resize(200, 200);
    
    drawStaminaBar();
    drawHealthBar();
    update();
    move();
  }

  void update() {
    yVelocity += gravity;
    y += yVelocity;
    if (y >= groundY) {
      y = groundY;
      yVelocity = 0;
      isGrounded = true;
    }
  }

  void move() {
    // Drain stamina when moving
    if (isMovingLeft || isMovingRight) {
      if (stamina > 0) stamina -= 0.1;
    }

    // Only move if there is stamina left
    if (isMovingLeft && stamina > 0) x -= speed;
    if (isMovingRight && stamina > 0) x += speed;
  }

  void drawStaminaBar() {
    fill(50);
    rect(x + 75, y - 20, maxStamina, 10);
    fill(#19ecff);
    rect(x + 75 , y - 20, stamina, 10);    
  }

  //health bar
  void drawHealthBar() {
    fill(50);
    rect(x + 50, y - 40, maxHealth, 10);
    fill(255, 0, 0);
    rect(x + 50, y - 40, health, 10);
  }

  void jump() {
    if (isGrounded && stamina > 0) {
      stamina -= 10;
      yVelocity = jumpStrength;
      isGrounded = false;
    }
  }
}
