package tuxwars.ui.popups.states.levelup
{
   import com.dchoc.messages.MessageCenter;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.levelup.LevelUpPopUpLogic;
   import tuxwars.ui.popups.screen.levelup.LevelUpPopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class LevelUpPopupSubState extends PopUpBaseSubState
   {
      
      public static const TYPE_LEVEL_UP:String = "TypeLevelUp";
       
      
      public function LevelUpPopupSubState(game:TuxWarsGame, params:* = null)
      {
         super("TypeLevelUp",game,LevelUpPopUpScreen,LevelUpPopUpLogic,AssetsData.getPopupAssets(),params);
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
