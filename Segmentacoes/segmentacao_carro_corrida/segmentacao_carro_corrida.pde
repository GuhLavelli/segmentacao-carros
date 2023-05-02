void setup() {
  size(400, 300);
}

void draw() {
  PImage imgOrig = loadImage("carro.jpg");
  Filtros img = new Filtros(imgOrig, width, height);

  img.setImg(img.filtroCinza('G'));
  //img.setImg(img.filtroGauss(0, height, 0, width, 1)); estava deixando obejtos mais grosso
  imgOrig = img.getImg();

  for (int y=0; y<height; y++) {
    for (int x=0; x<width; x++) {
      int pos = y*width + x;

      //Retrovisor
      if (red(imgOrig.pixels[pos]) < 171 && y > 157 && y < 173 && x > 165 && x < 188 )
        imgOrig.pixels[pos] = color(255);
      //Danteira embaixo
      else if (red(imgOrig.pixels[pos]) < 60 && y > 200 && y < 216 && x > 86 && x < 200 )
        imgOrig.pixels[pos] = color(255);
      //Dianteira em cima
      else if (red(imgOrig.pixels[pos]) < 130 && y > 167 && y < 203 && x > 86 && x < 200 )
        imgOrig.pixels[pos] = color(255);

      //Piloto, parte media, aerofolio
      else if (red(imgOrig.pixels[pos]) < 150 && y > 139 && y < 197 && x > 197 && x < 374 )
        imgOrig.pixels[pos] = color(255);

      //pneu dianteiro e embaixo do carro
      else if (red(imgOrig.pixels[pos]) < 50 && y > 192 && y < 213 && x > 194 && x < 243 )
        imgOrig.pixels[pos] = color(255);

      //medio embaixo
      else if (red(imgOrig.pixels[pos]) < 50 && y > 192 && y < 210 && x > 241 && x < 290 )
        imgOrig.pixels[pos] = color(255);

      //embaixo atras
      else if (red(imgOrig.pixels[pos]) < 95 && y > 192 && y < 205 && x > 285 && x < 330 )
        imgOrig.pixels[pos] = color(255);

      //pneu traseiro
      else if (red(imgOrig.pixels[pos]) < 90 && y > 192 && y < 207 && x > 325 && x < 345)
        imgOrig.pixels[pos] = color(255);

      //finalização traseira e finalização pneu
      else if (red(imgOrig.pixels[pos]) < 120 && y > 192 && y < 201 && x > 329 && x < 362)
        imgOrig.pixels[pos] = color(255);

      //pintando pixels meio carro
      else if (red(imgOrig.pixels[pos]) < 230 && y > 181 && y < 208 && x > 136 && x < 246)
        imgOrig.pixels[pos] = color(255);

      //pintando pixels traseiros
      else if (red(imgOrig.pixels[pos]) < 230 && y > 157 && y < 206 && x > 244 && x < 323)
        imgOrig.pixels[pos] = color(255);

      //pintandos pixels aerofolio
      else if (red(imgOrig.pixels[pos]) < 230 && y > 144 && y < 167 && x > 360 && x < 373)
        imgOrig.pixels[pos] = color(255);

      //pintandos pixels roda traseira
      else if (red(imgOrig.pixels[pos]) < 230 && y > 175 && y < 201 && x > 322 && x < 350)
        imgOrig.pixels[pos] = color(255);

      //pintandos pixels capacete
      else if (red(imgOrig.pixels[pos]) < 230 && y > 147 && y < 151 && x > 222 && x < 235)
        imgOrig.pixels[pos] = color(255);


      else imgOrig.pixels[pos] = color(0);
    }
  }




  image(img.getImg(), 0, 0);
  save("imagemnova.jpg");


  fill(255, 0, 0);
  text("X: " + mouseX + " Y: " + mouseY, mouseX, mouseY);
}
