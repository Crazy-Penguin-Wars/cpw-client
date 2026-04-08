package tuxwars.ui.containers.shop
{
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.data.SetReference;
   import tuxwars.ui.containers.shop.container.settag.*;
   
   public class ContentSetTag extends Content
   {
      private static const EXTRA:String = "Extra";
      
      private static const NO_EXTRA:String = "No_Extra";
      
      private var _setText:UIAutoTextField;
      
      private var _setBonuses:UIAutoTextField;
      
      public function ContentSetTag(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:TuxUIScreen = null)
      {
         super(param1,param2,param3,param4);
         containers.add("Extra",new SetTagBonusTextContainer(param1.Extra,param2,param3,param4));
         containers.add("No_Extra",new SetTagContainer(param1.No_Extra,param2,param3,param4));
         containers.setAllVisible(false);
      }
      
      public function updateSetBonusText(param1:Boolean, param2:Boolean, param3:SetReference) : void
      {
         if(param1)
         {
            if(param2 && param3 && Boolean(param3.statBonusDescTextOverride))
            {
               containers.show("Extra",false);
            }
            else
            {
               containers.show("No_Extra",false);
            }
            if(param3 != null)
            {
               (containers.getCurrentContainer() as SetTagContainer).updateSetBonusText(param1,param2,param3);
            }
         }
         else
         {
            containers.setAllVisible(false);
         }
      }
   }
}

