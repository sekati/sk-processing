/**
 * SKApp
 * @version 1.0.0
 * @author jason m horwitz, sekati.com
 * Copyright (C) 2016 jason m horwitz, Sekati LLC. All Rights Reserved.
 * @desc Template Processing 3 App w/ control interface
 */
 
////////////////////////////////////////////////////////////////////////////////
// DEPENDENCIES

import at.mukprojects.console.*;
import websockets.*;


////////////////////////////////////////////////////////////////////////////////
// PROJECT META

String NAME = "SKApp";
String VERSION = "v1.0.0";


////////////////////////////////////////////////////////////////////////////////
// DEFINITIONS

boolean DEBUG_MODE = true;               // Display debug console in-app
boolean WEBSOCKET_SERVER = true;         // Enable internal WebSocket Server
boolean FULLSCREEN = false;               // app fullscreen @see https://processing.org/reference/fullScreen_.html
int DISPLAY = 1;                         // fullscreen hardware display index 
String RENDERER = P2D;                   // renderer to use: P2D, P3D, JAVA2D (default)
int STAGE_WIDTH = 800;                   // app width
int STAGE_HEIGHT = 600;                  // app height
int STAGE_X = 0;                         // app x
int STAGE_Y = 0;                         // app y
int STAGE_FRAMERATE = 30;                // app framerate
int STAGE_BACKGROUND = color(0,0,0);     // app background color
int SERIAL_BAUD = 9600;                  // Serial Port BAUD rate (9600-19200)
int WEBSOCKET_PORT = 8025;               // WebSocket Port
String WEBSOCKET_PATH = "sk";            // WebSocket App Name
SKConsole console;
WebsocketServer ws; 

////////////////////////////////////////////////////////////////////////////////
// CUSTOM DECLARATIONS 
 
int x = 0;


////////////////////////////////////////////////////////////////////////////////
// CUSTOM CODE BEGINS

/**
 * Init application
 */
void customSetup(){

}

/**
 * Init custom rendering
 */
void customDraw(){

  fill(102);  
  rect(x, 0, 1, STAGE_HEIGHT); 
  if (x > STAGE_WIDTH) {
    clear();
    x = 0;
  } else {
    x = x + 2;
  }  
  
  //console.log("log:" + str(x));
  
}


// CUSTOM CODE ENDS
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// PRIVATE CODE BEGINS

/** 
 * Initialize app settings
 * @see https://processing.org/reference/settings_.html
 */ 
void settings(){
  size(STAGE_WIDTH, STAGE_HEIGHT);
  if (FULLSCREEN) fullScreen(RENDERER, DISPLAY);
  println("INIT: settings ...");    
}

/**
 * Init the application
 */
void setup() {
  frameRate(STAGE_FRAMERATE);
  background(STAGE_BACKGROUND);
  frame.setLocation(STAGE_X, STAGE_Y);
  // @see https://processing.org/reference/smooth_.html
  //smooth();
  noStroke();  
  
  console = new SKConsole(new Console(this), DEBUG_MODE, DEBUG_MODE);
  
  console.log(NAME+" "+VERSION+" Initializing...");
  console.log("INIT: Setup...");
  
  if(WEBSOCKET_SERVER) {
    initWebSocketServer();
  }
   
  customSetup();
}

/**
 * Init the app render loop
 */
void draw() {
  customDraw();
  console.draw();
}

/**
 * Init WebSocket Server
 * @see https://github.com/alexandrainst/processing_websockets
 */
void initWebSocketServer(){
  String msg = "INIT: WebSocketServer @ :"+WEBSOCKET_PORT+"/"+WEBSOCKET_PATH;
  console.log(msg);
  ws = new WebsocketServer(this, WEBSOCKET_PORT,"/"+WEBSOCKET_PATH);
  ws.sendMessage(msg);
}

/**
 * Receive WebSocket Events
 */
void webSocketServerEvent(String msg){
 console.log(msg);
}

/**
 * Key Management
 * @see http://processingjs.org/reference/key/
 */
void keyPressed() {
  if (key == CODED) {
    //console.log("KEY: "+keyCode);
    String msg = str(millis()) + ": "+str(keyCode);
    ws.sendMessage(msg);
    if(keyCode == SHIFT) {
      println("HALTING CONSOLE");
      console.toggle();
    }
    
    /*
    if (keyCode == UP) {
      println("UP");
      console.hide();
    } else if (keyCode == DOWN) {
      //fillVal = 0;
      println("down");
      console.show();
    }
    */
  }
}


// PRIVATE CODE ENDS
////////////////////////////////////////////////////////////////////////////////