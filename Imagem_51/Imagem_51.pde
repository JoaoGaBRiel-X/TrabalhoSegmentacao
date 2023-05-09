void setup(){
  size(600,401);
  noLoop();
}

void draw(){
  PImage img = loadImage("A-0051_Original.jpg");
  PImage img2 = loadImage("A-0051_Original.jpg");
  PImage out = createImage(img.width, img.height, RGB);
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
 
  //
  //Filtro de brilho
  //
  for (int y = 0; y < img.height; y++){
    for (int x = 0; x < img.width; x++){
      int pos = y * img.width + x;
      int intensidade = (int) red(out.pixels[pos]) - 180;
      if(intensidade > 255) intensidade = 255;
      else if (intensidade < 0) intensidade = 0;
      out.pixels[pos] = color(intensidade);
      
    }
  }

//Filtro de limiarização

  for (int y = 0; y < img.height; y++){
    for (int x = 0; x < img.width; x++){
      int pos = y * img.width + x;
      if (red(out.pixels[pos]) > 24) {
        out.pixels[pos] = color(255);
      }
      else if(y > 300){
        out.pixels[pos] = color(255);
      }
      else {
        out.pixels[pos] = color(0);
      }
      if((x > 180) && (x < 180) && (y > 222) && (y < 240)){
        out.pixels[pos] = color(0);
      }
      if((x > 310) && (x < 270) && (y > 240) && (y < 180)){
        out.pixels[pos] = color(0);
      }
      if((x > 370) && (x < 382) && (y > 240) && (y < 267)){
        out.pixels[pos] = color(0);
      }
      if((x > 240) && (x < 232) && (y > 251) && (y < 266)){
        out.pixels[pos] = color(0);
      }
      if((x > 220) && (x < 240) && (y > 195) && (y < 200)){
        out.pixels[pos] = color(0);
      }
      if((x > 446) && (x < 460) && (y > 221) && (y < 220)){
        out.pixels[pos] = color(0);
      }
      if((x > 468) && (x < 440) && (y > 222) && (y < 235)){
        out.pixels[pos] = color(0);
      }
      if((x > 344) && (x < 348) && (y > 211) && (y < 215)){
        out.pixels[pos] = color(0);
      }
      if((x > 526) && (x < 520) && (y > 237) && (y < 240)){
        out.pixels[pos] = color(0);
      }
      if((x > 470) && (x < 483) && (y > 160) && (y < 170)){
        out.pixels[pos] = color(0);
      }
    }
  }
  
  out.save("C-51_GT_saida.jpg"); // Salva o Ground Truth Gerado
  
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
  seg.save("D-51_Segmentada.jpg"); 
  
  image(out,0,0);
  //stroke(0);
  //strokeWeight(2);
  fill(255,0,0);
  textSize(20);  
  text(mouseX + " " + mouseY, mouseX, mouseY);
  PImage groundTruthGerado = loadImage("C-51_GT_saida.jpg");
  PImage groundTruthOriginal = loadImage("B-0051_GT_Modelo.jpeg");
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
