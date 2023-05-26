package tuxwars.ui.popups.logic.passedstat
{
   public class PassedStatData
   {
       
      
      private var _data:Object;
      
      private var _stat:String;
      
      public function PassedStatData(data:Object, stat:String)
      {
         super();
         _data = data;
         _stat = stat;
      }
      
      public function get newPosition() : int
      {
         return _data.newPosition;
      }
      
      public function get newValue() : int
      {
         return _data.newValue;
      }
      
      public function get previousPlayerId() : String
      {
         return _data.previousPlace_dcgId;
      }
      
      public function get stat() : String
      {
         return _stat;
      }
   }
}
