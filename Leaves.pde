class Leaves  {
  
  
  ArrayList<PVector> leaves;
  ArrayList<PVector> velLeaves;
  int imageArray[];
  int AMOUNT = 0;
  int wait_sec = 1000 * 1;
  int timer=0;
  int respawn_timer=0;
  int scoreboard=0;
  float vel,xChange,yChange;
  PImage Blatt1;
  PImage Blatt2;
  PImage Blatt3;
  PImage Blatt4;
  Leaves(int count, int width, int height) {
    println("testvorLEaves");
    leaves = new ArrayList<PVector>();
    velLeaves= new ArrayList<PVector>();
    imageArray = new int[16];
    generateLeaves(count, width, height);
    for(int i=0;i<15;i++){
      int r= int(random(0,4));
        imageArray[i]=r; 
    }
    println("test2");
  }
  
  

  //Leaves generieren
  void generateLeaves(int amount, int width, int height) {
    // Generiere <amount> zufällige Blätter
    for (int i = 0; i < amount; i++) {
        float x = (int)random(camWidth, width);
        float y = (int)random(height);
        int r= int(random(0,4));
        if(leaves.size()<15){
        imageArray[leaves.size()]=r;
        }
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
      vel=velLeaf.z;
      xChange=velLeaf.x *(vel);
      yChange=velLeaf.y *(vel);
      }else{
         PVector velLeaf2=leaves.get(i);
         if (velLeaf2.z>1){
            vel= velLeaf2.z;
            if(timer==60){
              vel=vel/2;
            }
              xChange=velLeaf2.x*vel;
             yChange=velLeaf2.y*vel;
         }else{
           xChange=0;
           yChange=0;
         }
      }
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
      }
      leaf.x=leaf.x+xChange;
      leaf.y=leaf.y+yChange;
      PVector backVector=new PVector(xChange,yChange,vel);
      velLeaves.set(i, backVector);
      
      
      println("Blatt vor rect(): x=" + leaf.x + ", y=" + leaf.y);
      try {
            if((leaf.x>width || leaf.x<camWidth) || (leaf.y>height || leaf.y<0)){
              leafDeleter(i);
            }
            else{
                    /*float randomShape = random(0,100);
                    
                    if(randomShape < 50){
                        noStroke();
                        fill(255, 255, 0);
                        //rect(leaf.x, leaf.y, 20, 20); // Zeichne Blatt
                        ellipse(leaf.x, leaf.y, 20,30); // Zeichne Blatt
                    }else{
                        noStroke();
                        fill(255, 255, 0);
                        //rect(leaf.x, leaf.y, 20, 20); // Zeichne Blatt
                        ellipse(leaf.x, leaf.y, 30,20); // Zeichne Blatt
                    }
              
              */
             
             if(imageArray[i]==0){
              Blatt1 = loadImage("Blatt2.png"); 
                  Blatt1.resize(50, 0);
                  image(Blatt1,leaf.x,leaf.y);
             }
             if(imageArray[i]==1){
               Blatt2 = loadImage("blatt3.png"); 
                  Blatt2.resize(50, 0);
                  image(Blatt2,leaf.x,leaf.y);
             }
             if(imageArray[i]==2){
                Blatt3 = loadImage("Blatt4.png"); 
                  Blatt3.resize(50, 0);
                  image(Blatt3,leaf.x,leaf.y);
             }
             if(imageArray[i]==3){
                Blatt4 = loadImage("Blatt5.png"); 
                  Blatt4.resize(50, 0);
                  image(Blatt4,leaf.x,leaf.y);  
             }
                  
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
    velLeaves.remove(i);
    if (imageArray[i]==0){
    scoreboard=scoreboard+100;
    }
    if (imageArray[i]==1){
    scoreboard=scoreboard+200;
    }
    if (imageArray[i]==2){
    scoreboard=scoreboard+300;
    }
    if (imageArray[i]==3){
    scoreboard=scoreboard+1000;
    }
    for(int k=i;k<15;k++){
        imageArray[i]=imageArray[i+1];
    }
    int r= int(random(0,4));
      imageArray[15]=r;
  }
  
  int getScore(){
    return scoreboard;
  }
  
  
}
