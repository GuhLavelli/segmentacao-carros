void setup() {
  size(400, 267);
  noLoop();
}

void draw() {
  PImage imgOrig = loadImage("carro_tokyo.jpg");
  Filtros img = new Filtros(imgOrig, width, height);
  img.setImg(autoEscala(imgOrig));

  img.setImg(img.filtroGauss(0, height, 0, width, 2));
  imgOrig = img.getImg();
  for (int y=0; y<height; y++) {
    for (int x=0; x<width; x++) {
      int pos = y*width + x;
      //Traseira
      if (red(imgOrig.pixels[pos]) > 122 && y > 65 && y < 190 && x > 30 && x < 130)
        imgOrig.pixels[pos] = color(255);
      //Roda Traseira
      else if (red(imgOrig.pixels[pos]) < 20 && y >120 && y < 175 && x > 35 && x < 75)
        imgOrig.pixels[pos] = color(255);
      //Parabrisa e teto
      else if (red(imgOrig.pixels[pos]) < 110 && y > 72 && y < 135 && x > 100 && x < 190)
        imgOrig.pixels[pos] = color(255);
      //Teto bound box branca 1
      else if (red(imgOrig.pixels[pos]) < 255 && y > 72 && y < 135 && x > 100 && x < 140)
        imgOrig.pixels[pos] = color(255);
      //Teto bound box branca 2
      else if (red(imgOrig.pixels[pos]) < 255 && y > 77 && y < 135 && x > 152 && x < 180)
        imgOrig.pixels[pos] = color(255);
      //Parabrisa 2
      else if (red(imgOrig.pixels[pos]) < 12 && y > 75 && y < 135 && x > 185 && x < 218)
        imgOrig.pixels[pos] = color(255);
      //Capo
      else if (red(imgOrig.pixels[pos]) > 50 && y > 108 && y < 194 && x > 120 && x < 292)
        imgOrig.pixels[pos] = color(255);
      //Capo 2
      else if (red(imgOrig.pixels[pos]) > 135 && y > 145 && y < 240 && x > 170 && x < 335)
        imgOrig.pixels[pos] = color(255);
      //Roda dianteira
      else if (red(imgOrig.pixels[pos]) < 25 && y > 150 && y < 230 && x > 133 && x < 236)
        imgOrig.pixels[pos] = color(255);
      //Box branca (Roda dianteira)
      else if (red(imgOrig.pixels[pos]) >= 0 && y > 145 && y < 194 && x > 117 && x < 195)
        imgOrig.pixels[pos] = color(255);
      //Box branca (Aerofolio traseira)
      else if (red(imgOrig.pixels[pos]) >= 0 && y > 93 && y < 117 && x > 48 && x < 65)
        imgOrig.pixels[pos] = color(255);
      //Box branca (Capo)
      else if (red(imgOrig.pixels[pos]) >= 0 && y > 108 && y < 142 && x > 185 && x < 240)
        imgOrig.pixels[pos] = color(255);
      //Box branca (Capo)
      else if (red(imgOrig.pixels[pos]) >= 0 && y > 176 && y < 19 && x > 295 && x < 315)
        imgOrig.pixels[pos] = color(255);
      else imgOrig.pixels[pos] = color(0);
    }
  }




  //Fecha o contorno utilizando bresehnham para os lugares onde não foi possivel segmentar por completo
  bresenham(227, 186, 188, 113, imgOrig);
  bresenham(156, 41, 137, 36, imgOrig);
  bresenham(167, 47, 175, 86, imgOrig);
  bresenham(78, 188, 113, 238, imgOrig);
  bresenham(118, 259, 123, 279, imgOrig);
  bresenham(122, 291, 135, 315, imgOrig);
  bresenham(135, 315, 148, 326, imgOrig);

  img.setImg(imgOrig);
  //Pinta as lacunas que o filtro de limiar não pegou
  img.setImg(img.floodFill(202, 158));
  img.setImg(img.floodFill(145, 44));
  img.setImg(img.floodFill(98, 192));
  img.setImg(img.floodFill(204, 184));
  img.setImg(img.floodFill(202, 162));
  img.setImg(img.floodFill(218, 155));
  img.setImg(img.floodFill(199, 285));
  img.setImg(img.floodFill(179, 321));
  img.setImg(img.floodFill(136, 298));
  img.setImg(img.floodFill(123, 263));
  img.setImg(img.floodFill(120, 248));
  img.setImg(img.floodFill(155, 305));
  img.setImg(img.floodFill(199, 269));
  img.setImg(img.floodFill(200, 250));
  img.setImg(img.floodFill(229, 247));
  img.setImg(img.floodFill(82, 191));
  img.setImg(img.floodFill(125, 280));

  //img.setImg(img.filtroGauss(0, height, 0, width, 1));

  image(img.getImg(), 0, 0);
  save("carro_tokyo_segmentado.jpg");

/*
  fill(255, 0, 0);
  text("X: " + mouseX + " Y: " + mouseY, mouseX, mouseY);
  text("RGB: " + red(imgOrig.pixels[mouseY*width+mouseX]), 20, 20);
*/
}




PImage autoEscala(PImage img) {
  int[] hist = new int[256];

  for (int i = 0; i < 256; i++) {
    hist[i] = 0;
  }

  //Gera o histograma
  for (int y = 0; y<img.height; y++) {
    for (int x =0; x<img.width; x++) {
      int pos = y*img.width + x;
      int valor = int(red(img.pixels[pos]));
      hist[valor]++;
    }
  }

  float p[] = new float[256];
  for (int i = 0; i<256; i++) {
    p[i] = float(hist[i])/(img.width*img.height);
  }

  float sk[] = new float[256];
  float somatorio = 0;
  for (int i=0; i<256; i++) {
    somatorio += p[i];
    sk[i] = somatorio;
  }

  int[] nsk = new int[256];
  for (int i = 0; i<256; i++) {
    nsk[i] = int(sk[i] * 255 + 0.5); //(256-1);
  }

  PImage imgEq = createImage(width, height, RGB);

  //Vermelho AZUL

  for (int y = 0; y<img.height; y++) {
    for (int x = 0; x<img.width; x++) {

      int pos = y*img.width + x;
      int cor = nsk[int(blue(img.pixels[pos]))];
      imgEq.pixels[pos] = color(cor);
    }
  }
  return imgEq;
}


//Bresehan
void PlotarPixelxy(PImage image, int x, int y) {
  int pos = x*image.width + y;
  image.pixels[pos] = color(255);
}

int sign(int x) {
  if (x < 0) return -1;
  else if (x > 0) return 1;
  else return 0;
}

void bresenham(int x1, int y1, int x2, int y2, PImage img) {
  int x = x1;
  int y = y1;
  int dx = abs(x2-x1);
  int dy = abs(y2-y1);
  int s1 = sign(x2-x1);
  int s2 = sign(y2-y1);
  int interchange;
  if (dy > dx) {
    int temp = dx;
    dx = dy;
    dy = temp;
    interchange = 1;
  } else {
    interchange = 0;
  }
  int e = 2*dy - dx;

  for (int i = 1; i <= dx; i++) {
    PlotarPixelxy(img, x, y);
    while (e > 0) {
      if (interchange == 1) {
        x = x + s1;
      } else {
        y = y + s2;
      }
      e = e - 2*dx;
    }
    if (interchange == 1) {
      y = y + s2;
    } else {
      x = x + s1;
    }
    e = e + 2*dy;
  }
}
