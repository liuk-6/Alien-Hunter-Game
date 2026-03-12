class bombs {
  float x, y;
  float w = 20;
  float h = 20;
  float speed;
  boolean offScreen = false;

  bombs(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.speed = s;
    
  }

  void move() {
    y += speed;

    if (y > height) {
      offScreen = true;
    }
  }

  void draw() {
    image(bombImg, x, y, 40, 40);
  }
  boolean collide(Player player){
  return (x < player.x + player.w &&
          x + w > player.x &&
          y < player.y + player.h &&
          y + h > player.y);
}
   boolean collideShield(Shield s) {
    return (x < s.x + s.w &&
            x + w > s.x &&
            y < s.y + s.h &&
            y + h > s.y);
  }
}
