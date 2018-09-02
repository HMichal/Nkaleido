PImage mesh;
PImage maskImage;

void CreateTriangle() {
  int unit1 = height/2;
  mesh = createImage(width, 2*height, RGB);
  sqrSource.loadPixels();
  mesh.loadPixels();

  for (int j=2*unit1+2; j >= unit1; j--) {
    for (int i=0; i< width/2; i++) {
      mesh.pixels[i + j*width] = 
        sqrSource.pixels[min(i, sqrSource.width-1) + 
        min(j - unit1, sqrSource.height-1)*sqrSource.width];

      mesh.pixels[width-i-1 + j*width] = 
        sqrSource.pixels[min(i, sqrSource.width-1) + 
        min(j - unit1, sqrSource.height-1)*sqrSource.width];

      mesh.pixels[i + (2*unit1+2-j)*width] = 
        sqrSource.pixels[min(i, sqrSource.width-1) + 
        min(j - unit1, sqrSource.height-1)*sqrSource.width];

      mesh.pixels[width-i-1 + (2*unit1+2-j)*width] = 
        sqrSource.pixels[min(i, sqrSource.width-1) + 
        min(j - unit1, sqrSource.height-1)*sqrSource.width];
    }
  }

  //fillup mask
  //============
  buf.background(0);
  buf.stroke(255);
  buf.strokeWeight(1.66);
  //noStroke();
  buf.fill(255);
  float zavit=abs(tan(TWO_PI/fac));

  buf.triangle(float(width)/2, float(height), 
  float(width)/2 - (float(height)/2)*zavit, height/2, 
  float(width)/2 +  (float(height)/2)*zavit, height/2);
/*
  buf.triangle(float(width)/2, 0.0, 
  float(width)/2 - (float(height)/2)*zavit, height/2, 
  float(width)/2 +  (float(height)/2)*zavit, height/2);
*/
  buf.rect(float(width)/2 - (float(height)/2)*zavit, 0.0,
  float(width)/2 +  (float(height)/2)*zavit, height/2);
  mesh.updatePixels();
  maskImage = buf.get();
  mesh.mask(maskImage);
}

