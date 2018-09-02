/**********************************
 **** Michal Huller
 **** Nkaleido new kaleidoscop
 **** On 28 July 2015
 **********************************/
import javax.swing.*; 
import java.util.Calendar;
PImage pic;
boolean rotateIt = false;
PImage scrShot;
PImage sqrSource;
PGraphics buf;
PGraphics toCopyImg;
boolean shouldRotate=false;

color bg = 0;
int fac = 16;

/////// setup ///////////////
void setup() {
  size(800, 800);
  buf = createGraphics(width, 2*height);
  //toCopyImg = createGraphics(2*width,2*height);
  imageMode(CENTER);
  smooth();
  fc = new JFileChooser();
  if (openFileAndGetImage() == 0)
    exit();
  background(bg);
  //frameRate(10);
  noLoop();
  initit();
}

void draw() {
  background(bg);
  CreateTriangle();
  
  translate(width/2, height/2);
  image(mesh, 0,0);
  
  for (int i=0; i < fac/2; i++) {
    rotate(2*TWO_PI/fac);
    image(mesh, 0,0);
  }
}

public void initit() {
  buf.beginDraw();
  sqrSource = original.get(int(random(original.width-width/2)),
    int(random(original.height - height/2)),width/2, height/2);
  background(bg);
}

void keyPressed() {
  if (key == 'n' || key == 'N') {
    buf.endDraw();
    initit();
    redraw();
  }

  if (key == 'o' || key =='O') {
    if (openFileAndGetImage() == 0)
      exit();
    background(bg);
    initit();
    redraw();
  }
  
  if (key == 'r' || key =='R') { // rotate or not
    shouldRotate = !shouldRotate;
    println("rotate? "+ shouldRotate);
    if (openFileAndGetImage() == 0)
      exit();
    background(bg);
    initit();
    redraw();
  }

  if (key == ' ') {
    background(bg);
    initit();
    redraw();
  }

  if (key == 's' || key == 'S' || key == 'p' || key == 'P') {
    int numR = int(random(5000));
    String fname="snapshot/fl_" + year() + month() + day() + "_" + frameCount +"_" + numR + ".png";
    scrShot=get(0, 0, width, height);
    scrShot.save(fname);
  }

  if (key =='1') {
    fac -= 2;
    if (fac < 6) fac = 6;
    redraw();
  }
  if (key =='2') {
    fac += 2;
    redraw();
  }
}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}