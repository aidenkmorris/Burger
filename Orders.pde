class Orders
{
  String orderText = "";
  int orderLen = 7, score = 0, timerDuration, timerGoal;
  
  void orderComplete()
  {
    orderText = "";
    score += orderLen * multiplier;
  }
  
  void newOrder()
  {
    int random, counter = 1, ingredient; //if botbun, ingredient = 2, else, ingredient = 1
    //counter tells how many burgers to generate, ingredient tells what ingredient we're on
    
    random = 1 + int(random(26)); //0-25
    
    if(random < 2) //1
    {
      orderLen = 1;
    }
    else if(random < 4) //2 3
    {
      orderLen = 2;
    }
    else if(random < 7) //4 5 6
    {
      orderLen = 3;
    }
    else if(random < 15) //7 8 9 10 11 12 13 14
    {
      orderLen = 4;
    }
    else if(random < 21) //15 16 17 18 19 20
    {
      orderLen = 5;
    }
    else if(random < 25) //21 22 23 24
    {
      orderLen = 6;
    }
    else //25 26
    {
      orderLen = 7;
    }
    
    //start timers
    //timerDuration = 7500 * orderLen;
    timerDuration = round( 1000 * ((10.0 / (orderLen + 1)) + (1.8 * orderLen * pow(1.3, orderLen))) );
    timerGoal = millis() + timerDuration;
    
    //account for orderLen == 1 which should give a random ingredient
    if(orderLen == 1)
    {
      orderText += miscFood[int(random(miscFood.length))] + " ";
      return;
    }
    
    //check for bot bun
    random = 1 + int(random(10)); //1-10
    
    if(random == 10)
    {
      ingredient = 0;
    }
    else
    {
      orderText += "botbun ";
      ingredient = 1;
    }
    
    while(ingredient < orderLen)
    {
      if(counter == 1) //if first non-bun ingredient, 95% chance patty, 5% misc
      {
        random = 1 + int(random(20));
        
        if(random == 20)
        {
          orderText += miscFood[int(random(miscFood.length))] + " ";
        }
        else
        {
          orderText += "patty ";
        }
        
        ingredient++;
        counter++;
        continue;
      }
      else if(ingredient + 1 == orderLen)
      {
        random = 1 + int(random(10)); //1-10
        
        if(random < 9)
        {
          orderText += "topbun ";
          ingredient++;
          counter++;
          continue;
        }
      }
      
      //decreasing chance for patty each ingredient that goes on
      random = 1 + int(random(pow(counter, 2))); //random out of counter squared
      
      if(random == pow(counter, 2))
      {
        orderText += "patty ";
      }
      else
      {
        orderText += miscFood[int(random(miscFood.length))] + " ";
      }
      
      ingredient++;
      counter++;
    }
  }
}