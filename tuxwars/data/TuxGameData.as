package tuxwars.data
{
   import com.dchoc.data.GameData;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   
   public class TuxGameData extends GameData
   {
      private static const TID:String = "TID";
      
      public function TuxGameData(param1:Row)
      {
         super(param1);
      }
      
      public function getTID() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("TID");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
   }
}

