PImage mesh;
PImage maskImage;

void CreateTriangle() {
  int unit1 = qrSize/2;
  mesh = createImage(qrSize, 2*qrSize, RGB);
  sqrSource.loadPixels();
  mesh.loadPixels();

  for (int j=2*unit1+2; j >= unit1; j--) {
    for (int i=0; i< width/2; i++) {
      mesh.pixels[i + j*qrSize] = 
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

  buf.triangle(float(qrSize)/2, float(qrSize), 
    float(qrSize)/2 - (float(qrSize)/2)*zavit, qrSize/2, 
    float(qrSize)/2 +  (float(qrSize)/2)*zavit, qrSize/2);
  
  buf.rect(float(qrSize)/2 - (float(qrSize)/2)*zavit, 0.0, 
    float(qrSize)/2 +  (float(qrSize)/2)*zavit, qrSize/2);
  mesh.updatePixels();
  maskImage = buf.get();
  mesh.mask(maskImage);
}

// ************************* Set new Corners ******************8
void SetCorners() {
  pushMatrix();
  float fzela = (sqrt(2) - 1) * width/2;
  int zela = int(fzela);
  if (zela % 2 == 1) zela++;
  translate (-width/2, -height/2);

  // 1st corner
  PImage ribua = get(width -zela, 0, zela, zela);

  for (int ix= 0; ix < zela; ix++) {
    for (int iy= 0; iy < zela; iy++) {
      if (ix < iy)
        ribua.set(iy, ix, ribua.get(ix, iy));
    }
  }
  image(ribua, width -zela/2, zela/2);

  //2nd corner
  ribua = get(0, 0, zela, zela);
  for (int ix= 0; ix < zela; ix++) {
    for (int iy= 0; iy < zela; iy++) {
      if (zela -ix >=  iy)
        ribua.set(iy, ix, ribua.get(zela -ix -1, zela - iy -1));
    }
  }
  image(ribua, zela/2, zela/2);

  // 3rd corner
  ribua = get(width -zela, height -zela, zela, zela);
  for (int ix= 0; ix < zela; ix++) {
    for (int iy= 0; iy < zela; iy++) {
      if (ix > zela - iy)
        ribua.set(iy, ix, ribua.get(zela -ix -1, zela - iy -1));
    }
  }
  image(ribua, width -zela/2, height -zela/2);

  // 4th corner
  ribua = get(0, height -zela, zela, zela);
  for (int ix= 0; ix < zela; ix++) {
    for (int iy= 0; iy < zela; iy++) {
      if (ix < iy)
        ribua.set(ix, iy, ribua.get(iy, ix));
    }
  }
  image(ribua, zela/2, height -zela/2);
  popMatrix();
}
