Alien[] aliens = new Alien[5];
Player player;
Shield[] shields;
ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();
boolean anyAlive = false;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<bombs> bombsList = new ArrayList<bombs>();
PImage alienImg, explodeImg, bombImg, bossImg;
boolean gameOver = false;
boolean gamePaused = false;
int keyCount = 0;
boolean gameWon = false;



void setup() {
  size(600, 400);
  
  PFont myFont = loadFont("AppleGothic-18.vlw");
  textFont(myFont);
  
  // Load images
  alienImg = loadImage("invader.GIF");
  explodeImg = loadImage("exploding.GIF");
  bombImg = loadImage("bomb.png");
  bossImg = loadImage("bossAlien.png");
  shields = new Shield[2];
  for (int i = 0; i < shields.length; i++) {
    shields[i] = new Shield(160 + i*160, height - 120);
  }

  // Create aliens
  for (int i = 0; i < aliens.length; i++) {
    aliens[i] = new Alien(50 + i*45, 50, random(1,3));
  }
  
  // Create player rectangle
  player = new Player(width/2, height-20);

  
}

void draw() {
  background(0);
  for (Shield s : shields) {
    s.display();
  }

    // Move and display aliens
    for (int i = 0; i < aliens.length; i++) {
      Alien a = aliens[i];
      a.move();
      a.display();
        a.updateExplosion();
    
    // Drop power-up when alien explodes
    if(!a.alive && a.explosionTimer == 59){ // just exploded
      if(random(1) < 0.5){ // 50% chance
        int type = int(random(0,3));
        powerUps.add(new PowerUp(a.x + 20, a.y + 20));
      }
    }
    
      bombs aBomb = a.getBomb();
      if (aBomb != null) {
        aBomb.draw();
        aBomb.collide(player);
     
        // Bomb hits shields
        for (Shield s : shields) {
          if (!s.destroyed && aBomb.collideShield(s)) {
            s.damage();
            a.clearBomb();
            break;
          }
        }
      
        // Bomb goes off screen
        if (aBomb.offScreen) {
          a.clearBomb();
        }
      }
    }

    
    // Move and display bullets
    for (int i = bullets.size()-1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      b.move();
      b.display();
      b.collide(aliens);
      if (random(1) < 0.01){
        powerUps.add(new PowerUp(100,20));
      }
      if (b.y < 0) bullets.remove(i);
      for (Shield s : shields) {
        if (!s.destroyed && b.collideShield(s)) {
          s.damage();
          bullets.remove(i);
          break;
        }
      }
    }
    
    // Move and display player
    player.move();
    player.display();
    boolean anyAlive = false;
    for (Alien a : aliens) {
      if (a.alive) {
        anyAlive = true;
      }
    }
    
    if (!anyAlive) {
        gameWon = true;
    }
    
    // Game over
    if (gameOver) {
      fill(255, 0, 0);
      text("Game Over", 220, 200);
      noLoop();
      return;
    }
    if (gameWon){
      fill(0, 255, 0);
      text("Game Won", 220, 200);
      noLoop();
      return;
    }
    
    // Pause
    if (gamePaused) {
      //fill(255);
      //text("Game Paused", 220, 200);
      return;
    }
     // Move and display power-ups
    for(int i=powerUps.size()-1; i>=0; i--){
      PowerUp p = powerUps.get(i);
      p.move();
      p.display();
    
    // Check collision with player
    if(dist(p.x, p.y, player.x + player.w/2, player.y + player.h/2) < 25){
      powerUps.remove(i);
    } else if(p.y > height) powerUps.remove(i); // remove if off screen
  }
}

// ===== Player Controls =====
void keyPressed() {
  if (keyCode == LEFT)  player.dx = -5;
  if (keyCode == RIGHT) player.dx = 5;
  
  if (keyCount%2==0){
    keyCount++;
    gamePaused= true;
  }
  else if(keyCount%2!=0){
    keyCount++;
    gamePaused = false;
  }
}

void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) player.dx = 0;
}

// ===== Fire bullets on mouse click =====
void mousePressed() {
  if (!gameOver) {
    player.fire();
  }
  if(gameOver){
    
  }
}
