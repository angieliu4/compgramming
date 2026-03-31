// EVERYONE
//recent changes: added fully functioning UI (pause menu, gameover screen, restart button, button to exit program, tutorial, controls), score system, obstacle collision, biome randomization
//working on: gravity simulation, music, background aesthetics

//LAG IS FIXED HOPEFULLY

//ANGIE LIU

// Set up the images, buttons, fonts, screen sizes

//images
PImage titleScreen, backGalcan, layOneGalcan, layTwoGalcan, layThreeGalcan, floorGalcan, backLostAbyss, layOneLostAbyss, layTwoLostAbyss, layThreeLostAbyss, floorLostAbyss;

//font
PFont PixelFont;

//music |Grace
//THE SOUND LIBRARY WASNT WORKINGGGGGGGGGGG*
//import processing.sound.*;
//SoundFile spaceLvl;

//screens
char screen = 'S'; //S = start screen, M = modes, I = endless mode, O = options/settings screen, C = credits screen, E = game over, P = pause, T = tuorial

//buttons
Button btnPlay, btnInfiniteMode, btnSpeedRunMode, btnSettings, btnBack, btnCredits, btnMainMenu, btnRestart, btnResume, btnQuit, btnTutorial, btnGalcanBiome, btnAbyssBiome, btnRandomBiome;

//powerups
PowerUp staminaOrb;

//player
Player player;

//obstacle
Obstacle obstacle;

//global variables
float lay1speed = 0;
float lay2speed = 0;
float lay3speed = 0;
float floorspeed = 0;
boolean gameOver = false;
boolean isPaused = false;
boolean setBiome = false;
int score;
int highScore;
int randBiome;
String currentBiome = "random";
Obstacle[] spikes = new Obstacle[3];

void setup () {
  size(1600, 900);

  //to make sure it doesn't lag on different types of computers
  pixelDensity(1);

  //music*
  //spaceLvl.play();

  frameRate(90);

  //font setup
  PixelFont = createFont("PixelFont.ttf", 32);
  textFont(PixelFont);

  //image setup
  titleScreen = loadImage("titleScreen.png");
  backGalcan = loadImage("GalacticCanyonBackground.png");
  layOneGalcan = loadImage("GalacticCanyonLayer1.png");
  layTwoGalcan = loadImage("GalacticCanyonLayer2.png");
  layThreeGalcan = loadImage("GalacticCanyonLayer3.png");
  floorGalcan = loadImage("GalacticCanyonFloor.png");
  backLostAbyss = loadImage("LostAbyssBackground.png");
  layOneLostAbyss = loadImage("LostAbyssLayer1.png");
  layTwoLostAbyss = loadImage("LostAbyssLayer2.png");
  layThreeLostAbyss = loadImage("LostAbyssLayer3.png");
  floorLostAbyss = loadImage("LostAbyssFloor.png");


  //button setup, parameters in order are text, x position, y position, width, height, normal color, hovering color, text size
  btnPlay = new Button("Play", 800, 400, 400, 100, #ff9538, #ffd1a8, 150);
  btnSettings = new Button("Settings", 800, 600, 300, 75, #ff9538, #ffd1a8, 85);
  btnBack = new Button("Back", 125, 75, 150, 75, #ff9538, #ffd1a8, 75);
  btnCredits = new Button("Credits", 1450, 825, 225, 75, #ff9538, #ffd1a8, 75);
  btnMainMenu = new Button ("Main Menu", 800, 800, 275, 75, #ff9538, #ffd1a8, 50);
  btnRestart = new Button ("Restart", 800, 650, 350, 100, #ff9538, #ffd1a8, 100);
  btnResume = new Button ("Resume", 800, 500, 300, 100, #ff9538, #ffd1a8, 100);
  btnQuit = new Button ("Quit", 150, 825, 200, 75, #ff9538, #ffd1a8, 75);
  btnTutorial = new Button ("Tutorial", 800, 725, 250, 75, #ff9538, #ffd1a8, 75);
  btnGalcanBiome = new Button ("Galatic Canyon", 350, 700, 450, 100, #983dcc, #ad86c4, 75);
  btnAbyssBiome = new Button ("Lost Abyss", 800, 700, 350, 100, #2c2e9e, #5a5b96, 75);
  btnRandomBiome = new Button ("Random", 1250, 700, 250, 100, #ff9538, #ffd1a8, 75);

  //power up set up
  staminaOrb = new PowerUp(1700, (int)random(300, 500), "StaminaOrb");

  //player set up
  player = new Player(400, 700, 10);

  //obstacle set up
  for (int i = 0; i < spikes.length; i++) {
    spikes[0] = new Obstacle(1800, 600);
    spikes[1] = new Obstacle(800, 600);
    spikes[2] = new Obstacle(100, 600);
  }
}

void draw() {
  //how we're switching the screens
  switch(screen) {
  case 'S':
    startScreen();
    break;
  case 'O':
    settingsScreen();
    break;
  case 'I':
    gameScreen();
    break;
  case 'C':
    creditsScreen();
    break;
  case 'P':
    pauseScreen();
    break;
  case 'E':
    gameOver();
    break;
  case 'T':
    tutorialScreen();
    break;
  }
}

//methods for each screen
void startScreen () {
  image(titleScreen, 0, 0);

  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(150);
  text("Untitled Runner Game", 800, 100);
  textSize(50);
  text("(Yes That's the Name)", 800, 200);
  textSize(100);

  btnPlay.display();
  btnSettings.display();
  btnCredits.display();
  btnQuit.display();
  btnTutorial.display();
}

//methods for the actual game
void gameScreen() {

  //only runs if the player is alive or is unpaused
  if (gameOver == false && isPaused == false) {
    //music*
    //spaceLvl.play();

    //biome randomization
    if (randBiome == 1) {
      image(backGalcan, 0, 0);
      image(layOneGalcan, lay1speed, 0);
      image(layOneGalcan, lay1speed + layOneGalcan.width, 0);
      image(layTwoGalcan, lay2speed, 0);
      image(layTwoGalcan, lay2speed + layTwoGalcan.width, 0);
      image(layThreeGalcan, lay3speed, 0);
      image(layThreeGalcan, lay3speed + layThreeGalcan.width, 0);
      image(floorGalcan, floorspeed, 0);
      image(floorGalcan, floorspeed + floorGalcan.width, 0);
      floorGalcan.resize(1600, 900);

      //ITS NOT LAGGY ANYMORE YAYAYAY!!!
      lay1speed -= 1;
      lay2speed -= 2;
      lay3speed -= 3;
      floorspeed -= 6;
      if (lay1speed <= -layOneGalcan.width) {
        lay1speed = 0;
      }
      if (lay2speed <= -layOneGalcan.width) {
        lay2speed = 0;
      }
      if (lay3speed <= -layOneGalcan.width) {
        lay3speed = 0;
      }
      if (floorspeed <= -layOneGalcan.width) {
        floorspeed = 0;
      }
    } else if (randBiome == 2) {
      image(backLostAbyss, 0, 0);
      image(layOneLostAbyss, lay1speed, 0);
      image(layOneLostAbyss, lay1speed + layOneLostAbyss.width, 0);
      image(layTwoLostAbyss, lay2speed, 0);
      image(layTwoLostAbyss, lay2speed + layTwoLostAbyss.width, 0);
      image(layThreeLostAbyss, lay3speed, 0);
      image(layThreeLostAbyss, lay3speed + layThreeLostAbyss.width, 0);
      image(floorLostAbyss, floorspeed, 0);
      image(floorLostAbyss, floorspeed + floorLostAbyss.width, 0);

      //ITS NOT LAGGY ANYMORE YAYAYAY!!!
      lay1speed -= 1;
      lay2speed -= 2;
      lay3speed -= 3;
      floorspeed -= 6;
      if (lay1speed <= -layOneGalcan.width) {
        lay1speed = 0;
      }
      if (lay2speed <= -layOneGalcan.width) {
        lay2speed = 0;
      }
      if (lay3speed <= -layOneGalcan.width) {
        lay3speed = 0;
      }
      if (floorspeed <= -layOneGalcan.width) {
        floorspeed = 0;
      }
    }

    staminaOrb.display();
    for (int i = 0; i < spikes.length; i++) {
      spikes[i].display();
    }
    player.display();

    //movement for stamina orbs and obstacles
    staminaOrb.x -= 6;
    for (int i = 0; i < spikes.length; i++) {
      spikes[i].x -= 6;
    }


    //stamina and obstacle collision detection
    if (staminaOrb.intersect(player)) {
      player.stamina += 50;


      if (player.stamina > player.maxStamina) {
        player.stamina = player.maxStamina;
      }

      staminaOrb.x = 1700;
      staminaOrb.y = (int)random(300, 550);
    }

    for (int i = 0; i < spikes.length; i++) {
      if (spikes[i].intersect(player)) {
        player.health -= 100;
      }
    }



    if (staminaOrb.x < -100) {
      staminaOrb.x = 1700;
      staminaOrb.y = (int)random(300, 550);
    }
    for (int i = 0; i < spikes.length; i++) {
      if (spikes[i].x < -200) {
        spikes[i].x = 1800;
      }
    }

    //score
    score += 5;
    if (score >= highScore) {
      highScore = score;
    }
    fill(255);
    textSize(75);
    text("Score: " + score, 200, 75);
    text("High Score: " + highScore, 270, 150);
  }

  //gameover condition
  if (player.stamina == 0 || player.health == 0) {
    screen = 'E';
    gameOver = true;
  }
}



void settingsScreen() {
  image(titleScreen, 0, 0);

  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(150);
  text("Settings", 800, 100);
  textSize(50);
  text("A OR LEFT ARROW - Move left", 800, 200);
  text("D OR RIGHT ARROW - Move Right", 800, 250);
  text("SPACE - Jump", 800, 300);
  text("TAB - Pause", 800, 350);

  textSize(80);
  text("Biome", 800, 550);

  textSize(60);
  text("Biome is currently " + currentBiome + ".", 800, 825);

  btnBack.display();
  btnGalcanBiome.display();
  btnAbyssBiome.display();
  btnRandomBiome.display();
}

void creditsScreen() {
  image(titleScreen, 0, 0);

  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(150);
  text("Credits", 800, 100);

  textSize(60);
  text("Angie Liu", 800, 250);
  text("Ryan Oliver", 800, 450);
  text("Grace Perry", 800, 650);

  textSize(35);
  text("Lead Programmer, UI Designer", 800, 300);
  text("Lead Artist, Assistant Programmer", 800, 500);
  text("Lead Sound Designer, Assistant Programmer", 800, 700);

  btnBack.display();
}

void gameOver() {
  if (randBiome == 1) {
    image(backGalcan, 0, 0);
  } else if (randBiome == 2) {
    image(backLostAbyss, 0, 0);
  }

  fill(255);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(150);
  text("Game Over!", 800, 100);
  textSize(30);
  text("Avoid the obstacles while watching your stamina carefully...", 800, 150);

  textSize(75);
  text("Score: " + score, 800, 250);
  text("High Score: " + highScore, 800, 350);

  btnMainMenu.display();
  btnRestart.display();
}

void pauseScreen() {
  if (randBiome == 1) {
    image(backGalcan, 0, 0);
  } else if (randBiome == 2) {
    image(backLostAbyss, 0, 0);
  }


  fill(255);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(150);
  text("Paused", 800, 100);

  textSize(75);
  text("Current Score: " + score, 800, 250);
  text("Current High Score: " + highScore, 800, 350);

  btnResume.display();
  btnRestart.display();
  btnMainMenu.display();
}

void tutorialScreen() {
  image(titleScreen, 0, 0);

  fill(255);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(150);
  text("Tutorial", 800, 100);
  textSize(50);
  text("Stamina will drain when you move, collect blue stamina orbs to regen.", 800, 250);
  text("Avoid the obstacles, they're deadly!", 800, 400);
  text("Jump over the gaps in the terrain to avoid falling into the void.", 800, 550);
  textSize(70);
  text("The game is endless, try to go for as long as you can!", 800, 750);

  btnBack.display();
}

//makes the buttons functional
void mousePressed() {
  switch(screen) {
  case 'S':
    if (btnPlay.clicked()) {
      gameOver = false;
      isPaused = false;
      player.stamina = 150;
      player.health = 100;
      staminaOrb.x = 1700;
      staminaOrb.y = (int)random(300, 550);
      for (int i = 0; i < spikes.length; i++) {
        spikes[0] = new Obstacle(1800, 600);
        spikes[1] = new Obstacle(900, 600);
        spikes[2] = new Obstacle(300, 600);
      }
      player.x = 400;
      player.y = 100;
      score = 0;
      if (setBiome == false) {
        randBiome = (int)random(1, 3);
      }
      screen = 'I';
      break;
    } else if (btnSettings.clicked()) {
      screen = 'O';
      break;
    } else if (btnCredits.clicked()) {
      screen = 'C';
      break;
    } else if (btnQuit.clicked()) {
      exit();
    } else if (btnTutorial.clicked()) {
      screen = 'T';
      break;
    }
  case 'O':
    if (btnBack.clicked()) {
      screen = 'S';
      break;
    } else if (btnGalcanBiome.clicked()) {
      setBiome = true;
      randBiome = 1;
      if (setBiome == true) {
        currentBiome = "Galatic Canyon";
      }
      break;
    } else if (btnAbyssBiome.clicked()) {
      setBiome = true;
      randBiome = 2;
      if (setBiome == true) {
        currentBiome = "Lost Abyss";
      }
      break;
    } else if (btnRandomBiome.clicked()) {
      setBiome = false;
      currentBiome = "random";
      break;
    }
  case 'C':
    if (btnBack.clicked()) {
      screen = 'S';
      break;
    }
  case 'I':
    if (btnMainMenu.clicked()) {

      screen = 'S';
      break;
    }
  case 'E':
    if (btnRestart.clicked()) {
      gameOver = false;
      player.stamina = 150;
      player.health = 100;
      staminaOrb.x = 1700;
      staminaOrb.y = (int)random(300, 550);
      for (int i = 0; i < spikes.length; i++) {
        spikes[0] = new Obstacle(1800, 600);
        spikes[1] = new Obstacle(800, 600);
        spikes[2] = new Obstacle(200, 600);
      }
      player.x = 400;
      player.y = 100;
      score = 0;
      screen = 'I';
      break;
    } else if (btnResume.clicked()) {
      screen = 'I';
      break;
    } else if (btnMainMenu.clicked()) {
      screen = 'S';
      break;
    }
  case 'P':
    if (btnResume.clicked()) {
      isPaused = false;
      screen = 'I';
      break;
    } else if (btnRestart.clicked()) {
      isPaused = false;
      player.stamina = 150;
      staminaOrb.x = 1700;
      staminaOrb.y = (int)random(300, 550);
      for (int i = 0; i < spikes.length; i++) {
        spikes[0] = new Obstacle(1800, 600);
        spikes[1] = new Obstacle(800, 600);
        spikes[2] = new Obstacle(200, 600);
      }
      player.x = 400;
      player.y = 100;
      score = 0;
      screen = 'I';
      break;
    } else if (btnMainMenu.clicked()) {
      screen = 'S';
      break;
    }
  case 'T':
    if (btnBack.clicked()) {
      screen = 'S';
      break;
    }
  }
}

void keyPressed() {
  //player movement, full code in player class
  if (key == 'a' || keyCode == LEFT) {
    player.isMovingLeft = true;
  }
  if (key == 'd' || keyCode == RIGHT) {
    player.isMovingRight = true;
  }

  //player jumping, full code in player class
  if (keyCode == 32) {
    player.jump();
  }

  switch(screen) {
  case 'I':
    if (key == TAB) {
      screen = 'P';
      isPaused = true;
      break;
    }
  }
}

void keyReleased() {
  //stops movement if the key is released
  if (key == 'a' || keyCode == LEFT) {
    player.isMovingLeft = false;
  }
  if (key == 'd' || keyCode == RIGHT) {
    player.isMovingRight = false;
  }
}
