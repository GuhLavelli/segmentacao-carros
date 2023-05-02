import java.util.ArrayList; 

//Variáveis globais
PrintWriter analise;
PrintWriter mapeamentoPixels;

void setup() {
  //Criar arquivos CSV
  analise = createWriter("analise.csv");
  mapeamentoPixels = createWriter("mapeamentoPixels.csv");

  noLoop();
  size(400, 266);
}

void draw() {
  //Declaração e inicialização de Variáveis
  int falsoPositivo = 0;
  int falsoNegativo = 0;
  int acertos = 0;
  float percAcertos = 0;
  
  //Carrega as 2 imagens
  PImage imgBanco = loadImage("carro_branco1_seg_dataset.png");
  PImage imgSegme = loadImage("carro_branco1_seg.png");
  
  //Header CSV mapeamentoPixels
  mapeamentoPixels.println("X;Y;Imagem Banco;Imagem Nossa");
  
  //Laço de comparação
  for (int y = 0; y<height; y++) {
    for (int x = 0; x<width; x++) {
      int pos = y*width+x;
      float pixelImgBanco = red(imgBanco.pixels[pos]);
      float pixelImgSegme = red(imgSegme.pixels[pos]);
      
      //Mapeamento de valores por pixel
      mapeamentoPixels.println(x+";"+y+";"+pixelImgBanco+";"+pixelImgSegme);
      
      //Trata a imagem do Banco para 
      if (pixelImgBanco < 127) pixelImgBanco = 0;
      else pixelImgBanco = 255;
      
      // Acertos
      if (pixelImgBanco == pixelImgSegme)
        acertos++;
      // Falso Positivo
      if (pixelImgBanco == 0 && pixelImgSegme == 255)
        falsoPositivo++;
      // Falso Negativo
      if (pixelImgBanco == 255 && pixelImgSegme == 0) 
        falsoNegativo++;

      
    }
  }
  //Fim CSV
  mapeamentoPixels.flush();
  mapeamentoPixels.close();
  
  //Cálcula a porcetagem de acertos
  percAcertos = acertos*100.00/float(height*width);
  
  //CSV Analise
  analise.println("Imagem;Acertos;Acertos(%);Falso Positivo;Falso Negativo");
  analise.println(acertos+";"+Float.toString(percAcertos).replace(".", ",")+";"+falsoPositivo+";"+falsoNegativo);
  analise.flush();
  analise.close();

  println("END");
}
