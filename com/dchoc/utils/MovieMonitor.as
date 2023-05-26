package com.dchoc.utils
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.system.System;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.utils.getTimer;
   
   public class MovieMonitor extends Sprite
   {
       
      
      private const xml:XML = <xml>
				<sectionTitle>FPS MONITOR</sectionTitle>
				<sectionLabel>FPS: </sectionLabel>
				<framesPerSecond>-</framesPerSecond>
				<sectionLabel>Minute average: </sectionLabel>
				<averageFPS>-</averageFPS>
				<sectionLabel>ms per frame: </sectionLabel>
				<msFrame>-</msFrame>
				<sectionTitle>MEMORY MONITOR</sectionTitle>
				<sectionLabel>Direct: </sectionLabel>
				<directMemory>-</directMemory>
				<sectionLabel>Max direct: </sectionLabel>
				<directMemoryMax>-</directMemoryMax>
				<sectionLabel>Total: </sectionLabel>
				<veryTotalMemory>-</veryTotalMemory>
				<sectionLabel>Garbage: </sectionLabel>
				<garbageMemory>-</garbageMemory>
				<sectionTitle>STAGE MONITOR</sectionTitle>
				<sectionLabel>Width: </sectionLabel>
				<widthPx>-</widthPx>
				<sectionLabel>Height: </sectionLabel>
				<heightPx>-</heightPx>
				<sectionLabel>Children: </sectionLabel>
				<nChildren>-</nChildren>
			</xml>;
      
      private const fpsVector:Vector.<Number> = new Vector.<Number>();
      
      private var textField:TextField;
      
      private var fps:int;
      
      private var ms:uint;
      
      private var lastTimeCheck:uint;
      
      private var maxMemory:Number = 0;
      
      public function MovieMonitor()
      {
         super();
         var _loc1_:StyleSheet = new StyleSheet();
         _loc1_.setStyle("xml",{
            "fontSize":"9px",
            "fontFamily":"arial"
         });
         _loc1_.setStyle("sectionTitle",{"color":"#FFAA00"});
         _loc1_.setStyle("sectionLabel",{
            "color":"#CCCCCC",
            "display":"inline"
         });
         _loc1_.setStyle("framesPerSecond",{"color":"#FFFFFF"});
         _loc1_.setStyle("msFrame",{"color":"#FFFFFF"});
         _loc1_.setStyle("averageFPS",{"color":"#FFFFFF"});
         _loc1_.setStyle("directMemory",{"color":"#FFFFFF"});
         _loc1_.setStyle("veryTotalMemory",{"color":"#FFFFFF"});
         _loc1_.setStyle("garbageMemory",{"color":"#FFFFFF"});
         _loc1_.setStyle("directMemoryMax",{"color":"#FFFFFF"});
         _loc1_.setStyle("widthPx",{"color":"#FFFFFF"});
         _loc1_.setStyle("heightPx",{"color":"#FFFFFF"});
         _loc1_.setStyle("nChildren",{"color":"#FFFFFF"});
         textField = new TextField();
         textField.alpha = 0.8;
         textField.autoSize = "left";
         textField.styleSheet = _loc1_;
         textField.condenseWhite = true;
         textField.selectable = false;
         textField.mouseEnabled = false;
         textField.background = true;
         textField.backgroundColor = 0;
         addChild(textField);
         addEventListener("enterFrame",update);
      }
      
      public function dispose() : void
      {
         removeEventListener("enterFrame",update);
      }
      
      private function update(e:Event) : void
      {
         var _loc4_:int = 0;
         var vectorAverage:Number = NaN;
         var i:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc5_:int = getTimer();
         if(_loc5_ - 1000 > lastTimeCheck)
         {
            _loc4_ = fpsVector.push(fps);
            if(_loc4_ > 60)
            {
               fpsVector.shift();
            }
            vectorAverage = 0;
            for(i = 0; i < fpsVector.length; )
            {
               vectorAverage += fpsVector[i];
               i++;
            }
            vectorAverage /= fpsVector.length;
            xml.averageFPS = Math.round(vectorAverage);
            _loc2_ = System.totalMemory;
            maxMemory = Math.max(_loc2_,maxMemory);
            xml.directMemory = (_loc2_ / 1048576).toFixed(3);
            xml.directMemoryMax = (maxMemory / 1048576).toFixed(3);
            xml.veryTotalMemory = (System.privateMemory / 1048576).toFixed(3);
            xml.garbageMemory = (System.freeMemory / 1048576).toFixed(3);
            xml.framesPerSecond = fps + " / " + stage.frameRate;
            xml.widthPx = stage.width + " / " + stage.stageWidth;
            xml.heightPx = stage.height + " / " + stage.stageHeight;
            xml.nChildren = countDisplayList(stage);
            fps = 0;
            lastTimeCheck = _loc5_;
         }
         fps++;
         xml.msFrame = _loc5_ - ms;
         ms = _loc5_;
         textField.htmlText = xml;
      }
      
      internal function countDisplayList(container:DisplayObjectContainer) : int
      {
         var i:* = 0;
         var childrenCount:int = container.numChildren;
         for(i = 0; i < container.numChildren; )
         {
            if(container.getChildAt(i) is DisplayObjectContainer)
            {
               childrenCount += countDisplayList(DisplayObjectContainer(container.getChildAt(i)));
            }
            i++;
         }
         return childrenCount;
      }
   }
}
