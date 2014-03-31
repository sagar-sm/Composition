//Sagar Mohite, 2014.
//-------------------------------------------------------------------------------------
//NOTE: This sketch might need calibration on different machines to run properly.
//Please increment/decrement the _CALIBRATION variable by 0.001 precision until desired results are obtained.
//i.e. Aim to get the initial red trigonometric function in sync with the beats of the song.
//-------------------------------------------------------------------------------------
//La Valse D'Amelie (Orchestra Version) by Yann Tiersen.

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

float _CALIBRATION = 0.019;

Minim minim;
AudioPlayer song;
FFT fft;
PeasyCam camera;
PShader blur;

ArrayList<PVector> mat;
PVector loc, speed;
float angularV = 0;

void setup(){
  size(displayWidth, displayHeight, P3D);
  background(255);
  minim = new Minim(this);
  song = minim.loadFile("song.mp3", 512);
  song.play();
  
  mat = new ArrayList<PVector>();
  speed = new PVector(0,0);
  loc = new PVector(0,0);
  fft = new FFT(song.bufferSize(), song.sampleRate());
  //camera = new PeasyCam(this, width/2, height/2, 700, 50);
  for(int i = 0; i < 4; i++)
    mat.add(new PVector(0,0,35));
  blur = loadShader("blur.glsl");
}

float change = 0;
PVector v = new PVector(0,0);

void draw(){
  fft.forward(song.mix);
  noStroke();
  smooth();
  filter(blur);
  fill(242,0,52);
  ellipse(frameCount%width, height/2+(70*sin(tan(frameCount*_CALIBRATION))), 4, 4);
  float r = random(20);
  if(fft.getBand(2)>14){
    fill(0,117,242);
    ellipse(random(width), random(height),r,r);
  }
  if(fft.getBand(7)>10 && frameCount > 1000){
    fill(255,251,8);
    ellipse(random(width), random(height),r,r);
  }
  if(fft.getBand(11)>7 && frameCount > 1000){
    fill(173,8,255);
    ellipse(random(width), random(height),r,r);
  }
  if(fft.getBand(15)>15 && frameCount > 1000){
    fill(0,245,49);
    ellipse(random(width), random(height),r,r);
  }
  if(fft.getBand(17)>7 && frameCount > 1000){
    fill(255,1,1);
    ellipse(random(width), random(height),r,r);
  }
  
  if((fft.getBand(24)>8 || fft.getBand(25)>7) && frameCount >1000){
    angularV = fft.getBand(25);
    loc.set(width + 500*sin(frameCount + angularV), height + 500*cos(frameCount + angularV));
    ellipse(loc.x, loc.y, 70, 70);
    loc.set(width + 500*sin(frameCount + angularV), height + 500*cos(frameCount + angularV));
    ellipse(loc.x, loc.y, 70, 70);
    loc.set(width + 300*sin(frameCount + angularV), height + 300*cos(frameCount + angularV));
    ellipse(loc.x-width, loc.y-height, 70, 70);
    loc.set(width + 300*sin(frameCount + angularV), height + 300*cos(frameCount + angularV));
    ellipse(loc.x-width, loc.y-height, 70, 70);
  }
  
  if(fft.getBand(28)>9 || fft.getBand(34)>9 || fft.getBand(35)>9 ){
    stroke(random(255),random(255),random(255));
    line(random(width),0,random(width),height);
    
  }
}

boolean sketchFullScreen(){
  return true;
}
