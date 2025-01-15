class Blower {  
  PVector pos, vel;
  float rotation, objectWidth, objectHeight;
  boolean isStartedOnce = true;

  Blower() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(5, 5);
    Radius=10;
    rotation = 0;
    objectWidth = 50;
    objectHeight = 50;
  }
  

  void display() {
    pos.x = constrain(pos.x, 25, width-25);
    pos.y = constrain(pos.y, 25, height-25);
 
    if(isStartedOnce){
      pos.x = 150;
      pos.y =  325;
      isStartedOnce = false;
    }
    isStartedOnce = false;
   // pushMatrix();
   // translate(pos.x, pos.y);
    //rotate(radians(rotation));
    fill(255, 0, 0);  // Rotes Rechteck
    noStroke();
    //rectMode(CENTER);
    //rect(-200, -100, 50, 50);
    rect(pos.x - objectWidth/2 ,pos.y - objectHeight/2 , objectWidth, objectHeight);
    //popMatrix();
    
  }
  
  void say(){
    println("Unscaled Pos X : " + pos.x);
    println("Unscaled Pos Y : " + pos.y);
    println("Scaled Pos X: " + (pos.x * 2));
    println("Scaled Pos Y: " + (pos.y * 2));
  }
  PVector MoveLeaf(PVector Leaf){
    if(dist(pos.x,pos.y,Leaf.x,Leaf.y)<Radius){
    float velocityLeaf=dist(pos.x,pos.y,Leaf.x,Leaf.y);
    float xDiffrence=Leaf.x-pos.x;
    float yDiffrence=Leaf.y-pos.y;
    PVector leafVector= new PVector(velocityLeaf,xDiffrence,yDiffrence);
    return leafVector;
    }else{
      PVector Error= new PVector(0,0,0);
      return Error;
    }
  }
  void move(int i) {
    // nach links bewegen
    if (i == -1)  {
      if(pos.x == 0)return;
      pos.x -= vel.x;
    }
    // nach rechts bewegen
    if (i == 1) {
      if(pos.x == 295)return;
      pos.x += vel.x;
    }
    
    // Vertikale Bewegung
    // nach oben bewegen
    if (i == 2) {
      if(pos.y == 265)return;
       pos.y -= vel.y;
    }

    // nach unten bewegen
    if (i == 3) {
      if(pos.y == 375)return;
      pos.y += vel.y;
    }
  }
}
