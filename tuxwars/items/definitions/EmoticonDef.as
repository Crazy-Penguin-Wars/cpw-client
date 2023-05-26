package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.EmoticonData;
   
   public class EmoticonDef extends ItemDef
   {
       
      
      private var _duration:int;
      
      public function EmoticonDef()
      {
         super();
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("GameData is not EmoticonData",true,data is EmoticonData);
         var _loc2_:EmoticonData = data as EmoticonData;
         _duration = _loc2_.duration;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
   }
}
