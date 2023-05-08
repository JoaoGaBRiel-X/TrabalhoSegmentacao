void setup(){
  size(599,401);
  //noLoop();
}

void draw(){
  PImage img = loadImage("0103.jpg");
  PImage out = createImage(img.width, img.height, RGB);
  
  
   //Filtro de escala de cinza

  ////calculando por media
  for (int y = 0; y < img.height; y++){
    for (int x = 0; x < img.width; x++){
      int pos = y * img.width + x;
      int media = (int) (red(img.pixels[pos]) + green(img.pixels[pos]) + blue(img.pixels[pos])) / 3 ;
     out.pixels[pos] = color(media);
   }
 }

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
      int intensidade = (int) red(out.pixels[pos]) - 9;
      if(intensidade > 255) intensidade = 255;
      else if (intensidade < 0) intensidade = 0;
      out.pixels[pos] = color(intensidade);
      
    }
  }

//Filtro de limiarização

  for (int y = 0; y < img.height; y++){
    for (int x = 0; x < img.width; x++){
      int pos = y * img.width + x;
      if (red(out.pixels[pos]) > 180) {
        out.pixels[pos] = color(255);
      }
      else if(y > 300){
        out.pixels[pos] = color(255);
      }
      else {
        out.pixels[pos] = color(0);
      }
    }
  }

  image(out,0,0);
  stroke(0);
  strokeWeight(2);
  fill(0);
  textSize(20);  
  text(mouseX + " " + mouseY, mouseX, mouseY);
  save("103.jpg");
  
}
