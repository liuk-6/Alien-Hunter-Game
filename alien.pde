class Alien {
  float x, y;
  float speed;
  int direction = 1;
  boolean alive = true;  
  int explosionTimer = 0;
  bombs myBomb = null;

  
  Alien(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.speed = s;
  }
  
  void move() {
    if (!alive) return;

     x += speed*direction;
    if (x + 40 >= width || x <= 0){
      direction *= -1;
      y += 40;
    }

    // Random chance to drop a bomb
    if (myBomb == null && random(1) < 0.005) {
      myBomb = new bombs(x + 20, y + 40, 3);
    }
     if (myBomb != null) {
        myBomb.move();
    }
  }
    void updateExplosion() {
    if (!alive && explosionTimer > 0) explosionTimer--;
  }

  bombs getBomb() {
    return myBomb;
  }
   void clearBomb() {
    myBomb = null;
  }

  
  void display() {
    if (alive) image(alienImg, x, y, 40, 40);
    else if(explosionTimer > 0) image(explodeImg, x, y, 40, 40);
  }
  
  void explode() {
    alive = false;
    explosionTimer = 60; 
  }
}
