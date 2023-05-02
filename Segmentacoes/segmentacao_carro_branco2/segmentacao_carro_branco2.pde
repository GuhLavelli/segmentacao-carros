void setup() {
  size(400, 266);
  //noLoop();
}

void draw() {

  PImage img = loadImage("car.jpg");
  Filtros imgCinza = new Filtros(img, 400, 300);

  imgCinza.setImg(autoescala(img));
  imgCinza.setImg(imgCinza.filtroGauss(0, height, 0, width, 2));

  PImage img2 = imgCinza.getImg();
  // Filtro de Limiarização
  for (int y = 0; y < img2.height; y++) {
    for (int x = 0; x < img2.width; x++) {
      int pos = y*img2.width + x;
      //Capo e metade primeira porta
      if ((red(img2.pixels[pos]) > 195 && y > 132 && y < 240 && x > 70 && x < 299))
        img2.pixels[pos] = color(255);

      else if (red(img2.pixels[pos]) > 130 && y > 145 && y < 200 && x > 103 && x < 257)
        img2.pixels[pos] = color(255);


      else if ((red(img2.pixels[pos]) > 130 && y > 200 && y < 240 && x > 300 && x < 362))
        img2.pixels[pos] = color(255);

      else if (red(img2.pixels[pos]) > 130 && y > 200 && y < 240 && x > 250 && x < 315)
        img2.pixels[pos] = color(255);

      else if (red(img2.pixels[pos]) < 180 && y > 177 && y < 214 && x > 297 && x < 365)
        img2.pixels[pos] = color(255);
     

        else img2.pixels[pos] = color(0);
    }
  }



  bresenham(140, 250, 170, 300, img2);
  bresenham(132, 195, 140, 250, img2);
  bresenham(170, 300, 177, 334, img2);
  bresenham(240, 310, 240, 338, img2);
  bresenham(240, 338, 230, 360, img2);
  bresenham(230, 360, 221, 357, img2);
  bresenham(221, 357, 213, 363, img2);
  bresenham(206, 84, 219, 130, img2);
  bresenham(231, 248, 239, 310, img2);
  
  imgCinza.setImg(img2);
  imgCinza.setImg(imgCinza.floodFill(160, 257));
  imgCinza.setImg(imgCinza.floodFill(150, 188));
  imgCinza.setImg(imgCinza.floodFill(223, 345));
  imgCinza.setImg(imgCinza.floodFill(195, 304));
  imgCinza.setImg(imgCinza.floodFill(192, 101));
  imgCinza.setImg(imgCinza.floodFill(192, 101));
  imgCinza.setImg(imgCinza.floodFill(216, 254));
  imgCinza.setImg(imgCinza.floodFill(189, 315));
  imgCinza.setImg(imgCinza.floodFill(220, 276));
  imgCinza.setImg(imgCinza.floodFill(228, 283));
  imgCinza.setImg(imgCinza.floodFill(230, 265));
  imgCinza.setImg(imgCinza.floodFill(235, 266));
  imgCinza.setImg(imgCinza.floodFill(153, 103));
  imgCinza.setImg(imgCinza.floodFill(186, 298));
  imgCinza.setImg(imgCinza.floodFill(211, 105));


  image(imgCinza.getImg(), 0, 0);

  imgCinza.setImg(img2);
  
  float x1 = 112;
  float y1 = 207;
  float x2 = 280;
  float y2 = 229;
  float radius = 22;
  noStroke();
  fill(255);
  ellipse(x1, y1, radius*2, radius*2);
  ellipse(x2, y2, radius*2, radius*2);

  fill(0, 0, 255);
  text("X: " + mouseX + " Y: " + mouseY, mouseX -50, mouseY);


  save("car_segmentado.png");
}
PImage autoescala(PImage img) {
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

  PImage imgEq = createImage(400, 300, RGB);

  //Vermelho AZUL

  for (int y = 0; y<img.height; y++) {
    for (int x = 0; x<img.width; x++) {
      if (x > 300) {
        int pos = y*img.width + x;
        int cor = nsk[int(red(img.pixels[pos]))];
        imgEq.pixels[pos] = color(cor);
      } else {
        int pos = y*img.width + x;
        int cor = nsk[int(green(img.pixels[pos]))];
        imgEq.pixels[pos] = color(cor);
      }
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
