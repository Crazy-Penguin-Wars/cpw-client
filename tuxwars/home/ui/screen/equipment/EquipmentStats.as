package tuxwars.home.ui.screen.equipment
{
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   
   public class EquipmentStats extends TuxUIElementScreen
   {
      
      private static const NORMAL:String = "Stats_Default";
      
      private static const SET:String = "Stats_Complete_Set";
       
      
      private var statsNormal:EquipmentStatsElement;
      
      private var statsSet:EquipmentStatsElement;
      
      public function EquipmentStats(design:MovieClip, game:TuxWarsGame)
      {
         super(design,game);
         statsNormal = new EquipmentStatsElement(getDesignMovieClip().getChildByName("Stats_Default") as MovieClip,game,false);
         statsSet = new EquipmentStatsElement(getDesignMovieClip().getChildByName("Stats_Complete_Set") as MovieClip,game,true);
      }
      
      override public function dispose() : void
      {
         statsNormal.dispose();
         statsNormal = null;
         statsSet.dispose();
         statsSet = null;
         super.dispose();
      }
      
      public function playMovieClip() : void
      {
         DCUtils.playMovieClip(getDesignMovieClip().getChildByName("Stats_Default") as MovieClip);
         DCUtils.playMovieClip(getDesignMovieClip().getChildByName("Stats_Complete_Set") as MovieClip);
      }
      
      public function stopMovieClip() : void
      {
         DCUtils.stopMovieClip(getDesignMovieClip().getChildByName("Stats_Default") as MovieClip);
         DCUtils.stopMovieClip(getDesignMovieClip().getChildByName("Stats_Complete_Set") as MovieClip);
      }
   }
}
