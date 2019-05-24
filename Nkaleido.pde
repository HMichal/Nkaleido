/**********************************
 **** Michal Huller
 **** Nkaleido new kaleidoscop
 **** On 28 July 2015
 **********************************/
import javax.swing.*; 
PImage pic;
PImage scrShot;
PImage sqrSource;
PGraphics buf;
PGraphics toCopyImg;
boolean shouldRotate=false;
boolean pinot = false;
int qrSize;

color bg = 0;
int fac = 16;
JFileChooser fc;

/////// setup ///////////////
void setup() {
  size (900, 700); //(1280, 720)//size(800, 800);
  qrSize = max(width, height);
  buf = createGraphics(qrSize, 2*qrSize);
  //toCopyImg = createGraphics(2*width,2*height);
  imageMode(CENTER);
  smooth();
  fc = new JFileChooser("/home/michal/Pictures");
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
  if (pinot) {
    SetCorners();
  }
  // setup circle in the middle
  color ccm = get(0, 0);
  fill(ccm);
  noStroke();
  ellipse(0, 0, 10.0,10.0);
}

public void initit() {
  buf.beginDraw();
  sqrSource = original.get(int(random(original.width-qrSize/2)),
    int(random(original.height - qrSize/2)),qrSize/2, qrSize/2);
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
  if (key == 'c'|| key == 'C') {
    pinot = !pinot;
    redraw();
  }
}
