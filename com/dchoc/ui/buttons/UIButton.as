package com.dchoc.ui.buttons
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.UIButtonConfig;
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   
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
      
      private var sounds:Object;
      
      private var soundStatus:Boolean = true;
      
      private var _clickPostCallbackEvent:Boolean;
      
      public function UIButton(design:MovieClip, parameter:Object = null, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         sounds = {};
         super(design);
         design.stop();
         design.mouseEnabled = true;
         var textField:TextField = design.getChildByName("Text") as TextField;
         if(textField)
         {
            setText(textField.text);
            textFormat = textField.defaultTextFormat;
         }
         setParameter(parameter);
         setEnabled(true);
         isButtonDown = false;
         isMouseOver = false;
         setHitArea();
         setHandCursor(true);
         addListeners();
         setState("Visible");
         if(sounds)
         {
            setSounds(sounds);
         }
         else
         {
            setSounds(UIButtonConfig.getSounds());
         }
         if(useDefaultSound)
         {
            setSoundStatus(UIButtonConfig.getSoundStatus());
         }
         else
         {
            setSoundStatus(customSoundStatus);
         }
      }
      
      public function get clickPostCallbackEvent() : Boolean
      {
         return _clickPostCallbackEvent;
      }
      
      public function set clickPostCallbackEvent(value:Boolean) : void
      {
         _clickPostCallbackEvent = value;
      }
      
      override public function dispose() : void
      {
         if(this._design)
         {
            removeListeners();
         }
         mouseClickCallBack = null;
         mouseDownCallback = null;
         mouseOutCallBack = null;
         mouseOverCallBack = null;
         mouseUpCallback = null;
         super.dispose();
      }
      
      public function setMouseClickFunction(callback:Function) : void
      {
         mouseClickCallBack = callback;
      }
      
      public function setMouseOverFunction(callback:Function) : void
      {
         mouseOverCallBack = callback;
      }
      
      public function setMouseOutFunction(callback:Function) : void
      {
         mouseOutCallBack = callback;
      }
      
      public function setMouseUpCallback(callback:Function) : void
      {
         mouseUpCallback = callback;
      }
      
      public function setMouseDownCallback(callback:Function) : void
      {
         mouseDownCallback = callback;
      }
      
      protected function setHandCursor(show:Boolean) : void
      {
         getDesignMovieClip().buttonMode = show;
         getDesignMovieClip().mouseChildren = !show;
         getDesignMovieClip().useHandCursor = show;
      }
      
      override protected function playAnimation(frameLabel:String) : Boolean
      {
         if(super.playAnimation(frameLabel))
         {
            updateTextField();
            return true;
         }
         return false;
      }
      
      public function setHitArea(area:MovieClip = null) : void
      {
         if(area == null)
         {
            area = getDesignMovieClip().getChildByName("Hit_Area") as MovieClip;
         }
         if(area != null)
         {
            area.visible = false;
            getDesignMovieClip().hitArea = area;
         }
      }
      
      public function setSounds(buttonSounds:Object) : void
      {
         this.sounds = buttonSounds;
      }
      
      public function setSoundsNewObject(onClick:String = null, onOver:String = null) : void
      {
         var o:Object = {};
         o["on_click"] = !!onClick ? onClick : this.sounds["on_click"];
         o["on_olick"] = !!onOver ? onOver : this.sounds["on_olick"];
         this.sounds = o;
      }
      
      public function getSounds() : Object
      {
         return this.sounds;
      }
      
      public function setSoundStatus(value:Boolean) : void
      {
         soundStatus = value;
      }
      
      private function getButtonSound(action:String) : String
      {
         return sounds[action] as String;
      }
      
      protected function mouseDownHandler(event:MouseEvent) : void
      {
         setState("Down");
         isButtonDown = true;
         dispatchEvent(new UIButtonEvent(this,"down",parameter));
         if(mouseDownCallback != null)
         {
            mouseDownCallback(event);
         }
      }
      
      protected function mouseUpHandler(event:MouseEvent) : void
      {
         var sound:* = null;
         var sound2:* = null;
         if(isButtonDown)
         {
            if(soundStatus)
            {
               sound = getButtonSound("on_click");
               if(sound)
               {
                  sound2 = Sounds.getSoundReference(sound);
                  if(sound2)
                  {
                     MessageCenter.sendEvent(new SoundMessage("PlaySound",sound2.getMusicID(),sound2.getStart(),sound2.getType(),"PlaySound"));
                  }
               }
            }
            isButtonDown = false;
            isMouseOver = true;
            if(isMouseOver)
            {
               setState("Hover");
            }
            else
            {
               setState("Visible");
            }
            click(event);
            if(mouseUpCallback != null)
            {
               mouseUpCallback(event);
            }
         }
      }
      
      protected function click(event:MouseEvent) : void
      {
         dispatchEvent(new UIButtonEvent(this,"clicked",parameter));
         if(mouseClickCallBack != null)
         {
            mouseClickCallBack(event);
         }
         if(_clickPostCallbackEvent)
         {
            dispatchEvent(new UIButtonEvent(this,"clicked_post_callback",parameter));
         }
      }
      
      protected function mouseOverCallback(event:MouseEvent) : void
      {
         var sound:* = null;
         var sound2:* = null;
         if(soundStatus)
         {
            sound = getButtonSound("on_olick");
            if(sound)
            {
               sound2 = Sounds.getSoundReference(sound);
               if(sound2)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",sound2.getMusicID(),sound2.getStart(),sound2.getType(),"PlaySound"));
               }
            }
         }
         setState("Hover");
         isMouseOver = true;
         dispatchEvent(new UIButtonEvent(this,"over",parameter));
         if(mouseOverCallBack != null)
         {
            mouseOverCallBack(event);
         }
      }
      
      protected function mouseOutCallback(event:MouseEvent) : void
      {
         setState("Visible");
         isButtonDown = false;
         isMouseOver = false;
         dispatchEvent(new UIButtonEvent(this,"out",parameter));
         if(mouseOutCallBack != null)
         {
            mouseOutCallBack(event);
         }
      }
      
      private function addListeners() : void
      {
         this._design.addEventListener("mouseDown",mouseDownHandler,false,0,true);
         this._design.addEventListener("mouseUp",mouseUpHandler,false,0,true);
         this._design.addEventListener("mouseOver",mouseOverCallback,false,0,true);
         this._design.addEventListener("mouseOut",mouseOutCallback,false,0,true);
      }
      
      private function removeListeners() : void
      {
         this._design.removeEventListener("mouseDown",mouseDownHandler);
         this._design.removeEventListener("mouseUp",mouseUpHandler);
         this._design.removeEventListener("mouseOver",mouseOverCallback);
         this._design.removeEventListener("mouseOut",mouseOutCallback);
      }
      
      override protected function updateTextField() : void
      {
         var autoTextField:* = null;
         var _loc1_:* = null;
         if(text == null)
         {
            return;
         }
         var tf:TextField = getDesignMovieClip().getChildByName("Text") as TextField;
         if(tf)
         {
            autoTextField = new UIAutoTextField(tf);
            autoTextField.setHorizontalAlignment(3,false);
            autoTextField.setVerticalAlignment(1,false);
            autoTextField.getTextField().selectable = false;
            autoTextField.setText(text);
            if(textFormat != null)
            {
               autoTextField.getTextField().defaultTextFormat = textFormat;
            }
         }
         else
         {
            _loc1_ = getDesignMovieClip().Icon_Text;
            if(_loc1_)
            {
               tf = _loc1_.getChildByName("Text") as TextField;
               if(tf)
               {
                  autoTextField = new UIAutoTextField(tf);
                  autoTextField.setHorizontalAlignment(3,false);
                  autoTextField.setVerticalAlignment(1,false);
                  autoTextField.getTextField().selectable = false;
                  autoTextField.setText(text);
                  if(textFormat != null)
                  {
                     autoTextField.getTextField().defaultTextFormat = textFormat;
                  }
               }
            }
         }
         super.updateTextField();
      }
      
      public function getEnabled() : Boolean
      {
         return enabled;
      }
      
      public function setEnabled(value:Boolean) : void
      {
         enabled = value;
         setHandCursor(enabled);
         if(enabled)
         {
            setState("Visible");
            addListeners();
         }
         else
         {
            setState("Disabled");
            removeListeners();
            isButtonDown = false;
         }
      }
      
      override public function setVisible(value:Boolean) : void
      {
         if(value)
         {
            addListeners();
         }
         else
         {
            removeListeners();
         }
         super.setVisible(value);
         getDesignMovieClip().visible = value;
      }
      
      public function getText() : String
      {
         return text;
      }
      
      public function setText(value:String) : void
      {
         text = value;
         updateTextField();
      }
      
      public function getTextFormat() : TextFormat
      {
         return textFormat;
      }
      
      public function getParameter() : Object
      {
         return parameter;
      }
      
      public function setParameter(value:Object) : void
      {
         parameter = value;
      }
      
      public function isDown() : Boolean
      {
         return isButtonDown;
      }
      
      public function isOver() : Boolean
      {
         return isMouseOver;
      }
   }
}
