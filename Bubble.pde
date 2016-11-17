// A Bubble class

class Bubble {
  float x, y;
  float diameter;
  float width=random(30);
  float height=random(30);
  String name;
  String l;
  boolean over = false;
  color c;
  // Create  the Bubble
  Bubble(float x_, float y_, float diameter_, String s) {
    x = x_;
    y = y_;
    diameter=diameter_;
    diameter_=((width+height)/2);
    name = s;
  }

  // CHecking if mouse is over the Bubble
  void rollover(float px, float py) {
    float d = dist(px, py, x, y);
    if (d < width/2) {
      over = true;
    }else if (d<height/2)
    { over = true;
    } else {
      over = false;
    }
  }

  // Display the Bubble
  void display() {
   
    if (name.equals("sad")) {
      c = color(255, 0, 0);
    } else if(name.equals("happy")){
     c = color(0,255,0); 
    } else if(name.equals("calm")){
      c = color(0,0,255);
    }
    else {
      c = color(random(255),random(255),random(255));
    }
    stroke(0);
    strokeWeight(2);
    fill(c);
    rect(x, y, diameter, diameter);
    if (over) {
      fill(c);
      textAlign(CENTER);
      text(name, x, y+diameter/2+15);
    }
  }
}