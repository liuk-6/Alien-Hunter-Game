class Bullet {
  float x, y;
  float speed = 5;
  float w = 5;
  float h = 10;
  float dx = 0;
  
  Bullet(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  Bullet(float x, float y, float dx){
    this.x = x;
    this.y = y;
    this.dx = dx*2;
  }
  
  void move(){
    y -= speed;
    x += dx;
  }
  
  void display(){
    fill(255,0,0);
    noStroke();
    rect(x-w/2, y-h, w, h);
  }
  
  void collide(Alien[] aliens){
    for(Alien a : aliens){
      if(a.alive && dist(x, y, a.x+20, a.y+20) < 25){
        a.explode();
      }
    }
  }

  boolean collideShield(Shield s) {
    return (x > s.x && x < s.x + s.w &&
            y > s.y && y < s.y + s.h);
  }
}
