class Leaves {
  ArrayList<PVector> leaves;
  int AMOUNT = 0;
  int wait_sec = 1000 * 1;
  
  Leaves(int count) {
    leaves = new ArrayList<PVector>();
    generateLeaves(count);
  }
  
  void generateLeaves(int amount) {
    // Generiere <amount> zufällige Blätter
    for (int i = 0; i < amount; i++) {
      float x = random(0, 640);
      float y = random(480, 800);
      leaves.add(new PVector(x, y));
    }
  }
  
  void display() {
    // Zeichne alle Blätter als kleine Kreise
    for (PVector leaf : leaves) {
      fill(0, 255, 0);
      ellipse(leaf.x, leaf.y, 20, 20);
    }
  }
  
  void checkCollision(Blower obj) {
    
    // Überprüfe, ob der Charakter ein Blatt berührt
    for (int i = leaves.size() - 1; i >= 0; i--) {
      PVector leaf = leaves.get(i);
      
      // Korrigierte Kollisionserkennung
      float scaledBlowerX = obj.pos.x * 2;
      float scaledBlowerY = obj.pos.y * 2;
      float distance = dist(scaledBlowerX, scaledBlowerY, leaf.x, leaf.y );
      
      
      if (distance < 50) { // 50
      
         leaves.remove(i);
         
          //bounce(leaf);
        
          println("Leaf collected at: " + leaf.x + ", " + leaf.y);
       }
      }
       
  }
  
  void bounce(PVector leaf){
    smooth();
    PVector destination = new PVector();
    
    if(leaf.x - 40 <= 0){
      leaf.x = 0;
      destination.x = random(leaf.x,leaf.x + 40);
      if(leaf.y - 40 <= 480){
        leaf.y = 480;
        destination.y = random(leaf.y,leaf.y + 40);
        leaf.x = destination.x;
        leaf.y = destination.y;
        return;
      }else if(leaf.y + 40 >= 800){
      leaf.y = 800;
        destination.y = random(leaf.y-40,leaf.y);
        leaf.x = destination.x;
        leaf.y = destination.y;
        return;
      }
    }else if(leaf.x + 40 >= 640){
      leaf.x = 640;
      destination.x = random(leaf.x-40,leaf.x);
      if(leaf.y - 40 <= 480){
        leaf.y = 480;
        destination.y = random(leaf.y,leaf.y + 40);
        leaf.x = destination.x;
        leaf.y = destination.y;
        return;
      }else if(leaf.y + 40 >= 800){
      leaf.y = 800;
        destination.y = random(leaf.y-40,leaf.y);
        leaf.x = destination.x;
        leaf.y = destination.y;
        return;
      }
    }
    
    
    if(leaf.y - 40 <= 480){
      leaf.y = 480;
      destination.y = random(leaf.y,leaf.y+40);
      if(leaf.x - 40 <= 0){
        leaf.x = 0;
        destination.x = random(leaf.x,leaf.x + 40);
        leaf.x = destination.x;
        leaf.y = destination.y;
        return;
      }else if(leaf.x + 40 >= 640){
        leaf.x = 640;
        destination.x = random(leaf.x-40,leaf.x);
        leaf.x = destination.x;
        leaf.y = destination.y;
        return;
      }
    }else if(leaf.y + 40 >= 800){
      leaf.y = 800;
      destination.y = random(leaf.y-40,leaf.y);
      if(leaf.x - 40 <= 0){
        leaf.x = 0;
        destination.x = random(leaf.x,leaf.x + 40);
        leaf.x = destination.x;
        leaf.y = destination.y;
        return;
      }else if(leaf.x + 40 >= 640){
        leaf.x = 640;
        destination.x = random(leaf.x-40,leaf.x);
        leaf.x = destination.x;
        leaf.y = destination.y;
        return;
      }
    }
    
    
    destination.x = random(leaf.x -40,leaf.x +40);
    destination.y = random(leaf.y -40,leaf.y +40);
    
    
    leaf.x = destination.x;
    leaf.y = destination.y;
  }
}
