package tuxwars.battle.gameobjects
{
   import avmplus.*;
   import com.dchoc.game.*;
   import com.dchoc.gameobjects.stats.modifier.StatAdd;
   import flash.utils.*;
   import nape.geom.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class Damage extends StatAdd
   {
      private var _damageSourceClasses:Vector.<Class>;
      
      private var _idsOfDamageWithDamage:Vector.<String>;
      
      private var _uniquesIdsOfDamage:Vector.<String>;
      
      private var _taggingPlayer:PlayerGameObject;
      
      private var _locations:Vector.<Vec2>;
      
      private var _creationTime:int;
      
      public function Damage(param1:*, param2:String, param3:String, param4:int, param5:Vec2, param6:PlayerGameObject = null)
      {
         super("",0,"Group_Temp","Normal");
         this._creationTime = DCGame.getTime();
         this.init();
         this._taggingPlayer = param6;
         this.addDamage(param1,param2,param3,param4,param5);
      }
      
      public function addDamage(param1:*, param2:String, param3:String, param4:int, param5:Vec2) : void
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc6_:Class = getDefinitionByName(flash.utils.getQualifiedClassName(param1)) as Class;
         if(_loc6_ != null && this._damageSourceClasses.indexOf(_loc6_) == -1)
         {
            this._damageSourceClasses.push(_loc6_);
         }
         if(this._idsOfDamageWithDamage.length > 0 && this._idsOfDamageWithDamage[this._idsOfDamageWithDamage.length - 1].indexOf(param2) != -1)
         {
            _loc7_ = this._idsOfDamageWithDamage.length - 1;
            _loc8_ = this._idsOfDamageWithDamage[_loc7_] + ("(" + param4 + ")");
            this._idsOfDamageWithDamage[_loc7_] = _loc8_;
         }
         else if(param2.indexOf("(" + param4 + ")") == -1)
         {
            this._idsOfDamageWithDamage.push(param2 + "(" + param4 + ")");
         }
         else
         {
            this._idsOfDamageWithDamage.push(param2);
         }
         this._uniquesIdsOfDamage.push(param3);
         setId(this._idsOfDamageWithDamage.toString());
         this.addToValue(-param4);
         this._locations.push(!!param5 ? param5.copy() : null);
      }
      
      private function addToValue(param1:int) : void
      {
         value += param1;
      }
      
      public function init() : void
      {
         this._damageSourceClasses = new Vector.<Class>();
         this._idsOfDamageWithDamage = new Vector.<String>();
         this._uniquesIdsOfDamage = new Vector.<String>();
         setId("");
         value = 0;
         this._taggingPlayer = null;
         this._locations = new Vector.<Vec2>();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._damageSourceClasses.slice(0,this._damageSourceClasses.length);
         this._damageSourceClasses = null;
         this._idsOfDamageWithDamage.slice(0,this._idsOfDamageWithDamage.length);
         this._idsOfDamageWithDamage = null;
         this._uniquesIdsOfDamage.slice(0,this._uniquesIdsOfDamage.length);
         this._uniquesIdsOfDamage = null;
         setId("");
         value = 0;
         this._taggingPlayer = null;
         this._locations.slice(0,this._locations.length);
         this._locations = null;
      }
      
      public function hasTakenDamage(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.idsOfDamageWithDamage)
         {
            if(_loc2_.indexOf(param1) != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get damageSourceClasses() : Vector.<Class>
      {
         return this._damageSourceClasses;
      }
      
      public function get idsOfDamageWithDamage() : Vector.<String>
      {
         return this._idsOfDamageWithDamage;
      }
      
      public function get uniquesIdsOfDamage() : Vector.<String>
      {
         return this._uniquesIdsOfDamage;
      }
      
      public function get amount() : int
      {
         return -value;
      }
      
      public function get taggingPlayer() : PlayerGameObject
      {
         return this._taggingPlayer;
      }
      
      public function get locations() : Vector.<Vec2>
      {
         return this._locations;
      }
      
      public function get creationTime() : int
      {
         return this._creationTime;
      }
   }
}

