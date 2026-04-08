package tuxwars.ui.components
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import flash.display.*;
   
   public class IconCoolDownButton extends IconButton
   {
      private var lastCoolDownTime:int;
      
      private var coolDownValue:int;
      
      public var coolDownMovieClip:MovieClip;
      
      private var coolDownDoneFlag:Boolean;
      
      private var type:String;
      
      public function IconCoolDownButton(param1:MovieClip, param2:Object = null, param3:Boolean = true, param4:Object = null, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public function logicUpdate(param1:int) : void
      {
         this.setEnabled(this.cooldownDone);
      }
      
      public function setCoolDownTime(param1:int) : void
      {
         this.coolDownValue = param1;
         this.lastCoolDownTime = DCGame.getTime() - param1;
      }
      
      override public function setEnabled(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.setEnabled(param1);
         if(!param1)
         {
            this.coolDownMovieClip = this._design.Slider_Cooldown as MovieClip;
            _loc2_ = this.coolDownMovieClip.totalFrames;
            _loc3_ = int(this.coolDownValue);
            _loc4_ = DCGame.getTime() - this.lastCoolDownTime;
            _loc5_ = _loc2_ * (_loc4_ / _loc3_);
            this.coolDownMovieClip.gotoAndStop(_loc5_);
            this.coolDownDoneFlag = false;
         }
         else if(!this.coolDownDoneFlag && this.cooldownDone)
         {
            if(this.type == "Booster")
            {
               this.coolDownDoneFlag = true;
               MessageCenter.sendMessage("BoosterReadyShine");
            }
            else if(this.type == "Emoticon")
            {
               this.coolDownDoneFlag = true;
               MessageCenter.sendMessage("EmoticonReadyShine");
            }
         }
      }
      
      public function get cooldownDone() : Boolean
      {
         return DCGame.getTime() - this.lastCoolDownTime >= this.coolDownValue;
      }
      
      public function activateCoolDown() : void
      {
         this.lastCoolDownTime = DCGame.getTime();
         this.setEnabled(false);
      }
      
      public function setType(param1:String) : void
      {
         this.type = param1;
      }
   }
}

