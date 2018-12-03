//Code inspired by Arthur Facredyn
//https://www.youtube.com/watch?v=QJGcxeF3YBs

ArrayList<Board> board; //array for floating boards in the game (as in "platforms" in the video)
boolean colliding; //corresponds to collide
PVector pos; //position of the ball/main character
PVector vel; //velocity of the ball
float dis = 0; //horizontal displacement of the ball
float r = 7.5; //radius of the ball

void setup() {

  size(500, 500);
  board = new ArrayList<Board>(); //delare the ArrayList for the board class
  for (int i = 0; i < height; i++) {
    board.add(new Board(i * random(10, 100), random(height)));
  } //add boards(objects) to the ArrayList to generate boards at random positions
  pos = new PVector(width/2, 450);
  vel = new PVector();
}

void draw() {

  background(0);
  colliding = false; //initiate the game as the ball not colliding on any board
  for (Board i : board) { // for(datatype/class in this case : variable name/defines the array)
    i.show(); //show the visuals of the boards
    if (i.collide(pos)) { //collide (board) = colliding (ball)
      colliding = true; 
      pos.y = i.bpos.y; //synchronizes positions for both ball and boards
    }
  }

  control();
  ball();

  if (!colliding) { //when the ball 
    vel.y += 0.5;
  }
  pos.add(vel);
  pos.x += dis; //horizontal position of the ball updates by keep adding the displacement
  vel.mult(0.8);

  if (pos.y >= 470) {
    colliding = true;
  }
}

void ball() { //visual of the main character
  fill(255);
  noStroke();
  ellipse(pos.x, pos.y - r, 15, 15);
}

void keyPressed() {
  if (keyCode == LEFT) {
    dis = -3; //ball moves to the left by 3 unites every time the left key is pressed
  }
  if (keyCode == RIGHT) {
    dis = 3; //ball moves to the right by 3 unites every time the right key is pressed
  }
  if (keyCode == UP) { //allows the ball to jump
    vel.y -= 8;       //using velocity creates more dynamic than simple addition/subtraction 
    //of position/displacement, I wonder if acceleration is necessary here
    //I could add gravity and outside forces into this game
    if (vel.y <= -20) { //limit how high the ball can jump if the player keeps pressing on the up key
      vel.y = 10;  //I haven't found a way to ACTUALLY to limit the height
    }            //for now it is only more difficult for the player to keep pressing
  }
  if (key == ' ') {
    setup(); //restart the game whenever the space key is pressed
  }          //the code is the same when pos.y < 0, I probably need to think of a
  //way to distinguish the meaning (restart and switch platforms)
} 

void keyReleased() { //stops the ball from colliding forever when it is on a board
  if (keyCode == LEFT) { //only for horizontal motions(left and right)
    dis = 0;          //because they are the only motions when colliding = true
  }
  if (keyCode == RIGHT) {
    dis = 0;
  }  //I find it easier to organize all the keypress/release into a "control" function
}    //it's frustrating that only keyReleased doesn't have a boolean variable form

void control() { //conditionals(ifs) for checking the edges of the window 
  if (pos.y < 0) {
    setup(); //switch to a new scene/reinitiate the scene when the ball reaches to the top
  }
  if (pos.y > height + 80) { //the + 80 here means to give the player a couple
    gameover();      //of seconds to realize they have to jump before they simply "die"
  }    
  if (pos.x > width) { //edge checks: when the ball hits the two horizontal boundaries
    pos.x = width - r;  //it will stop moving
    //dis = 0;
  }
  if (pos.x < 0) {
    pos.x = r;
    //dis = 0;
  }
}

void gameover() { //display screen when the ball fall off(?) the window
  textSize(15);
  fill(0);
  rect(0, 0, width, height);
  fill(255);
  text("Game Over. Press SPACE to restart.", 20, height/2);
}



/*Notes:
  
  In this prototype so far I missed a lot of the elements mentioned in my roundtable 
  presentation, like the switch in different modes (reality and dream), collecting
  stars, and attacking the monster. These issues will be addressed in the
  beta version. **and bouncing of the edges of the boards
  
*/
