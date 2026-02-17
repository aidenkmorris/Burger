class Plate extends Food
{
  String storedFoodText = "";
  String[] storedFood = new String[7];
  
  Plate(int xCoord, int yCoord, int xDist, int yDist, String file) 
  {
    super(xCoord, yCoord, xDist, yDist, file);
    
    for(int i = 0; i < 7; i++)
    {
      storedFood[i] = "";
    }
  }
  
  void addFood(String food)
  {
    if(food == "")
    {
      return;
    }
    else if(food == "delete")
    {
      clearFood();
      return;
    }
    
    for(int i = 0; i < 7; i++)
    {
      if(storedFood[i] == "")
      {
        storedFood[i] = food;
        storedFoodText += food + " ";
        break;
      }
    }
  }
  
  void clearFood()
  {
    storedFoodText = "";
    
    for(int i = 0; i < 7; i++)
    {
      storedFood[i] = "";
    }
  }
  
  void display() 
  {
    image(img, x, y, xd, yd);
    
    for(int i = 0; i < 7; i++)
    {
      if(storedFood[i] == "")
      {
        break;
      }
      else
      {
        image(loadImage("pixel" + storedFood[i] + ".png"), x, y - i * 10, xd, yd);
      }
    }
  }
}