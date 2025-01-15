class Leaves extends GameBase{
  
  
  ArrayList<PVector> leaves;
  int AMOUNT = 0;
  int wait_sec = 1000 * 1;
  
  
  Leaves(int count, int width, int height) {
    
    leaves = new ArrayList<PVector>();
    generateLeaves(count, width, height);
    
  }
  
  

  //Leaves generieren
  void generateLeaves(int amount, int width, int height) {
    // Generiere <amount> zufällige Blätter
    for (int i = 0; i < amount; i++) {
        float x = (int)random(camWidth, width);
        float y = (int)random(height);
        leaves.add(new PVector(x, y));
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
  
  
  void display() {
    // Zeichne alle Blätter als kleine Kreise
    if (leaves.isEmpty()) {
        println("Keine Blätter in der Liste.");
        return;
    }
    

   
    for (int i = 0; i < leaves.size(); i++) {
      PVector leaf = leaves.get(i); // Hole das aktuelle PVector-Objekt
      
      System.out.println("Blatt display try bei x:"+ leaf.x +"y: "+leaf.y );
      

      
      
      println("Blatt vor rect(): x=" + leaf.x + ", y=" + leaf.y);
      try {
            fill(255, 255, 0);
            rect(leaf.x, leaf.y, 20, 20); // Zeichne Blatt
      } catch (Exception e) {
            println("Fehler beim Zeichnen des Rechtecks: " + e.getMessage());
      }
      println("Blatt nach rect(): x=" + leaf.x + ", y=" + leaf.y);
      
      System.out.println("Blatt display success bei x:"+ leaf.x +"y: "+leaf.y );
    }
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
