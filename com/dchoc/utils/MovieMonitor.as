package com.dchoc.utils
{
   import flash.display.*;
   import flash.events.Event;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
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
         this.textField = new TextField();
         this.textField.alpha = 0.8;
         this.textField.autoSize = "left";
         this.textField.styleSheet = _loc1_;
         this.textField.condenseWhite = true;
         this.textField.selectable = false;
         this.textField.mouseEnabled = false;
         this.textField.background = true;
         this.textField.backgroundColor = 0;
         addChild(this.textField);
         addEventListener("enterFrame",this.update);
      }
      
      public function dispose() : void
      {
         removeEventListener("enterFrame",this.update);
      }
      
      private function update(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:int = int(getTimer());
         if(_loc6_ - 1000 > this.lastTimeCheck)
         {
            _loc2_ = int(this.fpsVector.push(this.fps));
            if(_loc2_ > 60)
            {
               this.fpsVector.shift();
            }
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < this.fpsVector.length)
            {
               _loc3_ += this.fpsVector[_loc4_];
               _loc4_++;
            }
            _loc3_ /= this.fpsVector.length;
            this.xml.averageFPS = Math.round(_loc3_);
            _loc5_ = Number(System.totalMemory);
            this.maxMemory = Math.max(_loc5_,this.maxMemory);
            this.xml.directMemory = (_loc5_ / 1048576).toFixed(3);
            this.xml.directMemoryMax = (this.maxMemory / 1048576).toFixed(3);
            this.xml.veryTotalMemory = (System.privateMemory / 1048576).toFixed(3);
            this.xml.garbageMemory = (System.freeMemory / 1048576).toFixed(3);
            this.xml.framesPerSecond = this.fps + " / " + stage.frameRate;
            this.xml.widthPx = stage.width + " / " + stage.stageWidth;
            this.xml.heightPx = stage.height + " / " + stage.stageHeight;
            this.xml.nChildren = this.countDisplayList(stage);
            this.fps = 0;
            this.lastTimeCheck = _loc6_;
         }
         ++this.fps;
         this.xml.msFrame = _loc6_ - this.ms;
         this.ms = _loc6_;
         this.textField.htmlText = this.xml;
      }
      
      internal function countDisplayList(param1:DisplayObjectContainer) : int
      {
         var _loc2_:* = 0;
         var _loc3_:int = param1.numChildren;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            if(param1.getChildAt(_loc2_) is DisplayObjectContainer)
            {
               _loc3_ += this.countDisplayList(DisplayObjectContainer(param1.getChildAt(_loc2_)));
            }
            _loc2_++;
         }
         return _loc3_;
      }
   }
}

