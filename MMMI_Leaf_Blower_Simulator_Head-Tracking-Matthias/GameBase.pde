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


PGraphics graphics;
Capture video;
OpenCV opencv;
Player player;
Leaves leaves;    
int camWidth = 640;
int camHeight = 360;
Rectangle playerPos = new Rectangle(0,0,0,0);
int[] pPosX;
int[] pPosY;
float rotation, objectWidth = 50, objectHeight = 50;




Rectangle[] faces = new Rectangle[0]; // Initialisieren mit leerem Array



/*void settings(){          //braucht man um size mit variablen zu machen aber size(...,...) oder
                            //   fullscreen() setzt height und width (siehe println unten)
size(width, height);
}*/

void setup() {
  //Fenster Größe
  fullScreen();
  //size(1920, 1080);  
  frameRate(60);
   camWidth = width/3;
   camHeight = height/3;
  
  //Test um Fenstergröße zu checken
  println("width"+width);
  println("height"+height);
  
 



  
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
  
  
  //Gesichserkennung
  video = new Capture(this, camWidth, camHeight, cameras[0]);  //Größe des Kamerafensters
  opencv = new OpenCV(this, camWidth, camHeight);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);   //gesamtes gesicht wird erkannt

  
  
         
  
  
  //Erstellen von Leaves + -> Klasse
  leaves = new Leaves( 15, width, height);
  leaves.debugLeaves();
  

  
  
  
  //Erstellen von Player + -> Klasse
  player = new Player();
  
  video.start();
  
}





void draw() {     

  //Hintergrund Rasen
  PImage grass;
  grass = loadImage("grass.jpg");    //später schöneres Bild von Gras oder Rasen nehmen oder Pixelart selbst erstellen
  grass.resize(width,height);
  background(grass);
   
  
  //Saves the Matrix (display)
  //pushMatrix();
  
  
  
  opencv.loadImage(video);
  image(video, 0, 0);  //Position des Kamerafensters
  noFill();            //Rechteck wird nicht gefüllt (Rechteck Gesicht)
  stroke(0, 255, 255); //Farbe vom Rechteck
  strokeWeight(3);     //Liniendicke Rechteck
   
  
  
  
  
  
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
  
 /* for (int i = 0; i <= faces.length; i++) {
  //faces[i].x = playerPos.x;
  //faces[i].y = playerPos.y;
  //faces[i].width = playerPos.width;
  //faces[i].height = playerPos.height;
  
   pPosX[i] = faces[i].x;
   pPosY[i] = faces[i].y;
  
  }*/
  
    leaves.display();


  if (faces != null && faces.length > 0) {
    //System.out.println("Faces vor der Übergabe: " + Arrays.toString(faces));
  
    
    fill(255, 0, 0);
    noStroke();

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
                           
      //  rect(playerPos[i].x - objectWidth / 2 + width/2, playerPos[i].y - objectHeight / 2 + height/2, objectHeight, objectWidth); //Position Spieler Rechteck auf Spielfeld
      //  rect(playerPos[i].x - objectWidth / 2 * width / camWidth, playerPos[i].y - objectHeight / 2 * height / camHeight, objectHeight, objectWidth); //Position Spieler Rechteck auf Spielfeld
         rect(playerPos[i].x * 4 - objectWidth / 2 , playerPos[i].y  * 4 - objectHeight / 2 , objectHeight, objectWidth); //Position Spieler Rechteck auf Spielfeld
        
        noFill();
        stroke(0, 255, 255); 
        strokeWeight(3);
        ellipse(playerPos[i].x + width/2, playerPos[i].y + height/2, 200, 200);
    }

    System.out.println("Faces am Ende: " + Arrays.toString(faces));      
  } else {
    System.out.println("Keine faces erkannt oder Array ist leer.");
  }

  


  
  

  
  
  
  
  
  
  //Matrix holen
  //popMatrix();
  //leaves.debugLeaves();
  //leaves.display();
  
}

void captureEvent(Capture c) {
  c.read();
}

void mouseClicked(){
  println(mouseX + ";" + mouseY);
}
