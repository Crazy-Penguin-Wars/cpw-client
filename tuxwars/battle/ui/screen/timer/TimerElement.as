package tuxwars.battle.ui.screen.timer
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.progress.UIProgressIndicator;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.TextUtils;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   
   public class TimerElement extends UIContainer
   {
       
      
      private var game:TuxWarsGame;
      
      protected var slider:UIProgressIndicator;
      
      private const name:UIAutoTextField = new UIAutoTextField();
      
      private var time:TextField;
      
      private var curTime:uint;
      
      public function TimerElement(design:MovieClip, parent:UIComponent, minValueInMS:int, maxValueInMS:int)
      {
         time = new TextField();
         super(design,parent);
         slider = new UIProgressIndicator(design.Slider,minValueInMS,maxValueInMS);
         name.setTextField(design.Text_Name);
         name.setText("");
         time = design.Text_Time;
         time.text = TextUtils.getShortTimeTextFromSeconds(maxValueInMS * 0.001);
         this.game = game;
         DCUtils.setBitmapSmoothing(true,design);
         design.mouseEnabled = false;
         design.mouseChildren = false;
         setShowTransitions(false);
      }
      
      override public function dispose() : void
      {
         game = null;
         if(slider)
         {
            slider.dispose();
            slider = null;
         }
      }
      
      public function setText(text:String) : void
      {
         name.setText(text);
      }
      
      protected function setTimeText(ms:int) : void
      {
         var _loc2_:uint = ms * 0.001;
         if(_loc2_ != curTime)
         {
            time.text = TextUtils.getShortTimeTextFromSeconds(_loc2_);
            curTime = _loc2_;
         }
      }
      
      protected function setTime(ms:int) : void
      {
         if(ms != slider.getCurrentValue())
         {
            slider.setValueWithoutBarAnimation(ms);
            setTimeText(ms);
         }
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         if(BattleManager.isBattleInProgress())
         {
            slider.logicUpdate(deltaTime);
         }
      }
   }
}
