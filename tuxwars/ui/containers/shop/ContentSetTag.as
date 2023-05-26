package tuxwars.ui.containers.shop
{
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.data.SetReference;
   import tuxwars.ui.containers.shop.container.settag.SetTagBonusTextContainer;
   import tuxwars.ui.containers.shop.container.settag.SetTagContainer;
   
   public class ContentSetTag extends Content
   {
      
      private static const EXTRA:String = "Extra";
      
      private static const NO_EXTRA:String = "No_Extra";
       
      
      private var _setText:UIAutoTextField;
      
      private var _setBonuses:UIAutoTextField;
      
      public function ContentSetTag(design:MovieClip, data:*, game:TuxWarsGame, parent:TuxUIScreen = null)
      {
         super(design,data,game,parent);
         containers.add("Extra",new SetTagBonusTextContainer(design.Extra,data,game,parent));
         containers.add("No_Extra",new SetTagContainer(design.No_Extra,data,game,parent));
         containers.setAllVisible(false);
      }
      
      public function updateSetBonusText(isSetStats:Boolean, hasSet:Boolean, setReference:SetReference) : void
      {
         if(isSetStats)
         {
            if(hasSet && setReference && setReference.statBonusDescTextOverride)
            {
               containers.show("Extra",false);
            }
            else
            {
               containers.show("No_Extra",false);
            }
            if(setReference != null)
            {
               (containers.getCurrentContainer() as SetTagContainer).updateSetBonusText(isSetStats,hasSet,setReference);
            }
         }
         else
         {
            containers.setAllVisible(false);
         }
      }
   }
}
