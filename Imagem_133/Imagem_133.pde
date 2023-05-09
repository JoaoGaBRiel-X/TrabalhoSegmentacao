void setup(){
  size(600,401);
  noLoop();
}

void draw(){
  PImage img = loadImage("A-0133_Original.jpg");
  PImage img2 = loadImage("A-0133_Original.jpg");
  PImage out = createImage(img.width, img.height, RGB);
  PImage seg = createImage(img.width, img.height, RGB);
  
 //  //Filtro de escala de cinza

  //calculando por canal separado
  for (int y = 0; y < img.height; y++){
    for (int x = 0; x < img.width; x++){
      int pos = y * img.width + x;
      int media = (int) (green(img.pixels[pos]));
      out.pixels[pos] = color(media);
    }
  }
 
  //
  //Filtro de brilho
  //
  for (int y = 0; y < img.height; y++){
    for (int x = 0; x < img.width; x++){
      int pos = y * img.width + x;
      int intensidade = (int) green(out.pixels[pos]) - 150;
      if(intensidade > 255) intensidade = 255;
      else if (intensidade < 0) intensidade = 0;
      out.pixels[pos] = color(intensidade);
      
    }
  }

//Filtro de limiarização

  for (int y = 0; y < img.height; y++){
    for (int x = 0; x < img.width; x++){
      int pos = y * img.width + x;
      if (red(out.pixels[pos]) > 17) {
        out.pixels[pos] = color(255);
      }
      else if(y < 20){
        out.pixels[pos] = color(255);
      }
      else {
        out.pixels[pos] = color(0);
      }
      if((x > 130) && (x < 310) && (y > 230) && (y < 300)){
        out.pixels[pos] = color(0);
      }
      if((x > 110) && (x < 170) && (y > 180) && (y < 210)){
        out.pixels[pos] = color(0);
      }
      if((x > 70) && (x < 300) && (y > 249) && (y < 255)){
        out.pixels[pos] = color(0);
      }
     if((x > 400) && (x < 450) && (y > 210) && (y < 240)){
        out.pixels[pos] = color(0);
      }
    }
  }

   out.save("C-0133_GT_saida.jpg"); // Salva o Ground Truth Gerado
  
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
  seg.save("D-0133_Segmentada.jpg"); 
  
  //image(out,0,0);
  //stroke(0);
  //strokeWeight(2);
  //fill(255,0,0);
  //textSize(20);  
  //text(mouseX + " " + mouseY, mouseX, mouseY);
  PImage groundTruthGerado = loadImage("C-0133_GT_saida.jpg");
  PImage groundTruthOriginal = loadImage("B-0133_GT_Modelo.jpg");
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
