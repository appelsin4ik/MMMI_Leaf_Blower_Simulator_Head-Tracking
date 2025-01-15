class Player extends GameBase{
  
  //int   blowStaerke;
  PVector pos, vel;
  float rotation, objectWidth, objectHeight;
  boolean firstStart = true;
  //Rectangle[] playerPos;
  
  Player() {
    //int blowStärke = 10;
    pos = new PVector(width/2, height/2);
    vel = new PVector(5, 5);
    rotation = 0;
    objectWidth = 50;
    objectHeight = 50;
    
  }
  

void display(Rectangle[] faces){
  
 // fill(255,0,0);
 // noStroke();
  /*
  for (int i = 0; i < faces.length; i++){
    rect(faces[i].x - objectWidth / 2 ,faces[i].y - objectHeight / 2 , objectWidth, objectHeight);
  }*/
  
  
  
    if (objectWidth <= 0 || objectHeight <= 0) {
      System.out.println("Ungültige Dimensionen: objectWidth = " + objectWidth + ", objectHeight = " + objectHeight);
      throw new IllegalArgumentException("Ungültige Objektgrößen");
    }
    System.out.println("Faces: " + Arrays.toString(faces));
  
    System.out.println("Faces in display(): " + Arrays.toString(faces));
    
    if (faces == null || faces.length == 0) {
        System.out.println("Keine Rechtecke zu zeichnen.");
        return;
    }


    fill(255, 0, 0);
    noStroke();

     for (int i = 0; i < faces.length; i++) {
        // Wenn das Element "faces[i]" null ist, eine detaillierte Ausgabe und eine Ausnahme auslösen
        if (faces[i] == null) {
            System.out.println("Null-Element bei Index " + i);
            throw new NullPointerException("faces[" + i + "] ist null");
        }
        System.out.println("Rectangle bei Index " + i + ": " + faces[i]);
        System.out.println("x: " + faces[i].x + ", y: " + faces[i].y +
                           ", width: " + faces[i].width + ", height: " + faces[i].height);

        // Zeichnen des Rechtecks
        rect(faces[i].x - objectWidth / 2, faces[i].y - objectHeight / 2, objectHeight, objectWidth);
    }

    System.out.println("Faces in display() am Ende: " + Arrays.toString(faces));


}




  /*
  //void display(Rectangle playerPos) {
   void display (int[] pPosX, int[] pPosY){
    //playerPos.x = constrain(playerPos.x, -height + 25, width-25);
    //playerPos.y = constrain(playerPos.y, camWidth, height-25);
    
    pPosX = constrain(pPosX, -height + 25, 0);
    pPosY = constrain(pPos.y, camWidth, width - 25);
 
    if(firstStart){
      pPosX = 1000;
      pPosY =  500;
      firstStart = false;
    }
    firstStart = false;
   // pushMatrix();
   // translate(pos.x, pos.y);
    //rotate(radians(rotation));
    fill(255, 0, 0);  // Rotes Rechteck
    noStroke();
    //rectMode(CENTER);
    //rect(-200, -100, 50, 50);
    rect(pPosX - objectWidth/2 ,pPosY - objectHeight/2 , objectWidth, objectHeight);
    //popMatrix();
    
  }
  
  //Position
  /*  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    playerPos[i] =
    }*/
  
  
  
  //Umkreis Leaf Blower (Stärke)
  //Lautstärke -> Umkreis Stärke
  
  
}
