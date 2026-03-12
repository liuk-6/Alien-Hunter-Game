class Player {
  float x, y;
  float dx = 0;
  float w = 60;
  float h = 10;

  
  Player(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void move(){
    x += dx;
    x = constrain(x, 0, width-w);
  }
  void display(){
    fill(0, 255, 0);
    rect(x, y, w, h);
  }
  
  void fire(){
    bullets.add(new Bullet(x + w/2, y));
  }
   
}
