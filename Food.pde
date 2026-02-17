class Food //food objects (patty, lettuce, cheese, etc.)
{
  int x, y, xd, yd;
  String file;
  PImage img;

  Food(int xCoord, int yCoord, int xDist, int yDist, String file) 
  {
    x = xCoord;
    y = yCoord;
    xd = xDist;
    yd = yDist;
    this.file = file;
    img = loadImage(file);
  }

  void display() 
  {
    image(img, x, y, xd, yd);
  }

  boolean hovering()
  {
    return mouseX >= x && mouseX <= x + xd && mouseY >= y && mouseY <= y + yd;
  }
}