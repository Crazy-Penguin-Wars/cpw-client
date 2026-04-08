package tuxwars.home.ui.screen.equipment
{
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   
   public class EquipmentStats extends TuxUIElementScreen
   {
      private static const NORMAL:String = "Stats_Default";
      
      private static const SET:String = "Stats_Complete_Set";
      
      private var statsNormal:EquipmentStatsElement;
      
      private var statsSet:EquipmentStatsElement;
      
      public function EquipmentStats(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1,param2);
         this.statsNormal = new EquipmentStatsElement(getDesignMovieClip().getChildByName("Stats_Default") as MovieClip,param2,false);
         this.statsSet = new EquipmentStatsElement(getDesignMovieClip().getChildByName("Stats_Complete_Set") as MovieClip,param2,true);
      }
      
      override public function dispose() : void
      {
         this.statsNormal.dispose();
         this.statsNormal = null;
         this.statsSet.dispose();
         this.statsSet = null;
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

