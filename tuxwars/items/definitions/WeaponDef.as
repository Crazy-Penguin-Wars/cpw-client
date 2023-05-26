package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import tuxwars.items.data.WeaponData;
   
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
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         var _loc2_:WeaponData = data as WeaponData;
         _animationType = _loc2_.animationType;
         _targeting = _loc2_.targeting;
         _emissions = _loc2_.emissions;
         _allowRotation = _loc2_.allowRotation;
      }
      
      public function get animationType() : String
      {
         return _animationType;
      }
      
      public function get targeting() : String
      {
         return _targeting;
      }
      
      public function get emissions() : Array
      {
         return _emissions;
      }
      
      public function get allowRotation() : Boolean
      {
         return _allowRotation;
      }
   }
}
