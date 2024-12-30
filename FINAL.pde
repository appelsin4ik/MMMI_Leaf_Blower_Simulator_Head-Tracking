import gab.opencv.*;
import processing.video.*;
import java.awt.*;

PImage grass;
Capture video;
OpenCV opencv;
Blower blower;
Leaves leaves;

void setup() {
  size(640, 800);
  
  grass = loadImage("grass.jpg");

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

  video = new Capture(this, 640/2, 480/2, cameras[0]);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);

  blower = new Blower();
  
  leaves = new Leaves(15);

  video.start();
  
}

void draw() {
  
  background(220);
  
  //Saves the Matrix (display)
  pushMatrix();
  
  scale(2);
  
  opencv.loadImage(video);
  
  
  //image(grass,0,50);
  
  image(video, 0, 0);
  
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  
  Rectangle[] faces = opencv.detect();
  
  int headMovement = 0;
  
  if (faces.length > 0) {
    if (faces[0].x < 80) {
      // Kopf bewegt sich nach links
      headMovement = -1;
    } else if (faces[0].x > 120) {
      // Kopf bewegt sich nach rechts
      headMovement = 1;
    }
    
    // Vertikale Bewegung
    if (faces[0].y < 60) {
      headMovement = 2;
    } else if (faces[0].y > 100) {
      headMovement = 3;
    }
    
    blower.move(headMovement);
    
    // Gesichtserkennung visualisieren
    for (int i = 0; i < faces.length; i++) {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
    

    
  }
  
  blower.display();
  //blower.say();
  
  popMatrix();
  
  leaves.display();
  leaves.checkCollision(blower);
  
}

void captureEvent(Capture c) {
  c.read();
}

void mouseClicked(){
  println(mouseX + ";" + mouseY);
}
