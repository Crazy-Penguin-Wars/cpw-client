package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.items.references.EmissionReference;
   
   public class FireEmissionMessage extends Message
   {
       
      
      private var _emissionReference:EmissionReference;
      
      private var _emissionObject:Emission;
      
      private var _playerId:String;
      
      private var _currentCount:int;
      
      private var _maxCount:int;
      
      public function FireEmissionMessage(emissionReference:EmissionReference, emissionObject:Emission, playerId:String, runningCount:int, maxCount:int)
      {
         super(emissionReference.specialType);
         _emissionReference = emissionReference;
         _emissionObject = emissionObject;
         _playerId = playerId;
         _currentCount = runningCount;
         _maxCount = maxCount;
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
      
      public function get emissionReference() : EmissionReference
      {
         return _emissionReference;
      }
      
      public function get emissionObject() : Emission
      {
         return _emissionObject;
      }
      
      public function get name() : String
      {
         var returnString:String = "";
         if(_emissionReference)
         {
            returnString += "EmissionReferenceID: " + _emissionReference.id + " Count current: " + currentCount + " max: " + maxCount;
         }
         if(_emissionObject)
         {
            returnString += "Emission: " + _emissionObject.shortName + " Count current: " + currentCount + " max: " + maxCount;
         }
         return returnString;
      }
      
      public function get currentCount() : int
      {
         return _currentCount;
      }
      
      public function get maxCount() : int
      {
         return _maxCount;
      }
   }
}
