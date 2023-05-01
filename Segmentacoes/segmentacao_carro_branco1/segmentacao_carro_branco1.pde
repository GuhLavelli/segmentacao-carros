void setup() {
  size(400, 266);
}

void draw() {
  PImage img = loadImage("carro_branco.jpg");
  Filtros imgCinza = new Filtros(img, 400, 266);



  imgCinza.setImg(imgCinza.filtroCinza('B'));
  imgCinza.setImg(imgCinza.filtroGauss(0, height, 0, width, 2));

  PImage img2 = imgCinza.getImg();
  // Filtro de Limiarização
  for (int y = 0; y < img2.height; y++) {
    for (int x = 0; x < img2.width; x++) {
      int pos = y*img2.width + x;
      //Capo e metade primeira porta
      if ((red(img2.pixels[pos]) > 140 && y > 125 && y < 195 && x > 60 && x < 200) ||
        (red(img2.pixels[pos]) < 30 && y > 125 && y < 195 && x > 60 && x < 200))
        img2.pixels[pos] = color(255);
      //roda a roda paralama
      else if ((red(img2.pixels[pos]) > 0 && y > 160 && y < 190 && x > 90 && x < 310))
        img2.pixels[pos] = color(255);
      //Vidro 1
      else if ((red(img2.pixels[pos]) >= 0 && y > 105 && y < 170 && x > 185 && x < 306))
        img2.pixels[pos] = color(255);
      //Vidro 2
      else if ((red(img2.pixels[pos]) >= 0 && y > 115 && y < 170 && x > 173 && x < 315))
        img2.pixels[pos] = color(255);
      //Vidro 3
      else if ((red(img2.pixels[pos]) >= 0 && y > 125 && y < 170 && x > 163 && x < 330))
        img2.pixels[pos] = color(255);
      //Teto
      else if ((red(img2.pixels[pos]) >= 125 && y > 95 && y < 170 && x > 153 && x < 376))
        img2.pixels[pos] = color(255);
      //Traseira 1
      else if ((red(img2.pixels[pos]) >= 70 && y > 130 && y < 185 && x > 153 && x < 389))
        img2.pixels[pos] = color(255);
      //Traseira 2 e Roda 2
      else if ((red(img2.pixels[pos]) <= 50 && y > 155 && y < 204 && x > 153 && x < 380) ||
        (red(img2.pixels[pos]) > 50 && y > 155 && y < 190 && x == 364)) //Linha para o FloodFill
        img2.pixels[pos] = color(255);
      //Traseira bounding box branca
      else if ((red(img2.pixels[pos]) >= 0 && y > 160 && y < 190 && x > 300 && x < 320))
        img2.pixels[pos] = color(255);
      //Traseira bounding box branca
      else if ((red(img2.pixels[pos]) >= 0 && y > 155 && y < 175 && x > 350 && x < 375))
        img2.pixels[pos] = color(255);
      //Traseira bounding box branca
      else if ((red(img2.pixels[pos]) >= 0 && y > 175 && y < 190 && x > 340 && x < 365))
        img2.pixels[pos] = color(255);
      //Roda 1
      else if ((red(img2.pixels[pos]) <= 55 && y > 150 && y < 204 && x > 77 && x < 150) ||
        (red(img2.pixels[pos]) > 55 &&  y == 188 && x > 77 && x < 150)) //Linha para o FloodFill
        img2.pixels[pos] = color(255);
      else
      img2.pixels[pos] = color(0);
    }
  }
  imgCinza.setImg(imgCinza.floodFill(180, 80));
  imgCinza.setImg(imgCinza.floodFill(180, 90));
  imgCinza.setImg(imgCinza.floodFill(190, 95));
  imgCinza.setImg(imgCinza.floodFill(190, 275));
  imgCinza.setImg(imgCinza.floodFill(183, 321));
  imgCinza.setImg(imgCinza.floodFill(183, 367));
  
  image(imgCinza.getImg(), 0, 0);



  //fill(255, 0, 0);
  //text("X: " + mouseX + " Y: " + mouseY, mouseX, mouseY);

  save("carro_branco1_segmentado.png");
}
