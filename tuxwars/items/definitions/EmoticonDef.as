package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.*;
   
   public class EmoticonDef extends ItemDef
   {
      private var _duration:int;
      
      public function EmoticonDef()
      {
         super();
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("GameData is not EmoticonData",true,param1 is EmoticonData);
         var _loc2_:EmoticonData = param1 as EmoticonData;
         this._duration = _loc2_.duration;
      }
      
      public function get duration() : int
      {
         return this._duration;
      }
   }
}

