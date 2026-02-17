import processing.sound.*;
SoundFile soundfile;
Food patty, lettuce, cheese, pickles, bacon, tomato, botbun, topbun, delete;
Plate plate1, plate2, plate3, plate4;
String[] miscFood = {"lettuce", "cheese", "pickles", "bacon", "tomato"};
boolean holdingFood;
String nameFood;
Orders order1, order2, order3, order4;
int combo, multiplier, health;
boolean gameStarted;
void setup()
{
  size(1200, 800);
  
  gameStarted = false;
  
  topbun= new Food(0, 000, 100, 100, "pixeltopbun.png");
  botbun= new Food(0, 100, 100, 100, "pixelbotbun.png");
  patty = new Food(0, 200, 100, 100, "pixelpatty.png");
  lettuce = new Food(0, 300, 100, 100, "pixellettuce.png");
  cheese = new Food(0, 400, 100, 100, "pixelcheese.png");
  pickles = new Food(0, 500, 100, 100, "pixelpickles.png");
  bacon = new Food(0, 600, 100, 100, "pixelbacon.png");
  tomato = new Food(0, 700, 100, 100, "pixeltomato.png");
  
  delete = new Food(750, 650, 100, 100, "pixeldelete.png");
  
  plate1 = new Plate(300, 300, 100, 100, "pixelplate.png");
  plate2 = new Plate(500, 300, 100, 100, "pixelplate.png");
  plate3 = new Plate(300, 500, 100, 100, "pixelplate.png");
  plate4 = new Plate(500, 500, 100, 100, "pixelplate.png");
  
  playMusic("LoopingMusic.wav");
}

void draw()
{
  if(gameStarted == false)
  {
    menu();
  }
  else
  {
    if(health > 0)
    {
      game();
    }
    else 
    {
      gameover();
    }
  }
}

void game()
{ 
  //drawing starts here
  background(150);
  textAlign(LEFT);
  textSize(24);
  
  //food selection
  fill(0);
  rect(0, 0, 100, 800);
  fill(150);
  for(int i = 0; i < 8; i++)
  {
    rect(2, 2 + i * 100, 96, 96); 
  }
  
  //orders
  fill(0);
  rect(900, 0, 300, 800);
  fill(255);
  for(int i = 0; i < 4; i++)
  {
    rect(902, 2 + i * 200, 296, 196); 
  }
  fill(0);
  text(order1.orderText, 910, 10, 280, 180);
  //print("\nOrder 1 Text: " + order1.orderText);
  text(order2.orderText, 910, 210, 280, 180);
  //print("\nOrder 2 Text: " + order2.orderText);
  text(order3.orderText, 910, 410, 280, 180);
  //print("\nOrder 3 Text: " + order3.orderText);
  text(order4.orderText, 910, 610, 280, 180);
  //print("\nOrder 4 Text: " + order4.orderText);
  
  //score + combo text
  text("Score: " + (order1.score + order2.score + order3.score + order4.score), 110, 80);
  text("Combo: " + (combo), 110, 120);
  
  //combo meter
  rect(100, 0, 750, 50);
  fill(255);
  rect(100, 2, 750, 46);
  int value;
  if(combo >= 25) //clamps value
  {
    value = 746;
  }
  else
  {
    value = round(combo / 25.0 * 746);
  }
  
  fill(255, 191, 0);
  rect(102, 8, value, 34);
  
  //health bar
  fill(0);
  rect(100, 750, 750, 50);
  fill(255);
  rect(100, 752, 750, 46);
  value = round(health / 3.0 * 746);
  fill(0, 255, 0);
  rect(102, 758, value, 34);
  
  //timers
  fill(0);
  rect(850, 0, 50, 800);
  fill(255);
  rect(852, 0, 46, 800);
  
  fill(255, 0, 0);
  rectMode(CORNERS);
  value = round( (order1.timerGoal - millis()) / float(order1.timerDuration) * 200);
  rect(858, 200, 892, 200 - value);
  value = round( (order2.timerGoal - millis()) / float(order2.timerDuration) * 200);
  rect(858, 400, 892, 400 - value);
  value = round( (order3.timerGoal - millis()) / float(order3.timerDuration) * 200);
  rect(858, 600, 892, 600 - value);
  value = round( (order4.timerGoal - millis()) / float(order4.timerDuration) * 200);
  rect(858, 800, 892, 800 - value);
  rectMode(CORNER);
  
  //display images
  patty.display();
  lettuce.display();
  cheese.display();
  pickles.display();
  bacon.display();
  tomato.display();
  botbun.display();
  topbun.display();
  delete.display();
  plate1.display();
  plate2.display();
  plate3.display();
  plate4.display();
  
  if(holdingFood)
  {
    image(loadImage("pixel" + nameFood + ".png"), mouseX - 50, mouseY - 50, 100, 100);
  }
  
  //check order timers
  if(millis() > order1.timerGoal)
  {
    //fail order
    combo = 0;
    order1.orderText = "";
    order1.newOrder();
    health--;
    playSound("OrderFailed.wav");
  }
  if(millis() > order2.timerGoal)
  {
    //fail order
    combo = 0;
    order2.orderText = "";
    order2.newOrder();
    health--;
    playSound("OrderFailed.wav");
  }
  if(millis() > order3.timerGoal)
  {
    //fail order
    combo = 0;
    order3.orderText = "";
    order3.newOrder();
    health--;
    playSound("OrderFailed.wav");
  }
  if(millis() > order4.timerGoal)
  {
    //fail order
    combo = 0;
    order4.orderText = "";
    order4.newOrder();
    health--;
    playSound("OrderFailed.wav");
  }
}

void gameover()
{
  background(247, 89, 100);
  textAlign(CENTER);
  fill(0);
  textSize(48);
  text("Gameover!", 600, 350);
  text("Score: " + (order1.score + order2.score + order3.score + order4.score), 600, 450);
}

void menu()
{
  background(0, 255, 242);
  textAlign(CENTER);
  fill(0);
  textSize(72);
  text("Burger Game", 600, 375);
  textSize(32);
  text("A masterpiece by Aiden K Morris", 600, 425);
  textSize(20);
  text("Click anywhere to start", 600, 500);
}

void gameStart()
{
  order1 = new Orders();
  order1.newOrder();
  order2 = new Orders();
  order2.newOrder();
  order3 = new Orders();
  order3.newOrder();
  order4 = new Orders();
  order4.newOrder();
  
  holdingFood = false;
  nameFood = "";
  combo = 0;
  multiplier = 1;
  health = 3;
  
  textSize(20);
}

void mousePressed()
{
  if(gameStarted == false)
  {
    gameStarted = true;
    gameStart();
  }
  else if(patty.hovering())
  {
    holdingFood = true;
    nameFood = "patty";
  }
  else if(lettuce.hovering())
  {
    holdingFood = true;
    nameFood = "lettuce";
  }
  else if(cheese.hovering())
  {
    holdingFood = true;
    nameFood = "cheese";
  }
  else if(pickles.hovering())
  {
    holdingFood = true;
    nameFood = "pickles";
  }
  else if(bacon.hovering())
  {
    holdingFood = true;
    nameFood = "bacon";
  }
  else if(tomato.hovering())
  {
    holdingFood = true;
    nameFood = "tomato";
  }
  else if(botbun.hovering())
  {
    holdingFood = true;
    nameFood = "botbun";
  }
  else if(topbun.hovering())
  {
    holdingFood = true;
    nameFood = "topbun";
  }
  else if(delete.hovering())
  {
    holdingFood = true;
    nameFood = "delete";
  }
  else if(plate1.hovering())
  {
    holdingFood = false;
    plate1.addFood(nameFood);
    nameFood = "";
    
    if(plate1.storedFoodText.equals(order1.orderText))
    {
      plate1.clearFood();
      order1.orderComplete();
      order1.newOrder();
      combo += 1;
      checkCombo();
      playSound("OrderComplete.wav");
    }
  }
  else if(plate2.hovering())
  {
    holdingFood = false;
    plate2.addFood(nameFood);
    nameFood = "";
    
    if(plate2.storedFoodText.equals(order2.orderText))
    {
      plate2.clearFood();
      order2.orderComplete();
      order2.newOrder();
      combo += 1;
      checkCombo();
      playSound("OrderComplete.wav");
    }
  }
  else if(plate3.hovering())
  {
    holdingFood = false;
    plate3.addFood(nameFood);
    nameFood = "";
    
    if(plate3.storedFoodText.equals(order3.orderText))
    {
      plate3.clearFood();
      order3.orderComplete();
      order3.newOrder();
      combo += 1;
      checkCombo();
      playSound("OrderComplete.wav");
    }
  }
  else if(plate4.hovering())
  {
    holdingFood = false;
    plate4.addFood(nameFood);
    nameFood = "";
    
    if(plate4.storedFoodText.equals(order4.orderText))
    {
      plate4.clearFood();
      order4.orderComplete();
      order4.newOrder();
      combo += 1;
      checkCombo();
      playSound("OrderComplete.wav");
    }
  }
}

void checkCombo()
{
  if(combo >= 25)
  {
    multiplier = 4;
  }
  else if (combo >= 10)
  {
    multiplier = 3;
  }
  else if(combo >= 5)
  {
    multiplier = 2;
  }
}

void playSound(String filename)
{
  soundfile = new SoundFile(this, filename);
  soundfile.amp(0.2);
  soundfile.play();
}

void playMusic(String filename)
{
  soundfile = new SoundFile(this, filename);
  soundfile.amp(0.15);
  soundfile.loop();
}