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
      
      public function FireEmissionMessage(param1:EmissionReference, param2:Emission, param3:String, param4:int, param5:int)
      {
         super(param1.specialType);
         this._emissionReference = param1;
         this._emissionObject = param2;
         this._playerId = param3;
         this._currentCount = param4;
         this._maxCount = param5;
      }
      
      public function get playerId() : String
      {
         return this._playerId;
      }
      
      public function get emissionReference() : EmissionReference
      {
         return this._emissionReference;
      }
      
      public function get emissionObject() : Emission
      {
         return this._emissionObject;
      }
      
      public function get name() : String
      {
         var _loc1_:String = "";
         if(this._emissionReference)
         {
            _loc1_ += "EmissionReferenceID: " + this._emissionReference.id + " Count current: " + this.currentCount + " max: " + this.maxCount;
         }
         if(this._emissionObject)
         {
            _loc1_ += "Emission: " + this._emissionObject.shortName + " Count current: " + this.currentCount + " max: " + this.maxCount;
         }
         return _loc1_;
      }
      
      public function get currentCount() : int
      {
         return this._currentCount;
      }
      
      public function get maxCount() : int
      {
         return this._maxCount;
      }
   }
}

