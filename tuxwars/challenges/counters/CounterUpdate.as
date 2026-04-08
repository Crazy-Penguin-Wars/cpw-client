package tuxwars.challenges.counters
{
   public class CounterUpdate
   {
      private var _playerId:String;
      
      private var _counter:Counter;
      
      private var _value:int;
      
      public function CounterUpdate(param1:String, param2:Counter, param3:int)
      {
         super();
         this._playerId = param1;
         this._counter = param2;
         this._value = param3;
      }
      
      public function get playerId() : String
      {
         return this._playerId;
      }
      
      public function get counterId() : String
      {
         return this._counter.id;
      }
      
      public function get counter() : Counter
      {
         return this._counter;
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      public function toString() : String
      {
         return "CounterUpdate for counter: " + this.counterId + ", player: " + this._playerId + ", value: " + this._value;
      }
   }
}

