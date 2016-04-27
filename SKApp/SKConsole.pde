/**
 * SKConsole
 * @version 1.0.0
 * @author jason m horwitz, sekati.com
 * Copyright (C) 2016 jason m horwitz, Sekati LLC. All Rights Reserved.
 * @desc Wrapper for the visual console.
 * @see https://github.com/keshrath/Console
 */
 
////////////////////////////////////////////////////////////////////////////////
// DEPENDENCIES

import at.mukprojects.console.*;


////////////////////////////////////////////////////////////////////////////////
// DEFINITIONS

public class SKConsole {

  int CONSOLE_X = 0;
  int CONSOLE_Y = height-100;
  int CONSOLE_WIDTH = width;
  int CONSOLE_HEIGHT = height;
  int CONSOLE_FONTSIZE = 12;
  int CONSOLE_LINESPACE = 4;
  int CONSOLE_PADDING = 4;
  color CONSOLE_STROKE = color(255,255,255,5);
  color CONSOLE_BACKGROUND = color(20, 20, 20);
  color CONSOLE_FOREGROUND = color(200,0,200);
  boolean isAvailable; // Is logging on by default?
  boolean isVisible;  // Is logging visible in-app by default?
  Console console;

////////////////////////////////////////////////////////////////////////////////
// CUSTOM DECLARATIONS 


  /**
   * Constructor
   */
  SKConsole(Console c, boolean available, boolean visible) {
    console = c;
    isAvailable = available;
    isVisible = visible;
    initConsole();
}
 
 void initConsole(){
   log("SKConsole: Initializing... visible:"+isVisible+", availble:"+isAvailable);
   if (isVisible) console.start();
 }
 
 /**
  * Log to console
  */
 void log(String str) {
   //if(isAvailable) 
   println(str);
 }
 
 void toggle(){
   if(!isVisible) {
     unmute();
     show();
   } else {
     hide();
   }
 }
  
  void mute(){
    isAvailable = false;
  }
  
  void unmute(){
    isAvailable = true;
  }
  
  void show(){
    isVisible = true;
    console.start();
  }
  
  void hide(){
    isVisible = false;
    console.stop();
  }

  void draw(){  
    // x, y, width, height, preferredTextSize, minTextSize, linespace, padding, strokeColor, backgroundColor, textColor
    if(isVisible) {
      console.draw(CONSOLE_X, CONSOLE_Y, CONSOLE_WIDTH, CONSOLE_HEIGHT, CONSOLE_FONTSIZE, CONSOLE_FONTSIZE, CONSOLE_LINESPACE, CONSOLE_PADDING, CONSOLE_STROKE, CONSOLE_BACKGROUND, CONSOLE_FOREGROUND);
      console.print();
    }
  }

}