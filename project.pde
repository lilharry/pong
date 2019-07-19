//paddle coordinates and dimensions
int userX, userY;
int compX, compY;
int paddleWidth, paddleHeight;
int paddleSpeed;
boolean movingUp, movingDown;

//ball coordinates and dimensions
int ballX, ballY;
int xSpeed, ySpeed;
int ballDiameter, ballRadius;
void setup(){
  //setup dimensions
  size(800, 800);  
  
  //setup ball dimensions
  ballX = height/2;
  ballY = width/2;
  ballDiameter = 30;  
  ballRadius = ballDiameter/2;
  
  //setup user and computer paddle dimensions
  paddleWidth = 10;
  paddleHeight = 100;
  userX = 30;
  userY = width/2 - paddleHeight/2;
  compX = width - 30 - paddleWidth;
  compY = width/2 - paddleHeight/2;
  paddleSpeed = 8;
  movingUp = movingDown = false;


  //serve direction
  if (int(random(0,1)) == 0){
    xSpeed = -6;
  }else{
    xSpeed = 6;
  }
  ySpeed = 0;
}

void draw(){  
  background(255,255,255);
  drawBall();  
  drawPaddles();
  moveUser();
  moveBall();
}

void drawPaddles(){
  fill(0,0,0);
  
  pushMatrix();
  translate(userX, userY);
  rect(0, 0, paddleWidth, paddleHeight);
  popMatrix();
  
  pushMatrix();
  translate(compX, compY);
  rect(0, 0, paddleWidth, paddleHeight);
  popMatrix();
}

void moveUser(){
  println(movingUp);
  println(userY - paddleSpeed);
  if (movingUp && (userY - paddleSpeed >= 0)){
    userY -= paddleSpeed;
    
  }
  if (movingDown && (userY + 100 + paddleSpeed <= height)){
    userY += paddleSpeed;
  }
}

void drawBall(){
  pushMatrix();
  translate(ballX,ballY);
  fill(0,0,0);
  ellipse(0, 0, ballDiameter, ballDiameter);
  popMatrix();
}

void moveBall(){
  if (ballX <= 0 + ballDiameter/2 || ballX >= width - ballDiameter/2 || userHit()){
    xSpeed *= -1;
    if (userHit()){
      if (movingUp) ySpeed -= 5;
      if (movingDown) ySpeed += 5;
    }
  }
  if (ballY <= 0 + ballDiameter/2 || ballY >= height - ballDiameter/2){
    ySpeed *= -1;
  }
  ballX += xSpeed;
  ballY += ySpeed;
}

boolean userHit(){
  return (ballX - ballRadius <= userX + 10 && ballY - ballRadius <= userY + paddleHeight && ballY + ballRadius >= userY);
}

void keyPressed(){
  if (key == CODED){
    if (keyCode == UP){
      movingUp = true;
    }
    if (keyCode == DOWN){
      movingDown = true;
    }
  }
}

void keyReleased(){
  if (key == CODED){
    if (keyCode == UP){
      movingUp = false;
    }
    if (keyCode == DOWN){
      movingDown = false;
    }
  }
}
