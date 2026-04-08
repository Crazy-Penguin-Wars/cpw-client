package tuxwars.ui.popups.logic.passedstat
{
   public class PassedStatData
   {
      private var _data:Object;
      
      private var _stat:String;
      
      public function PassedStatData(param1:Object, param2:String)
      {
         super();
         this._data = param1;
         this._stat = param2;
      }
      
      public function get newPosition() : int
      {
         return this._data.newPosition;
      }
      
      public function get newValue() : int
      {
         return this._data.newValue;
      }
      
      public function get previousPlayerId() : String
      {
         return this._data.previousPlace_dcgId;
      }
      
      public function get stat() : String
      {
         return this._stat;
      }
   }
}

