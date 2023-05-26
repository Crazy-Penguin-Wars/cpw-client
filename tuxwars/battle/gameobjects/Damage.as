package tuxwars.battle.gameobjects
{
   import avmplus.getQualifiedClassName;
   import com.dchoc.game.DCGame;
   import com.dchoc.gameobjects.stats.modifier.StatAdd;
   import flash.utils.getDefinitionByName;
   import nape.geom.Vec2;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class Damage extends StatAdd
   {
       
      
      private var _damageSourceClasses:Vector.<Class>;
      
      private var _idsOfDamageWithDamage:Vector.<String>;
      
      private var _uniquesIdsOfDamage:Vector.<String>;
      
      private var _taggingPlayer:PlayerGameObject;
      
      private var _locations:Vector.<Vec2>;
      
      private var _creationTime:int;
      
      public function Damage(damageSourceClass:*, idOfDamage:String, uniqueIdOfDamage:String, amount:int, location:Vec2, taggingPlayer:PlayerGameObject = null)
      {
         super("",0,"Group_Temp","Normal");
         _creationTime = DCGame.getTime();
         init();
         _taggingPlayer = taggingPlayer;
         addDamage(damageSourceClass,idOfDamage,uniqueIdOfDamage,amount,location);
      }
      
      public function addDamage(damageSourceClass:*, idOfDamage:String, uniqueIdOfDamage:String, amount:int, location:Vec2) : void
      {
         var klass:Class = getDefinitionByName(getQualifiedClassName(damageSourceClass)) as Class;
         if(klass != null && _damageSourceClasses.indexOf(klass) == -1)
         {
            _damageSourceClasses.push(klass);
         }
         if(_idsOfDamageWithDamage.length > 0 && _idsOfDamageWithDamage[_idsOfDamageWithDamage.length - 1].indexOf(idOfDamage) != -1)
         {
            var _loc7_:* = _idsOfDamageWithDamage.length - 1;
            var _loc8_:* = _idsOfDamageWithDamage[_loc7_] + ("(" + amount + ")");
            _idsOfDamageWithDamage[_loc7_] = _loc8_;
         }
         else if(idOfDamage.indexOf("(" + amount + ")") == -1)
         {
            _idsOfDamageWithDamage.push(idOfDamage + "(" + amount + ")");
         }
         else
         {
            _idsOfDamageWithDamage.push(idOfDamage);
         }
         _uniquesIdsOfDamage.push(uniqueIdOfDamage);
         setId(_idsOfDamageWithDamage.toString());
         addToValue(-amount);
         _locations.push(!!location ? location.copy() : null);
      }
      
      private function addToValue(amount:int) : void
      {
         value += amount;
      }
      
      public function init() : void
      {
         _damageSourceClasses = new Vector.<Class>();
         _idsOfDamageWithDamage = new Vector.<String>();
         _uniquesIdsOfDamage = new Vector.<String>();
         setId("");
         value = 0;
         _taggingPlayer = null;
         _locations = new Vector.<Vec2>();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _damageSourceClasses.slice(0,_damageSourceClasses.length);
         _damageSourceClasses = null;
         _idsOfDamageWithDamage.slice(0,_idsOfDamageWithDamage.length);
         _idsOfDamageWithDamage = null;
         _uniquesIdsOfDamage.slice(0,_uniquesIdsOfDamage.length);
         _uniquesIdsOfDamage = null;
         setId("");
         value = 0;
         _taggingPlayer = null;
         _locations.slice(0,_locations.length);
         _locations = null;
      }
      
      public function hasTakenDamage(type:String) : Boolean
      {
         for each(var str in idsOfDamageWithDamage)
         {
            if(str.indexOf(type) != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get damageSourceClasses() : Vector.<Class>
      {
         return _damageSourceClasses;
      }
      
      public function get idsOfDamageWithDamage() : Vector.<String>
      {
         return _idsOfDamageWithDamage;
      }
      
      public function get uniquesIdsOfDamage() : Vector.<String>
      {
         return _uniquesIdsOfDamage;
      }
      
      public function get amount() : int
      {
         return -value;
      }
      
      public function get taggingPlayer() : PlayerGameObject
      {
         return _taggingPlayer;
      }
      
      public function get locations() : Vector.<Vec2>
      {
         return _locations;
      }
      
      public function get creationTime() : int
      {
         return _creationTime;
      }
   }
}
