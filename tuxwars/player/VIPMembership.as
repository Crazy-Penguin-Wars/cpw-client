package tuxwars.player
{
   import com.dchoc.game.DCGame;
   
   public class VIPMembership
   {
       
      
      private var _wasVip:Boolean;
      
      private var _vip:Boolean;
      
      private var _timeLeft:int;
      
      private var timestamp:int;
      
      private var _boughtPackId:String;
      
      public function VIPMembership()
      {
         super();
      }
      
      public function get vip() : Boolean
      {
         if(timeLeft <= 0)
         {
            _vip = false;
         }
         return _vip;
      }
      
      public function set vip(value:Boolean) : void
      {
         _vip = value;
         _wasVip = value;
      }
      
      public function set wasWip(value:Boolean) : void
      {
         _wasVip = value;
      }
      
      public function get timeLeft() : int
      {
         return _timeLeft - (DCGame.getTime() * 0.001 - timestamp);
      }
      
      public function set timeLeft(value:int) : void
      {
         _timeLeft = value;
         timestamp = DCGame.getTime() * 0.001;
      }
      
      public function set boughtPackId(packId:String) : void
      {
         _boughtPackId = packId;
      }
      
      public function get boughtPackId() : String
      {
         return _boughtPackId;
      }
      
      public function didWeLoseVip() : Boolean
      {
         if(_wasVip)
         {
            if(!vip)
            {
               _wasVip = false;
               return true;
            }
         }
         return false;
      }
   }
}
