class Board {
  PVector bpos;
  float blength = random(40, 100); //random board length
  float bthick = 8; //thickness of the boards

  Board(float x, float y) {
    bpos = new PVector(x, y); //the board position
                              //Facredyn used the same term "pos" in his video yet I found it 
  }                          //a bit necessary to differentiate the two
                             //like "collide" and "colliding"
  void show(){ //visual of the boards
    stroke(255);
    noFill();
    rect(bpos.x, bpos.y, blength, bthick);
  }
  
  boolean collide(PVector b){ //b refers to both ball and board
    if (b.x > bpos.x && b.y > bpos.y && b.x <bpos.x + blength && b.y < bpos.y + bthick){
      return true; //to ensure that when the ball is on the board, the ball is able to
    }          //stay static
    return false;
  }
  //boolean bounce(PVector b){
  //I was thinking of ways to make the ball bounce off when it hits the bottom of the board
  //but it kept getting errors
  //return true;
}
