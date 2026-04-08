package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.*;
   
   public class CustomizationDef extends ClothingDef
   {
      public function CustomizationDef()
      {
         super();
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         assert("GameData is not CustomizationData",true,param1 is CustomizationData);
         super.loadDataConf(param1);
      }
   }
}

