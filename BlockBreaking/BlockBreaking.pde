/**
Project 2 - Block Breaker
INFO17198
Ed Naus
Deanna Mak, Andre Byam, Oliver Ibbett, Jimmy Stewart, Alexie Crisostomo
April 16, 2016

**********************************************************************
** BASE CODE USED TO CREATE THIS WAS CPIN FROM THE IN-CLASS EXAMPLE **
**********************************************************************

**/

// import libraries
import com.onformative.leap.*;
import com.leapmotion.leap.Hand;
import processing.video.*;
import deadpixel.keystone.*;

// initialize global variables

LeapMotionP5 leap;

Keystone ks;
CornerPinSurface surface1;
CornerPinSurface surface2;
CornerPinSurface surface3;

PGraphics offscreen1;
PGraphics offscreen2;
PGraphics offscreen3;

boolean lPlay=false;
boolean rPlay=false;
boolean tPlay=false;

Movie mov1;
Movie mov2;
Movie mov3;

int counter;
boolean run=true;
Movie currentMov;

PImage pickaxe, shovel, axe, currImg;

void setup() {
  size(1029, 1080, P3D);
  
  ks = new Keystone(this);
  surface1 = ks.createCornerPinSurface(400, 400, 20);
  surface2 = ks.createCornerPinSurface(400, 400, 20);
  surface3 = ks.createCornerPinSurface(400, 400, 20);
  
  offscreen1 = createGraphics(400, 400, P3D);
  offscreen2 = createGraphics(400, 400, P3D);
  offscreen3 = createGraphics(400, 400, P3D);

  leap = new LeapMotionP5(this);
  // set movies
  mov1 = new Movie(this, "rock.mp4") {
    @ Override public void eosEvent() {
      super.eosEvent();
      myEoS();
    }
  };
  mov1.loop();
  mov1.pause();
  mov2 = new Movie(this, "wood.mp4") {
    @ Override public void eosEvent() {
      super.eosEvent();
      myEoS();
    }
  };
  mov2.loop();
  mov2.pause();
  mov3 = new Movie(this, "dirt.mp4") {
    @ Override public void eosEvent() {
      super.eosEvent();
      myEoS();
    }
  };
  mov3.loop();
  mov3.pause();

  counter=0;
  // set pointer images
  pickaxe = loadImage("pick.png");
  shovel = loadImage("shovel.png");
  axe = loadImage("axe.png");
  
  currImg=pickaxe;
}

void draw() {
  PVector surface1Mouse = surface1.getTransformedMouse();
  PVector surface2Mouse = surface2.getTransformedMouse();
  PVector surface3Mouse = surface3.getTransformedMouse();
  // if random element is rock
  if (counter==0) {
    currentMov=mov1;
    
    offscreen1.beginDraw();
    offscreen1.background(255);
    offscreen1.fill(0, 255, 0);
    offscreen1.ellipse(surface1Mouse.x, surface1Mouse.y, 75, 75);
    if (mov1.available()) {
      mov1.read();
    }
    offscreen1.image(mov1, 0, 0);
    offscreen1.endDraw();

    offscreen2.beginDraw();
    offscreen2.background(255);
    offscreen2.fill(0, 255, 0);
    offscreen2.ellipse(surface2Mouse.x, surface2Mouse.y, 75, 75);
    offscreen2.image(mov1, 0, 0);
    offscreen2.endDraw();

    offscreen3.beginDraw();
    offscreen3.background(255);
    offscreen3.fill(0, 255, 0);
    offscreen3.ellipse(surface3Mouse.x, surface3Mouse.y, 75, 75);
    offscreen3.image(mov1, 0, 0);
    offscreen3.endDraw();
    if (tPlay==true) {
      mov1.play();
    } else {
      mov1.pause();
    } 
  }
  // if random element is wood
  if (counter==1) {
    currentMov=mov2;
    
    offscreen1.beginDraw();
    offscreen1.background(255);
    offscreen1.fill(0, 255, 0);
    offscreen1.ellipse(surface1Mouse.x, surface1Mouse.y, 75, 75);
    if (mov2.available()) {
      mov2.read();
    }
    offscreen1.image(mov2, 0, 0);
    offscreen1.endDraw();

    offscreen2.beginDraw();
    offscreen2.background(255);
    offscreen2.fill(0, 255, 0);
    offscreen2.ellipse(surface2Mouse.x, surface2Mouse.y, 75, 75);
    offscreen2.image(mov2, 0, 0);
    offscreen2.endDraw();

    offscreen3.beginDraw();
    offscreen3.background(255);
    offscreen3.fill(0, 255, 0);
    offscreen3.ellipse(surface3Mouse.x, surface3Mouse.y, 75, 75);
    offscreen3.image(mov2, 0, 0);
    offscreen3.endDraw();
    if (rPlay==true) {
      mov2.play();
    } else {
      mov2.pause();
    }
  }
  // if random element is dirt
  if (counter==2) {
    currentMov=mov3;
    
    offscreen1.beginDraw();
    offscreen1.background(255);
    offscreen1.fill(0, 255, 0);
    offscreen1.ellipse(surface1Mouse.x, surface1Mouse.y, 75, 75);
    if (mov3.available()) {
      mov3.read();
    }
    offscreen1.image(mov3, 0, 0);
    offscreen1.endDraw();

    offscreen2.beginDraw();
    offscreen2.background(255);
    offscreen2.fill(0, 255, 0);
    offscreen2.ellipse(surface2Mouse.x, surface2Mouse.y, 75, 75);
    offscreen2.image(mov3, 0, 0);
    offscreen2.endDraw();

    offscreen3.beginDraw();
    offscreen3.background(255);
    offscreen3.fill(0, 255, 0);
    offscreen3.ellipse(surface3Mouse.x, surface3Mouse.y, 75, 75);
    offscreen3.image(mov3, 0, 0);
    offscreen3.endDraw();
    if (lPlay==true) {
      mov3.play();
    } else {
      mov3.pause();
    }
  }
if (!run){
  currentMov.stop();
  run=true;
  counter=(int)(Math.random()*3);
}

  background(0);

  // render the screens
  surface1.render(offscreen1);
  surface2.render(offscreen2);
  surface3.render(offscreen3);

  // draw hand
  fill(255);
  for (Hand hand : leap.getHandList()) {
    PVector handPos=leap.getPosition(hand);
    image(currImg, handPos.x, handPos.y, 100, 100);

    if (handPos.x > 800 && handPos.y > 200 && rPlay == false) {
      rPlay = true;
      lPlay = false;
      tPlay = false;
      currImg=axe;
    } 
    if (handPos.x < 400 && handPos.y > 200 && lPlay == false) {
      rPlay = false;
      lPlay = true;
      tPlay = false;
      currImg=shovel;
    }
    if (handPos.y < 200 && tPlay == false) {
      rPlay = false;
      lPlay = false;
      tPlay = true;
      currImg=pickaxe;
    }
  }
}
void stop() {
  leap.stop();
}

void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surface1s can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  }
}
// detects if video is over
void myEoS() {
  run = false;
}
