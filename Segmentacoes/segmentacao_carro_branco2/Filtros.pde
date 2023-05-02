import java.util.ArrayList;
import java.util.Collections;
import java.util.Queue;
import java.util.LinkedList;
import java.awt.Point;


class Filtros {
  int wid, hei;
  PImage img;

  //   Construtor
  Filtros(PImage img, int wid, int hei) {
    this.img = img;
    this.wid = wid;
    this.hei = hei;
  }

  void setImg(PImage img) {
    this.img = img;
  }

  PImage getImg() {
    return this.img;
  }


  // Método para realizar o filtro em escala de cinza pegando a média dos 3 canais de cores
  PImage filtroCinza_media() {
    PImage imgFiltrada = createImage(wid, hei, RGB);
    for (int y=0; y<img.height; y++) {
      for (int x=0; x<img.width; x++) {
        int pos = y*img.width + x;
        int media = 0;
        media += red(img.pixels[pos]);
        media += green(img.pixels[pos]);
        media += blue(img.pixels[pos]);

        imgFiltrada.pixels[pos] = color(media/3);
      }
    }
    return imgFiltrada;
  }

  // Método para realizar o filtro em escala de cinza
  PImage filtroCinza(char channel) {
    PImage imgFiltrada = createImage(wid, hei, RGB);
    for (int y=0; y<img.height; y++) {
      for (int x=0; x<img.width; x++) {
        int pos = y*img.width + x;
        switch(channel) {
        case 'R':
          imgFiltrada.pixels[pos] = color(red(img.pixels[pos]));
          break;
        case 'G':
          imgFiltrada.pixels[pos] = color(green(img.pixels[pos]));
          break;
        case 'B':
          imgFiltrada.pixels[pos] = color(blue(img.pixels[pos]));
          break;
        }
      }
    }
    return imgFiltrada;
  }

  // Método para realizar o filtro da cor de maior instesidade por pixel
  PImage filtroHighestChannel() {
    PImage imgFiltrada = createImage(wid, hei, RGB);
    for (int y=0; y<img.height; y++) {
      for (int x=0; x<img.width; x++) {
        int pos = y*img.width + x;
        float red =  red(img.pixels[pos]);
        float blue = blue(img.pixels[pos]);
        float green = green(img.pixels[pos]);
        if (red > blue && red > green) {
          imgFiltrada.pixels[pos] = color(red);
        } else if (blue > red && blue > green) {
          imgFiltrada.pixels[pos] = color(blue);
        } else if (green > red && green > blue) {
          imgFiltrada.pixels[pos] = color(green);
        } else {
          imgFiltrada.pixels[pos] = color(red);
        }
      }
    }
    return imgFiltrada;
  }

  // Método para realizar o filtro de Gauss
  PImage filtroMediana() {
    PImage imgFiltrada = createImage(wid, hei, RGB);
    // Filtro de Mediana
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int jan = 1;
        int pos = y*img.width + x;
        ArrayList<Integer> valores = new ArrayList<>();

        // Percorrer a janela
        for (int i = jan*(-1); i <= jan; i++) {
          for (int j = jan*(-1); j <= jan; j++) {
            int ny = y+i;
            int nx = x+j;
            if (ny >= 0 && ny < img.height &&
              nx >= 0 && nx < img.width) {
              int pos_aux = ny * img.width + nx;
              valores.add((int)(red(img.pixels[pos_aux])));
            }
          }
        }
        // Calculo da Mediana
        Collections.sort(valores);
        imgFiltrada.pixels[pos] = color(valores.get(valores.size()/2));
      }
    }
    return imgFiltrada;
  }

  PImage filtroGauss(int yInit, int yFinal, int xInit, int xFinal, int qtde) {
    PImage aux = this.img;
    PImage out = createImage(img.width, img.height, RGB);
    float[][] kernel = {{1.0/16, 2.0/16, 1.0/16},
      {2.0/16, 4.0/16, 2.0/16},
      {1.0/16, 2.0/16, 1.0/16}};
    for (int q=0; q<qtde; q++) {
      for (int y = 0; y < img.height; y++) {
        for (int x = 0; x < img.width; x++) {
          int pos = y*img.width + x;
          int jan = 1;
          float valor = 0;
          //Bounding box
          if (y > yInit && y <= yFinal && x > xInit && x <= xFinal ) {
            for (int i = jan*(-1); i <= jan; i++) {
              for (int j = jan*(-1); j <= jan; j++) {
                int ny = y + i;
                int nx = x + j;
                if (nx >= xInit && nx < xFinal && ny >= yInit && ny < yFinal) {
                  int npos = ny*img.width + nx;
                  valor += red(aux.pixels[npos]) * kernel[i+1][j+1];
                }
              }
            }
            out.pixels[pos] = color(valor);
          } else {
            out.pixels[pos] = color(red(aux.pixels[pos]));
          }
        }
      }
      aux = out;
    }
    return out;
  }
  //Flood Fill

  PImage floodFill(int y, int x) {

    Queue<Point> fila = new LinkedList<Point>();
    Point ponto;
    int pos;
    fila.add (new Point(x, y));
    while (fila.size() > 0) {
      ponto = fila.remove();
      pos = ponto.y*img.width + ponto.x;
      if (red(img.pixels[pos]) == 0) {
        img.pixels[pos] = color(255);
        fila.add(new Point(ponto.x, ponto.y+1));
        fila.add(new Point(ponto.x, ponto.y-1));
        fila.add(new Point(ponto.x+1, ponto.y));
        fila.add(new Point(ponto.x-1, ponto.y));
      }
    }
    return img;
  }
}
