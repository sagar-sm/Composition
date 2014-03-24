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

Minim minim;
AudioPlayer song;
FFT fft;
PeasyCam camera;

ArrayList<PVector> mat;

void setup(){
  size(512, 512, P3D);
  background(0);
  minim = new Minim(this);
  song = minim.loadFile("song.mp3", 512);
  song.play();
  
  mat = new ArrayList<PVector>();
  
  fft = new FFT(song.bufferSize(), song.sampleRate());
  //camera = new PeasyCam(this, width/2, height/2, 500, 50);
  for(int i = 0; i < width; i+=24)
    for(int j = 0; j < height; j+=24)
      mat.add(new PVector(i,j,0));
}

float change = 0;
PVector v = new PVector(0,0);

void draw(){
  background(0);
  fft.forward(song.mix);
  stroke(155);
    for(PVector p : mat){
    ellipse(p.x,p.y,p.z,p.z);
    //println(p.x + " " + p.y);
  }
  for(int i = 0; i < fft.specSize(); i++){
    //line(i, height, i, height - fft.getBand(i)*20);
    mat.get(i).x += pow(-1,i)*fft.getBand(i)*3;
    mat.get(i).y += pow(-1,i)*fft.getBand(i)*3;
    
    mat.get(i).z += pow(-1,i)*fft.getBand(i);
  }
  //smooth();
  stroke(255);
  
  float x, y;
  for(int i = 0; i < song.left.size() - 1; i++)
  {
    //change = lerp(change, song.left.get(i)*200, 0.1);
    change = song.left.get(i)*200;
    x = song.left.get(i)*width*2;
    y = song.right.get(i)*height*2;
    
    //translate(0, 0, change);
    //point(x,y);//*height/2);//, change);
    //line(10*i, 50 + song.left.get(i)*200, 10*(i+1), 50 + song.left.get(i+1)*200);
    //line(i, 150 + song.right.get(i)*50, i+1, 150 + song.right.get(i+1)*50);
  }
}
