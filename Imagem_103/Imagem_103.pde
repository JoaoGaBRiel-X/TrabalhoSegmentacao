void setup(){
  size(600,401);
  noLoop();
}

void draw(){
  PImage img = loadImage("A-0103_Original.jpg");
  PImage img2 = loadImage("A-0103_Original.jpg");
  PImage img3 = loadImage("A-0103_Original.jpg");
  PImage out = createImage(img.width, img.height, RGB);
  PImage out2 = createImage(img.width, img.height, RGB);
  PImage seg = createImage(img.width, img.height, RGB);
  
  
 //  //Filtro de escala de cinza

  //calculando por canal separado
  for (int y = 0; y < img.height; y++){
    for (int x = 0; x < img.width; x++){
      int pos = y * img.width + x;
      int media = (int) (blue(img.pixels[pos]));
      out.pixels[pos] = color(media);
    }
  }

  //calculando por canal separado
  for (int y = 0; y < img3.height; y++){
    for (int x = 0; x < img3.width; x++){
      int pos = y * img3.width + x;
      int media = (int) (blue(img3.pixels[pos]));
      out2.pixels[pos] = color(media);
    }
  }
 
  //
  //Filtro de brilho
  //
  for (int y = 0; y < img.height; y++){
    for (int x = 0; x < img.width; x++){
      int pos = y * img.width + x;
      int intensidade = (int) red(out.pixels[pos]) - 130;
      if(intensidade > 255) intensidade = 255;
      else if (intensidade < 0) intensidade = 0;
      out.pixels[pos] = color(intensidade);
      
    }
  }

  //
  //Filtro de brilho
  //
  for (int y = 0; y < img3.height; y++){
    for (int x = 0; x < img3.width; x++){
      int pos = y * img3.width + x;
      int intensidade = (int) red(out2.pixels[pos]) - 200;
      if(intensidade > 255) intensidade = 255;
      else if (intensidade < 0) intensidade = 0;
      out2.pixels[pos] = color(intensidade);
      
    }
  }
  
  //Filtro de limiarização

  for (int y = 0; y < img3.height; y++){
    for (int x = 0; x < img3.width; x++){
      int pos = y * img3.width + x;
      if (red(out2.pixels[pos]) > 20) {
        out2.pixels[pos] = color(0);
      }
      else {
        out2.pixels[pos] = color(255);
      }
      if(x < 146 || y < 139 || x > 181 || y > 162){
        out2.pixels[pos] = color(255);
      }
    }
  }

//Filtro de limiarização

  for (int y = 0; y < img.height; y++){
    for (int x = 0; x < img.width; x++){
      int pos = y * img.width + x;
      if (red(out.pixels[pos]) > 40) {
        out.pixels[pos] = color(255);
      }
      else if(y > 300){
        out.pixels[pos] = color(255);
      }
      else {
        out.pixels[pos] = color(0);
      }
      if((x > 182) && (x < 250) && (y > 169) && (y < 200)){
        out.pixels[pos] = color(0);
      }
      if((x > 340) && (x < 390) && (y > 148) && (y < 173)){
        out.pixels[pos] = color(0);
      }
      if((x > 243) && (x < 276) && (y > 205) && (y < 215)){
        out.pixels[pos] = color(0);
      }
      if((x > 291) && (x < 299) && (y > 148) && (y < 159)){
        out.pixels[pos] = color(0);
      }
      if((x > 296) && (x < 302) && (y > 149) && (y < 158)){
        out.pixels[pos] = color(0);
      }
      if((x > 303) && (x < 299) && (y > 150) && (y < 160)){
        out.pixels[pos] = color(0);
      }
      if((x > 298) && (x < 303) && (y > 150) && (y < 156)){
        out.pixels[pos] = color(0);
      }
      if((x > 154) && (x < 173) && (y > 143) && (y < 159)){
        out.pixels[pos] = color(0);
      }
      if((x > 150) && (x < 155) && (y > 150) && (y < 157)){
        out.pixels[pos] = color(0);
      }
      if((x > 149) && (x < 153) && (y > 152) && (y < 159)){
        out.pixels[pos] = color(0);
      }
      if((x > 170) && (x < 177) && (y > 146) && (y < 152)){
        out.pixels[pos] = color(0);
      }
      if((x > 175) && (x < 179) && (y > 147) && (y < 155)){
        out.pixels[pos] = color(0);
      }
    }
  }
  
  // somando duas saidas
  for (int y = 0; y < out.height; y++) {
    for (int x = 0; x < out.width; x++) {
      int pos = y * out.width + x;
      int pixel1 = (int) red(out.pixels[pos]);
      int pixel2 = (int) red(out2.pixels[pos]);
      int sum = (pixel1 + pixel2) / 2;
      if(sum < 250) out.pixels[pos] = color(0);
    }
  }
  
  
  out.save("C-0103_GT_saida.jpg"); // Salva o Ground Truth Gerado
  
  //segmentando a imagem original
  
  // Itera sobre cada pixel da imagem original
  for (int x = 0; x < img2.width; x++) {
    for (int y = 0; y < img2.height; y++) {
      int pos = y * img2.width + x;
      // Obtém a cor do pixel correspondente na imagem ground truth
      if(red(out.pixels[pos]) == 255){
        seg.pixels[pos] = color(255);
      } else {
        seg.pixels[pos] = color(red(img2.pixels[pos]), green(img2.pixels[pos]), blue(img2.pixels[pos]));
      }
    }
  }
  seg.save("D-0103_Segmentada.jpg"); 
  
  //image(out,0,0);
  //stroke(0);
  //strokeWeight(2);
  //fill(255,0,0);
  //textSize(20);  
  //text(mouseX + " " + mouseY, mouseX, mouseY);
  
  PImage groundTruthGerado = loadImage("C-0103_GT_saida.jpg");
  PImage groundTruthOriginal = loadImage("B-0103_GT_Modelo.jpeg");
  
  int acerto = 0;
  int falsoPositivo = 0;
  int falsoNegativo = 0;
  for (int y = 0; y < groundTruthGerado.height; y++ ) {
    for (int x = 0; x < groundTruthGerado.width; x++) {
      int pos = y*groundTruthGerado.width+x;
      if ((red(groundTruthGerado.pixels[pos]) > 127  && red(groundTruthOriginal.pixels[pos]) > 127) ||
        (red(groundTruthGerado.pixels[pos]) <= 127  && red(groundTruthOriginal.pixels[pos]) <= 127)) {
        acerto++;
      } else if ((red(groundTruthGerado.pixels[pos]) < 127 && red(groundTruthOriginal.pixels[pos]) > 127)) {
        falsoPositivo = falsoPositivo +1;
      } else if ((red(groundTruthGerado.pixels[pos]) > 127 && red(groundTruthOriginal.pixels[pos]) < 127)) {
        falsoNegativo = falsoNegativo +1;
      }
    }
  }
  println("Acertos: " + acerto);
  println("Falsos Positivos: " + falsoPositivo);
  print("Falsos Negativos: " + falsoNegativo);
  
  
}
