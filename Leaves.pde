class Leaves  {
  
  
  ArrayList<PVector> leaves;
  ArrayList<PVector> velLeaves;
  int AMOUNT = 0;
  int wait_sec = 1000 * 1;
  int timer=0;
  int respawn_timer=0;
  int scoreboard=0;
  
  Leaves(int count, int width, int height) {
    println("testvorLEaves");
    leaves = new ArrayList<PVector>();
    velLeaves= new ArrayList<PVector>();
    generateLeaves(count, width, height);
    
    println("test2");
  }
  
  

  //Leaves generieren
  void generateLeaves(int amount, int width, int height) {
    // Generiere <amount> zufällige Blätter
    for (int i = 0; i < amount; i++) {
        float x = (int)random(camWidth, width);
        float y = (int)random(height);
        leaves.add(new PVector(x, y));
        velLeaves.add(new PVector(0,0,0));
        System.out.println("Blatt generiert bei x:" + x + " y: " + y);
    }
  }
  
  void debugLeaves() {
    for (int i = 0; i < leaves.size(); i++) {
        PVector leaf = leaves.get(i);
        if (leaf == null) {
            println("Null bei Index " + i);
        } else {
            println("Leaf bei Index " + i + ": x = " + leaf.x + ", y = " + leaf.y);
        }
    }
}
  
  
  void leafDisplay() {
    // Zeichne alle Blätter als kleine Kreise
    if (leaves.isEmpty()) {
        println("Keine Blätter in der Liste.");
        return;
    }
    

   
    for (int i = 0; i < leaves.size(); i++) {
      PVector leaf = leaves.get(i); // Hole das aktuelle PVector-Objekt
      if (leaf == null) {
         println("Null-Wert bei Index " + i + " in leaves.");
         continue; // Überspringe diesen Eintrag
         }
      System.out.println("Blatt display try bei x:"+ leaf.x +"y: "+leaf.y );
      PVector velLeaf=MoveLeaf(leaf);
      if(velLeaf.x==0 && velLeaf.y==0 && velLeaf.z==0){
         velLeaf=velLeaves.get(i);
         println("Error_catch");
      }
      if(velLeaf.z != 0){
      float vel=velLeaf.z;
      float xChange=velLeaf.x *(vel/60);
      float yChange=velLeaf.y *(vel/60);
      if(timer<=60){
        timer=timer+1;
      }else{
        timer=0;
        respawn_timer=respawn_timer+1;
        if(respawn_timer>5){
           if(leaves.size()<15){
            generateLeaves(15-leaves.size(),width,height);
           }
        }
      if (vel>1){
      vel=vel/2;
      }
      }

      leaf.x=leaf.x+xChange;
      leaf.y=leaf.y+yChange;
      PVector backVector=new PVector(xChange,yChange,vel);
      velLeaves.set(i, backVector);
      }
      
      println("Blatt vor rect(): x=" + leaf.x + ", y=" + leaf.y);
      try {
            if((leaf.x>width || leaf.x<camWidth) || (leaf.y>height || leaf.y<0)){
              leafDeleter(i);
            }
            else{
            fill(255, 255, 0);
            rect(leaf.x, leaf.y, 20, 20); // Zeichne Blatt
            }
      } catch (Exception e) {
            println("Fehler beim Zeichnen des Rechtecks: " + e.getMessage());
      }
      println("Blatt nach rect(): x=" + leaf.x + ", y=" + leaf.y);
      
      System.out.println("Blatt display success bei x:"+ leaf.x +"y: "+leaf.y );
    }
  }
  
  void leafDeleter(int i){
    leaves.remove(i);
    scoreboard=scoreboard+100;
    
  }
    //Leaves bouncing
 /* void bounce(float cx, float cy, float radius, float rx, float ry, float rw, float rh){
      // temporary variables to set edges for testing
      for(int i = leaves.size() - 1; i >= 0; i--) {
      float testX = cx;
      float testY = cy;

      // which edge is closest?
      if (cx < rx)         testX = rx;      // test left edge
      else if (cx > rx+rw) testX = rx+rw;   // right edge
      if (cy < ry)         testY = ry;      // top edge
      else if (cy > ry+rh) testY = ry+rh;   // bottom edge

      // get distance from closest edges
      float distX = cx-testX;
      float distY = cy-testY;
      float distance = sqrt( (distX*distX) + (distY*distY) );

      // if the distance is less than the radius, collision!
      if (distance <= radius) {
        //hier leaf acceleration einbauen
      }
    
    }
  }*/
}
