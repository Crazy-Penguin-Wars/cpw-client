package tuxwars.ui.components
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import flash.display.MovieClip;
   
   public class IconCoolDownButton extends IconButton
   {
       
      
      private var lastCoolDownTime:int;
      
      private var coolDownValue:int;
      
      public var coolDownMovieClip:MovieClip;
      
      private var coolDownDoneFlag:Boolean;
      
      private var type:String;
      
      public function IconCoolDownButton(design:MovieClip, parameter:Object = null, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         super(design,parameter,useDefaultSound,sounds,customSoundStatus);
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         setEnabled(cooldownDone);
      }
      
      public function setCoolDownTime(value:int) : void
      {
         coolDownValue = value;
         lastCoolDownTime = DCGame.getTime() - value;
      }
      
      override public function setEnabled(value:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var index:int = 0;
         super.setEnabled(value);
         if(!value)
         {
            coolDownMovieClip = this._design.Slider_Cooldown as MovieClip;
            _loc4_ = coolDownMovieClip.totalFrames;
            _loc3_ = coolDownValue;
            _loc5_ = DCGame.getTime() - lastCoolDownTime;
            index = _loc4_ * (_loc5_ / _loc3_);
            coolDownMovieClip.gotoAndStop(index);
            coolDownDoneFlag = false;
         }
         else if(!coolDownDoneFlag && cooldownDone)
         {
            if(type == "Booster")
            {
               coolDownDoneFlag = true;
               MessageCenter.sendMessage("BoosterReadyShine");
            }
            else if(type == "Emoticon")
            {
               coolDownDoneFlag = true;
               MessageCenter.sendMessage("EmoticonReadyShine");
            }
         }
      }
      
      public function get cooldownDone() : Boolean
      {
         return DCGame.getTime() - lastCoolDownTime >= coolDownValue;
      }
      
      public function activateCoolDown() : void
      {
         lastCoolDownTime = DCGame.getTime();
         setEnabled(false);
      }
      
      public function setType(value:String) : void
      {
         type = value;
      }
   }
}
