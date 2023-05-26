package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.CustomizationData;
   
   public class CustomizationDef extends ClothingDef
   {
       
      
      public function CustomizationDef()
      {
         super();
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         assert("GameData is not CustomizationData",true,data is CustomizationData);
         super.loadDataConf(data);
      }
   }
}
