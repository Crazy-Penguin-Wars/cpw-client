package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import tuxwars.items.data.*;
   
   public class WeaponDef extends ItemDef
   {
      private var _animationType:String;
      
      private var _targeting:String;
      
      private var _emissions:Array;
      
      private var _allowRotation:Boolean;
      
      public function WeaponDef()
      {
         super();
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         var _loc2_:WeaponData = param1 as WeaponData;
         this._animationType = _loc2_.animationType;
         this._targeting = _loc2_.targeting;
         this._emissions = _loc2_.emissions;
         this._allowRotation = _loc2_.allowRotation;
      }
      
      public function get animationType() : String
      {
         return this._animationType;
      }
      
      public function get targeting() : String
      {
         return this._targeting;
      }
      
      public function get emissions() : Array
      {
         return this._emissions;
      }
      
      public function get allowRotation() : Boolean
      {
         return this._allowRotation;
      }
   }
}

