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
        int x = int(random(camWidth, width)); //float zu int geändert und statt (int)random(...) -> int(random(...)), ist Processing Funktion
        int y = int(random(height));
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
            println("Leaf gefunden bei Index " + i + ": x = " + leaf.x + ", y = " + leaf.y);
        }
    }
}
  
  
  void leafDisplay() { 
    // Zeichne alle Blätter als kleine Rechtecke
    if (leaves.isEmpty()) {
        println("Keine Blätter in der Liste.");
        return;
    }
    

   
    for (int i = 0; i < leaves.size(); i++) {
      PVector leaf = leaves.get(i); // Hole das aktuelle PVector-Objekt
      
      System.out.println("Blatt display try bei x:"+ leaf.x +"y: "+leaf.y );
      
         if (leaf == null) {
         println("Null-Wert bei Index " + i + " in leaves.");
         continue; // Überspringe diesen Eintrag
         }
      
      
      //println("Blatt vor Abbildung mit rect(): x=" + leaf.x + ", y=" + leaf.y);
      try {
            fill(255, 255, 0);
            rect(leaf.x, leaf.y, 20, 20); // Zeichne Blatt
      } catch (Exception e) {
            println("Fehler beim Zeichnen des Leaf: " + i + "Fehler: " + e.getMessage()); 
      }
      //println("Blatt nach Abbildung mit rect(): x=" + leaf.x + ", y=" + leaf.y); //Test um zu gucken ob Leaf PVector Element versehentlich verändert wurde
      
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
