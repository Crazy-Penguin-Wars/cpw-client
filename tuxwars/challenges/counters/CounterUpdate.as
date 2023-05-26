package tuxwars.challenges.counters
{
   public class CounterUpdate
   {
       
      
      private var _playerId:String;
      
      private var _counter:Counter;
      
      private var _value:int;
      
      public function CounterUpdate(playerId:String, counter:Counter, value:int)
      {
         super();
         _playerId = playerId;
         _counter = counter;
         _value = value;
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
      
      public function get counterId() : String
      {
         return _counter.id;
      }
      
      public function get counter() : Counter
      {
         return _counter;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function toString() : String
      {
         return "CounterUpdate for counter: " + counterId + ", player: " + _playerId + ", value: " + _value;
      }
   }
}
