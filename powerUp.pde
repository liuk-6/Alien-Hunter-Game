class PowerUp {
  float x, y;
  float speed = 2;
  
  PowerUp(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void move(){
    y += speed;
  }
  
  void display(){
    fill(0, 0, 255);
  }
}
