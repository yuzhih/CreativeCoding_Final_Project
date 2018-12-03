class Board {
  PVector bpos;
  float blength = random(40, 100);

  Board(float x, float y) {
    bpos = new PVector(x, y);
  }

  void show(){
    stroke(255);
    noFill();
    rect(bpos.x, bpos.y, blength, 8);
  }
  
  boolean collide(PVector b){
    if (b.x > bpos.x && b.y > bpos.y && b.x <bpos.x + blength && b.y < bpos.y + 5){
      return true;
    }
    return false;
  }
  boolean bounce(PVector b){
    
  
}
