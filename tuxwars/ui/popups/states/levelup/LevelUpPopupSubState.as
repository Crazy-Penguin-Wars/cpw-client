package tuxwars.ui.popups.states.levelup
{
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.levelup.*;
   import tuxwars.ui.popups.screen.levelup.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class LevelUpPopupSubState extends PopUpBaseSubState
   {
      public static const TYPE_LEVEL_UP:String = "TypeLevelUp";
      
      public function LevelUpPopupSubState(param1:TuxWarsGame, param2:* = null)
      {
         super("TypeLevelUp",param1,LevelUpPopUpScreen,LevelUpPopUpLogic,AssetsData.getPopupAssets(),param2);
      }
      
      override protected function playEnterSound() : void
      {
         var _loc1_:SoundReference = Sounds.getSoundReference("LevelUpSound");
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
         }
      }
   }
}

