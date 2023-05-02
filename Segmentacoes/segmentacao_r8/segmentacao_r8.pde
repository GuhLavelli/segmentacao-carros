void setup() {
  size(400, 300);
}

void draw() {
  PImage img = loadImage("r8.jpg");
  Filtros imgCinza = new Filtros(img, 400, 300);



  imgCinza.setImg(imgCinza.filtroCinza('B'));
  image(imgCinza.getImg(), 0, 0);
  save("imgcinza.png");
  imgCinza.setImg(imgCinza.filtroGauss(0, height, 0, width, 3));

  PImage img2 = imgCinza.getImg();
  // Filtro de Limiarização
  for (int y = 0; y < img2.height; y++) {
    for (int x = 0; x < img2.width; x++) {
      int pos = y*img2.width + x;
      //Carro Inteiro
      if ((red(img2.pixels[pos]) > 60 && y > 135 && y < 267 && x > 250 && x < 35))
        img2.pixels[pos] = color(255);
      //Metade do Carro (Parte de Cima)
      else if ((red(img2.pixels[pos]) > 20 && y > 130 && y < 218 && x > 91 && x < 255))
        img2.pixels[pos] = color(255);
      //Metade do Carro (Parte de Cima - TRASEIRA)
      else if ((red(img2.pixels[pos]) > 20 && y > 155 && y < 214 && x > 34 && x < 255))
        img2.pixels[pos] = color(255);
      //TRASEIRA-RODA
      else if ((red(img2.pixels[pos]) >= 0 && y > 185 && y < 220 && x > 34 && x < 180))
        img2.pixels[pos] = color(255);
      //TRASEIRA-RODA 2
      else if ((red(img2.pixels[pos]) >= 0 && y > 217 && y < 234 && x > 45 && x < 100))
        img2.pixels[pos] = color(255);
      //DIANTEIRA-RODA 2
      else if ((red(img2.pixels[pos]) >= 0 && y > 199 && y < 250 && x > 238 && x < 360))
        img2.pixels[pos] = color(255);
      //FRENTE 1
      else if ((red(img2.pixels[pos]) > 78 && y > 147 && y < 218 && x > 280 && x < 390))
        img2.pixels[pos] = color(255);
      //FRENTE 2
      else if ((red(img2.pixels[pos]) > 80 && y > 201 && y < 270 && x > 270 && x < 309))
        img2.pixels[pos] = color(255);
      //FRENTE 3
      else if ((red(img2.pixels[pos]) > 60 && y > 201 && y < 250 && x > 310 && x < 385))
        img2.pixels[pos] = color(255);
      //FRENTE 4
      else if ((red(img2.pixels[pos]) > 40 && y > 240 && y < 261 && x > 308 && x < 360))
        img2.pixels[pos] = color(255);
      //FRENTE GRADE (LINE)
      else if ((red(img2.pixels[pos]) > 0 && y > 205 && y < 220 && x == 384))
        img2.pixels[pos] = color(255);
      //FRENTE GRADE INFERIOR (LINE)
      else if ((red(img2.pixels[pos]) >= 0 && y > 225 && y < 245 && x == 378))
        img2.pixels[pos] = color(255);
      //RODA TRASEIRA
      else if ((red(img2.pixels[pos]) > 65 && y > 180 && y < 239 && x > 43 && x < 90))
        img2.pixels[pos] = color(255);
      //RODA DIANTEIRA
      else if ((red(img2.pixels[pos]) > 50 && y > 198 && y < 267 && x > 248 && x < 315))
        img2.pixels[pos] = color(255);
      //RODA DIANTEIRA - PARACHOQUE (LINE)
      else if ((red(img2.pixels[pos]) >= 0 && y == 260 && x > 290 && x < 315))
        img2.pixels[pos] = color(255);
      //VIDRO
      else if ((red(img2.pixels[pos]) > 28 && y > 142 && y < 180 && x > 220 && x < 308))
        img2.pixels[pos] = color(255);
      //Parte de baixo da porta
      else if ((red(img2.pixels[pos]) > 20 && y > 189 && y < 237 && x > 86 && x < 244))
        img2.pixels[pos] = color(255);
      //Parte de baixo da porta 2
      else if ((red(img2.pixels[pos]) > 20 && y > 233 && y < 245 && x > 115 && x < 320))
        img2.pixels[pos] = color(255);
      //Parte de baixo da porta 3
      else if ((red(img2.pixels[pos]) > 20 && y > 239 && y < 251 && x > 165 && x < 320))
        img2.pixels[pos] = color(255);
      //RETROVISOR (LINE)
      else if ((red(img2.pixels[pos]) >= 0 && y == 168 && x > 294 && x < 306))
        img2.pixels[pos] = color(255);

      else img2.pixels[pos] = color(0);
    }
  }
  imgCinza.setImg(img2);
  imgCinza.setImg(imgCinza.floodFill(168, 164));
  imgCinza.setImg(imgCinza.floodFill(162, 140));
  imgCinza.setImg(imgCinza.floodFill(166, 132));
  imgCinza.setImg(imgCinza.floodFill(194, 270));
  imgCinza.setImg(imgCinza.floodFill(157, 253));
  imgCinza.setImg(imgCinza.floodFill(175, 283));
  imgCinza.setImg(imgCinza.floodFill(170, 243));
  imgCinza.setImg(imgCinza.floodFill(252, 260));
  imgCinza.setImg(imgCinza.floodFill(255, 266));
  imgCinza.setImg(imgCinza.floodFill(258, 275));
  imgCinza.setImg(imgCinza.floodFill(252, 288));
  imgCinza.setImg(imgCinza.floodFill(255, 302));
  imgCinza.setImg(imgCinza.floodFill(238, 367));
  imgCinza.setImg(imgCinza.floodFill(216, 376));
  imgCinza.setImg(imgCinza.floodFill(170, 298));
  image(imgCinza.getImg(), 0, 0);

  fill(255, 0, 0);
  text("X: " + mouseX + " Y: " + mouseY, mouseX, mouseY);

  save("FinalIMG2.png");
}
