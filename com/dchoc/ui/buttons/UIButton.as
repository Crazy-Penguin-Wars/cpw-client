package com.dchoc.ui.buttons
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.*;
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.ui.events.*;
   import com.dchoc.ui.text.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.data.*;
   
   public class UIButton extends UIStateComponent
   {
      public static const ON_CLICK:String = "on_click";
      
      public static const ON_OVER:String = "on_olick";
      
      private static const TEXT_FIELD_NAME:String = "Text";
      
      protected static const BUTTON_USE_HAND_CURSOR:Boolean = true;
      
      protected const HIT_AREA:String = "Hit_Area";
      
      protected var text:String;
      
      protected var textFormat:TextFormat;
      
      private var parameter:Object;
      
      private var enabled:Boolean;
      
      private var isButtonDown:Boolean;
      
      private var isMouseOver:Boolean;
      
      private var mouseClickCallBack:Function;
      
      private var mouseOverCallBack:Function;
      
      private var mouseOutCallBack:Function;
      
      private var mouseUpCallback:Function;
      
      private var mouseDownCallback:Function;
      
      private var sounds:Object = {};
      
      private var soundStatus:Boolean = true;
      
      private var _clickPostCallbackEvent:Boolean;
      
      public function UIButton(param1:MovieClip, param2:Object = null, param3:Boolean = true, param4:Object = null, param5:Boolean = false)
      {
         super(param1);
         param1.stop();
         param1.mouseEnabled = true;
         var _loc6_:TextField = param1.getChildByName("Text") as TextField;
         if(_loc6_)
         {
            this.setText(_loc6_.text);
            this.textFormat = _loc6_.defaultTextFormat;
         }
         this.setParameter(param2);
         this.setEnabled(true);
         this.isButtonDown = false;
         this.isMouseOver = false;
         this.setHitArea();
         this.setHandCursor(true);
         this.addListeners();
         setState("Visible");
         if(param4)
         {
            this.setSounds(param4);
         }
         else
         {
            this.setSounds(UIButtonConfig.getSounds());
         }
         if(param3)
         {
            this.setSoundStatus(UIButtonConfig.getSoundStatus());
         }
         else
         {
            this.setSoundStatus(param5);
         }
      }
      
      public function get clickPostCallbackEvent() : Boolean
      {
         return this._clickPostCallbackEvent;
      }
      
      public function set clickPostCallbackEvent(param1:Boolean) : void
      {
         this._clickPostCallbackEvent = param1;
      }
      
      override public function dispose() : void
      {
         if(this._design)
         {
            this.removeListeners();
         }
         this.mouseClickCallBack = null;
         this.mouseDownCallback = null;
         this.mouseOutCallBack = null;
         this.mouseOverCallBack = null;
         this.mouseUpCallback = null;
         super.dispose();
      }
      
      public function setMouseClickFunction(param1:Function) : void
      {
         this.mouseClickCallBack = param1;
      }
      
      public function setMouseOverFunction(param1:Function) : void
      {
         this.mouseOverCallBack = param1;
      }
      
      public function setMouseOutFunction(param1:Function) : void
      {
         this.mouseOutCallBack = param1;
      }
      
      public function setMouseUpCallback(param1:Function) : void
      {
         this.mouseUpCallback = param1;
      }
      
      public function setMouseDownCallback(param1:Function) : void
      {
         this.mouseDownCallback = param1;
      }
      
      protected function setHandCursor(param1:Boolean) : void
      {
         getDesignMovieClip().buttonMode = param1;
         getDesignMovieClip().mouseChildren = !param1;
         getDesignMovieClip().useHandCursor = param1;
      }
      
      override protected function playAnimation(param1:String) : Boolean
      {
         if(super.playAnimation(param1))
         {
            this.updateTextField();
            return true;
         }
         return false;
      }
      
      public function setHitArea(param1:MovieClip = null) : void
      {
         if(param1 == null)
         {
            param1 = getDesignMovieClip().getChildByName("Hit_Area") as MovieClip;
         }
         if(param1 != null)
         {
            param1.visible = false;
            getDesignMovieClip().hitArea = param1;
         }
      }
      
      public function setSounds(param1:Object) : void
      {
         this.sounds = param1;
      }
      
      public function setSoundsNewObject(param1:String = null, param2:String = null) : void
      {
         var _loc3_:Object = {};
         _loc3_["on_click"] = !!param1 ? param1 : this.sounds["on_click"];
         _loc3_["on_olick"] = !!param2 ? param2 : this.sounds["on_olick"];
         this.sounds = _loc3_;
      }
      
      public function getSounds() : Object
      {
         return this.sounds;
      }
      
      public function setSoundStatus(param1:Boolean) : void
      {
         this.soundStatus = param1;
      }
      
      private function getButtonSound(param1:String) : String
      {
         return this.sounds[param1] as String;
      }
      
      protected function mouseDownHandler(param1:MouseEvent) : void
      {
         setState("Down");
         this.isButtonDown = true;
         dispatchEvent(new UIButtonEvent(this,"down",this.parameter));
         if(this.mouseDownCallback != null)
         {
            this.mouseDownCallback(param1);
         }
      }
      
      protected function mouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:SoundReference = null;
         if(this.isButtonDown)
         {
            if(this.soundStatus)
            {
               _loc2_ = this.getButtonSound("on_click");
               if(_loc2_)
               {
                  _loc3_ = Sounds.getSoundReference(_loc2_);
                  if(_loc3_)
                  {
                     MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
                  }
               }
            }
            this.isButtonDown = false;
            this.isMouseOver = true;
            if(this.isMouseOver)
            {
               setState("Hover");
            }
            else
            {
               setState("Visible");
            }
            this.click(param1);
            if(this.mouseUpCallback != null)
            {
               this.mouseUpCallback(param1);
            }
         }
      }
      
      protected function click(param1:MouseEvent) : void
      {
         dispatchEvent(new UIButtonEvent(this,"clicked",this.parameter));
         if(this.mouseClickCallBack != null)
         {
            this.mouseClickCallBack(param1);
         }
         if(this._clickPostCallbackEvent)
         {
            dispatchEvent(new UIButtonEvent(this,"clicked_post_callback",this.parameter));
         }
      }
      
      protected function mouseOverCallback(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:SoundReference = null;
         if(this.soundStatus)
         {
            _loc2_ = this.getButtonSound("on_olick");
            if(_loc2_)
            {
               _loc3_ = Sounds.getSoundReference(_loc2_);
               if(_loc3_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
               }
            }
         }
         setState("Hover");
         this.isMouseOver = true;
         dispatchEvent(new UIButtonEvent(this,"over",this.parameter));
         if(this.mouseOverCallBack != null)
         {
            this.mouseOverCallBack(param1);
         }
      }
      
      protected function mouseOutCallback(param1:MouseEvent) : void
      {
         setState("Visible");
         this.isButtonDown = false;
         this.isMouseOver = false;
         dispatchEvent(new UIButtonEvent(this,"out",this.parameter));
         if(this.mouseOutCallBack != null)
         {
            this.mouseOutCallBack(param1);
         }
      }
      
      private function addListeners() : void
      {
         this._design.addEventListener("mouseDown",this.mouseDownHandler,false,0,true);
         this._design.addEventListener("mouseUp",this.mouseUpHandler,false,0,true);
         this._design.addEventListener("mouseOver",this.mouseOverCallback,false,0,true);
         this._design.addEventListener("mouseOut",this.mouseOutCallback,false,0,true);
      }
      
      private function removeListeners() : void
      {
         this._design.removeEventListener("mouseDown",this.mouseDownHandler);
         this._design.removeEventListener("mouseUp",this.mouseUpHandler);
         this._design.removeEventListener("mouseOver",this.mouseOverCallback);
         this._design.removeEventListener("mouseOut",this.mouseOutCallback);
      }
      
      override protected function updateTextField() : void
      {
         var _loc1_:UIAutoTextField = null;
         var _loc2_:DisplayObjectContainer = null;
         if(this.text == null)
         {
            return;
         }
         var _loc3_:TextField = getDesignMovieClip().getChildByName("Text") as TextField;
         if(_loc3_)
         {
            _loc1_ = new UIAutoTextField(_loc3_);
            _loc1_.setHorizontalAlignment(3,false);
            _loc1_.setVerticalAlignment(1,false);
            _loc1_.getTextField().selectable = false;
            _loc1_.setText(this.text);
            if(this.textFormat != null)
            {
               _loc1_.getTextField().defaultTextFormat = this.textFormat;
            }
         }
         else
         {
            _loc2_ = getDesignMovieClip().Icon_Text;
            if(_loc2_)
            {
               _loc3_ = _loc2_.getChildByName("Text") as TextField;
               if(_loc3_)
               {
                  _loc1_ = new UIAutoTextField(_loc3_);
                  _loc1_.setHorizontalAlignment(3,false);
                  _loc1_.setVerticalAlignment(1,false);
                  _loc1_.getTextField().selectable = false;
                  _loc1_.setText(this.text);
                  if(this.textFormat != null)
                  {
                     _loc1_.getTextField().defaultTextFormat = this.textFormat;
                  }
               }
            }
         }
         super.updateTextField();
      }
      
      public function getEnabled() : Boolean
      {
         return this.enabled;
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         this.enabled = param1;
         this.setHandCursor(this.enabled);
         if(this.enabled)
         {
            setState("Visible");
            this.addListeners();
         }
         else
         {
            setState("Disabled");
            this.removeListeners();
            this.isButtonDown = false;
         }
      }
      
      override public function setVisible(param1:Boolean) : void
      {
         if(param1)
         {
            this.addListeners();
         }
         else
         {
            this.removeListeners();
         }
         super.setVisible(param1);
         getDesignMovieClip().visible = param1;
      }
      
      public function getText() : String
      {
         return this.text;
      }
      
      public function setText(param1:String) : void
      {
         this.text = param1;
         this.updateTextField();
      }
      
      public function getTextFormat() : TextFormat
      {
         return this.textFormat;
      }
      
      public function getParameter() : Object
      {
         return this.parameter;
      }
      
      public function setParameter(param1:Object) : void
      {
         this.parameter = param1;
      }
      
      public function isDown() : Boolean
      {
         return this.isButtonDown;
      }
      
      public function isOver() : Boolean
      {
         return this.isMouseOver;
      }
   }
}

