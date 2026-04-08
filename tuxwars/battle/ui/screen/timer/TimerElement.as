package tuxwars.battle.ui.screen.timer
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.progress.*;
   import com.dchoc.ui.text.*;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   
   public class TimerElement extends UIContainer
   {
      private var game:TuxWarsGame;
      
      protected var slider:UIProgressIndicator;
      
      private const name:UIAutoTextField = new UIAutoTextField();
      
      private var time:TextField = new TextField();
      
      private var curTime:uint;
      
      public function TimerElement(param1:MovieClip, param2:UIComponent, param3:int, param4:int)
      {
         super(param1,param2);
         this.slider = new UIProgressIndicator(param1.Slider,param3,param4);
         this.name.setTextField(param1.Text_Name);
         this.name.setText("");
         this.time = param1.Text_Time;
         this.time.text = TextUtils.getShortTimeTextFromSeconds(param4 * 0.001);
         this.game = this.game;
         DCUtils.setBitmapSmoothing(true,param1);
         param1.mouseEnabled = false;
         param1.mouseChildren = false;
         setShowTransitions(false);
      }
      
      override public function dispose() : void
      {
         this.game = null;
         if(this.slider)
         {
            this.slider.dispose();
            this.slider = null;
         }
      }
      
      public function setText(param1:String) : void
      {
         this.name.setText(param1);
      }
      
      protected function setTimeText(param1:int) : void
      {
         var _loc2_:uint = param1 * 0.001;
         if(_loc2_ != this.curTime)
         {
            this.time.text = TextUtils.getShortTimeTextFromSeconds(_loc2_);
            this.curTime = _loc2_;
         }
      }
      
      protected function setTime(param1:int) : void
      {
         if(param1 != this.slider.getCurrentValue())
         {
            this.slider.setValueWithoutBarAnimation(param1);
            this.setTimeText(param1);
         }
      }
      
      public function logicUpdate(param1:int) : void
      {
         if(BattleManager.isBattleInProgress())
         {
            this.slider.logicUpdate(param1);
         }
      }
   }
}

