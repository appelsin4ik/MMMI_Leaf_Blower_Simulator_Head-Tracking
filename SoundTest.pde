import ddf.minim.*;


Minim minim;
AudioInput input;

float RadiusKreis=0;
void setup() {
  size(1000, 1000);
  minim = new Minim(this);

  // Audio Input
  input = minim.getLineIn(Minim.MONO, 1024);

 
}

void draw() {
  background(30);
  
  float Radius = getLautstärke();
   println("Amplitude: " + Radius);
  RadiusKreis= map(Radius,0,0.02,50,300); // Amplitude wird hoch skalliert
  // Draw the circle
  fill(100, 150, 255);
  noStroke();
  circle(500,500,RadiusKreis);
}

float getLautstärke() {
  return input.mix.level();
}

void stop() {
  // Close the Minim audio input when the program stops
  input.close();
  minim.stop();
  super.stop();
}
