package tuxwars.player
{
   import com.dchoc.game.*;
   
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
         if(this.timeLeft <= 0)
         {
            this._vip = false;
         }
         return this._vip;
      }
      
      public function set vip(param1:Boolean) : void
      {
         this._vip = param1;
         this._wasVip = param1;
      }
      
      public function set wasWip(param1:Boolean) : void
      {
         this._wasVip = param1;
      }
      
      public function get timeLeft() : int
      {
         return this._timeLeft - (DCGame.getTime() * 0.001 - this.timestamp);
      }
      
      public function set timeLeft(param1:int) : void
      {
         this._timeLeft = param1;
         this.timestamp = DCGame.getTime() * 0.001;
      }
      
      public function set boughtPackId(param1:String) : void
      {
         this._boughtPackId = param1;
      }
      
      public function get boughtPackId() : String
      {
         return this._boughtPackId;
      }
      
      public function didWeLoseVip() : Boolean
      {
         if(this._wasVip)
         {
            if(!this.vip)
            {
               this._wasVip = false;
               return true;
            }
         }
         return false;
      }
   }
}

