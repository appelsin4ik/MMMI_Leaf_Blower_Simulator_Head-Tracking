import java.util.Arrays;
import java.awt.Rectangle;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import processing.core.PApplet; 
import processing.core.PGraphics;
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;
import processing.core.PImage;
import ddf.minim.*;

Minim minim;
AudioInput input;
PGraphics graphics;
Capture video;
OpenCV opencv;
Leaves leaves;
/*int camWidth = 640;
int camHeight = 360;*/
int camWidth,camHeight;
int score = 0;
Rectangle playerPos = new Rectangle(0,0,0,0);
int[] pPosX;
int[] pPosY;
float posX=500;
float posY=500;
float rotation, objectWidth = 50, objectHeight = 50;
float RadiusKreis=0;
float Radius;




Rectangle[] faces = new Rectangle[0]; // Initialisieren mit leerem Array



/*void settings(){          //braucht man um size mit variablen zu machen aber size(...,...) oder
                            //   fullscreen() setzt height und width (siehe println unten)
size(width, height);
}*/

void setup() {
  //Fenster Größe
  fullScreen(); //statt:
  //size(1920, 1080);  
  frameRate(60);
   camWidth = width/3;
   camHeight = height/3;
  
  //Test um Fenstergröße zu checken
  println("width: "+width);
  println("height: "+height);
  
 
   //Spracherkenneung
    minim = new Minim(this);
    input = minim.getLineIn(Minim.MONO, 1024); //Audio Input




   
  //Kamera Setup
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  }
  
  
  //Erstellen von Leaves + -> Klasse
  println("test1");
  leaves = new Leaves( 15, width, height); //Leaves werden generiert, steht nur hier vorne, vor video..., um ohne Kamera zu checken ob es funktioniert
  leaves.debugLeaves(); //zeigt alle Leaf-Positionen an
  println("testnachLeaf");
  
  
  //Gesichserkennung
  try{
  video = new Capture(this, camWidth, camHeight, cameras[0]);  //Größe des Kamerafensters
  opencv = new OpenCV(this, camWidth, camHeight);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);   //gesamtes gesicht wird erkannt
  } catch (Exception e) {
    println("Kamerafehler: " + e.getMessage());
    stop();
  }

  
  
         
  
  

  

  
  

  
  //video.start();
  
  try{
  video.start(); //wenn kein video gefunden wird Programm beendet
  } catch(Exception e){
    println("Fehler in Setup: " + e.getMessage());
    stop();
    }
    
   
  
}









void draw() {     
  
  //Hintergrund Rasen
  PImage grass;
  grass = loadImage("grass.jpg");    //später schöneres Bild von Gras oder Rasen nehmen oder Pixelart selbst erstellen
  grass.resize(width,height);
  
  //background(grass);
  image(grass,0,0);
  
  //Scoreboard
  tint(0,126);
  image(grass,0,height/3,width/3,height);
  noTint();
  textSize(100);
  fill(240, 188, 15);
  text("Scoreboard",width/17,height/3 +100);
  textSize(50);
  fill(0, 408, 0);
  text("Points:    ",width/27,height/3 + 200);
  text(leaves.getScore(),width/10+50,height/3 + 200);
  
  
  //Saves the Matrix (display)
  //pushMatrix();
  
  
  try{
  opencv.loadImage(video);
  } catch (Exception e){
    println("Fehler in draw: "+ e.getMessage());
    stop();
  }
  
  
    
  image(video, 0, 0);  //Position des Kamerafensters
  noFill();            //Rechteck wird nicht gefüllt (Rechteck Gesicht)
  stroke(0, 255, 255); //Farbe vom Rechteck
  strokeWeight(3);     //Liniendicke Rechteck
  
  
  
  
 // noTint();
  
  
   //Rectangle[] faces = opencv.detect();           //Position Gesicht Kamera
   Rectangle[] detectedFaces = opencv.detect();
   if (detectedFaces != null && detectedFaces.length > 0) {
       faces = Arrays.copyOf(detectedFaces, detectedFaces.length); //neue Daten
   } else {
       System.out.println("Keine Gesichter erkannt.");
       faces = new Rectangle[0];                    //leer, falls keine Gesichter erkannt wurden
   }
   

    
    
     
   // Gesichtserkennung visualisieren (Rechteck um Kopf zeichnen)
   for (int i = 0; i < faces.length; i++) {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
   }
    
   //Test Koordinaten
   /*for (int j = 0; j < faces.length; j++){
     headPos = faces;
     println("Faces: " + faces[j].x + " " + faces[j].y + " " + faces[j].width + " " + faces[j].height);
     println("headPos: " + headPos[j].x + " " + headPos[j].y + " " + headPos[j].width + " " + headPos[j].height);
   }*/
    
  //faces[].x = playerPos.x;
  //playerPos = faces;
  
 /* for (int i = 0; i <= faces.length; i++) { //faces in PlayerPos Rectangle speichern -> unabhängiges Objekt
  //faces[i].x = playerPos.x;
  //faces[i].y = playerPos.y;
  //faces[i].width = playerPos.width;
  //faces[i].height = playerPos.height;
  
   pPosX[i] = faces[i].x;
   pPosY[i] = faces[i].y;
  }*/
  
    
    
 
    
    
    
    
    
    
    

    //Blower/PLayer Display
 /* if (faces != null && faces.length > 0) {
    //System.out.println("Faces vor der Übergabe: " + Arrays.toString(faces));
  
  
   

     for (int i = 0; i < faces.length; i++) {
        // Wenn das Element "faces[i]" null ist, eine detaillierte Ausgabe und eine Ausnahme auslösen
        if (faces[i] == null) {
            System.out.println("Null-Element bei Index " + i);
            throw new NullPointerException("faces[" + i + "] ist null");
        }
        
        System.out.println("faces: x: " + faces[i].x + ", y: " + faces[i].y +
                           ", width: " + faces[i].width + ", height: " + faces[i].height);

        // Zeichnen des Rechtecks
        Rectangle[] playerPos = Arrays.copyOf(faces, faces.length);  //Kopie um Spielerposition unabhängig nutzen zu können
        
        System.out.println("playerPos: x: " + playerPos[i].x + ", y: " + playerPos[i].y +
                           ", width: " + playerPos[i].width + ", height: " + playerPos[i].height);
                           
        rect(playerPos[i].x - objectWidth / 2 + width/2, playerPos[i].y - objectHeight / 2 + height/2, objectHeight, objectWidth);
        noFill();
        stroke(0, 255, 255); 
        strokeWeight(3);
        posX=playerPos[i].x + width/2;
        posY=playerPos[i].y + height/2;
        circle(playerPos[i].x + width/2, playerPos[i].y + height/2, RadiusKreis);
         }

    System.out.println("Faces am Ende: " + Arrays.toString(faces));      
  } else {
    System.out.println("Keine faces erkannt oder Array ist leer.");
  }
    }*/
        Radius= Radius();
        Rectangle[] playerPos = Arrays.copyOf(faces, faces.length);
        if (faces != null && faces.length > 0){
        
        posY=map (playerPos[0].y,0,camHeight-objectHeight*2,0,height);
        posX=map (playerPos[0].x,0,camWidth-objectWidth*2,camWidth,width);
        }
        noFill();
        stroke(0, 255, 255); 
        strokeWeight(3);
        rect(posX-objectWidth/2,posY-objectHeight/2,50,50);
        println("posY pre"+posY);
        circle(posX,posY,Radius*2);
        
       
   

  


  
  
  leaves.leafDisplay();
  
  
  
  
  
  
  //Matrix holen
  //popMatrix();
  //leaves.debugLeaves();
  //leaves.display();
 } 

 float Radius(){   
   float Radius = getLautstärke();
   println("Amplitude: " + Radius);
   RadiusKreis= map(Radius,0,0.02,100,300); // Amplitude wird hoch skalliert
   if(RadiusKreis>300){RadiusKreis=300;}
   if(RadiusKreis<100){RadiusKreis=100;}
   return RadiusKreis;
 } 

void captureEvent(Capture c) {
  c.read();
}
PVector MoveLeaf(PVector Leaf){
   println("velocity außerhalb:"+dist(posX,posY,Leaf.x,Leaf.y));
   println("playerPosx"+posX);
   println("playerPosy"+posY);
   println("Leafx"+ Leaf.x);
   println("Leafy"+ Leaf.y);
   println("radius"+Radius);
    if(((dist(posX,posY,Leaf.x,Leaf.y)<Radius) && (dist(posX,posY,Leaf.x,Leaf.y)>=0)) || (dist(posX,posY,Leaf.x,Leaf.y)>((-1)*Radius) && (dist(posX,posY,Leaf.x,Leaf.y)<=0))  ){
      println("velocity:"+dist(posX,posY,Leaf.x,Leaf.y));
    float velocityLeaf=(Radius-dist(posX,posY,Leaf.x,Leaf.y))*0.01;
    println("velocityafternerf"+velocityLeaf);
    float xDiffrence=Leaf.x-posX;
    float yDiffrence=Leaf.y-posY;
    println("xDiffrence"+ xDiffrence);
    println("yDiffrence"+ yDiffrence);
    PVector leafVector= new PVector(xDiffrence,yDiffrence,velocityLeaf);
    println("leafvec"+ leafVector);
    return leafVector;
    }else{
      println("Error");
      PVector Error= new PVector(0,0,0);
      return Error;
    }
  }
float getLautstärke() {
  return input.mix.level();
}

void mouseClicked(){
  println(mouseX + ";" + mouseY);
  exit();
}

void stop() {
  // Close the Minim audio input when the program stops
  input.close();
  minim.stop();
  super.stop();
}
