class Shield {
  float x, y;
  float w = 60, h = 30;
  int health = 5;     // number of hits it can take
  boolean destroyed = false;
  int powerUpType = 0; 

  Shield(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    if (destroyed) return;

    // visual damage: color/alpha based on health
    float alpha = map(health, 0, 5, 0, 255);
    fill(0, 0, 255, alpha);
    noStroke();
    rect(x, y, w, h);
  }

  void damage() {
    if (destroyed) return;
    health--;
    if (health <= 0) {
      destroyed = true;
    }
  }
  void applyPowerUp(int type){
    powerUpType = type;
  }
}
