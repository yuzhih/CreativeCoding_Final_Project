ArrayList<Board> board;
boolean colliding;
PVector pos;
PVector vel;
float moving = 0;
float walk = 2;

void setup() {

  size(500, 500);
  board = new ArrayList<Board>();
  for (int i = 0; i < height; i++) {
    board.add(new Board(i * random(10, 100), random(height)));
  }
  pos = new PVector(width/2, 450);
  vel = new PVector();
}

void draw() {

  background(0);
  colliding = false;
  for (Board i : board) {
    i.show();
    if (i.collide(pos)) {
      colliding = true;
      pos.y = i.bpos.y;
    }
  }
  if (pos.y < 0) {
    setup();
  }
  if (pos.y > height) {
    gameover();
  }  
  if (pos.x > width) {
    pos.x = width - 7.5;
  }

  ball();

  if (!colliding) {
    vel.y += 0.4;
  }
  pos.add(vel);
  pos.x += moving;
  vel.mult(0.8);

  if (pos.y >= 470) {
    colliding = true;
  }
}

void ball() {
  fill(255);
  noStroke();
  ellipse(pos.x, pos.y - 7.5, 15, 15);
}

void keyPressed() {
  if (keyCode == LEFT) {
    moving = -walk;
  }
  if (keyCode == RIGHT) {
    moving = walk;
  }
  if (keyCode == UP) {
    vel.y -= 5;
  }

  if (key == ' ') {
    setup();
  }
}
void keyReleased() {
  if (keyCode == LEFT) {
    moving = 0;
  }
  if (keyCode == RIGHT) {
    moving = 0;
  }
}

void gameover() {
  textSize(15);
  fill(0);
  rect(0, 0, width, height);
  fill(255);
  text("Game Over. Press SPACE to restart.", 20, height/2);
}
