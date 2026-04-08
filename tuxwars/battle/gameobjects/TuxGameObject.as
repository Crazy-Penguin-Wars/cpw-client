package tuxwars.battle.gameobjects
{
   import com.dchoc.game.DCGame;
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.utils.*;
   import nape.phys.Body;
   import tuxwars.*;
   
   public class TuxGameObject extends GameObject implements StatsInterface
   {
      public static const AFFECTS_ALL:String = "all";
      
      public static const AFFECTS_PENGUIN:String = "penguin";
      
      public static const AFFECTS_PLAYER:String = "player";
      
      public static const AFFECTS_ENEMY:String = "enemy";
      
      public static const AFFECTS_OBJECT:String = "object";
      
      public static const AFFECTS_TERRAIN:String = "terrain";
      
      public static const AFFECTS_STONE:String = "stone";
      
      public static const AFFECTS_ICE:String = "ice";
      
      public static const AFFECTS_METAL:String = "metal";
      
      public static const AFFECTS_WOOD:String = "wood";
      
      public static const AFFECTS_POWERUP:String = "powerup";
      
      public static const AFFECTS_LEVEL_OBJECT:String = "levelobject";
      
      public static const AFFECTS_WEAPON:String = "weapon";
      
      public static const AFFECTS_MISSILE:String = "missile";
      
      public static const AFFECTS_MINE:String = "mine";
      
      public static const AFFECTS_ENVIROMENT:String = "enviroment";
      
      public static const AFFECTS_GRENADE:String = "grenade";
      
      public static const AFFECTS_TIMER_MISSILE:String = "timermissile";
      
      public static const AFFECTS_WATER:String = "water";
      
      public static const AFFECTS_FOLLOWER:String = "follower";
      
      public static const AFFECTS_NONE:String = "none";
      
      public static const WEAPON_LIST:Array = ["weapon","missile","mine","enviroment","grenade","timermissile"];
      
      public static const AFFECTS_LIST:Array = ["all","penguin","player","enemy","object","terrain","stone","ice","metal","wood","powerup","levelobject","weapon","missile","mine","grenade","timermissile","enviroment","water","follower"];
      
      private var _stats:Stats;
      
      private var _canTakeDamage:Boolean;
      
      public var _hasHPs:Boolean;
      
      private var cahcedHP:int = -2147483648;
      
      private var cachedMaxHP:int = -2147483648;
      
      private var cachedHPType:String = null;
      
      private var cahcedHPIncludeTemp:Boolean = true;
      
      public function TuxGameObject(param1:TuxGameObjectDef, param2:DCGame)
      {
         super(param1,param2);
         this._stats = this.createStats();
         if(param1.hitPoints > 0)
         {
            this.stats.create("HP",null,param1.hitPoints);
         }
         this.setCanTakeDamage(true);
         this.stats.create("Defence",null,0,false);
         this.stats.create("Attack",null,0,false);
         this.stats.create("Luck",null,0,false);
         var _loc3_:String = "HP";
         this._hasHPs = (!!this.stats ? this.stats.getStat(_loc3_) : null) != null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._stats.dispose();
         this._stats = null;
      }
      
      final public function get tuxGame() : TuxWarsGame
      {
         return this._game as TuxWarsGame;
      }
      
      public function setCanTakeDamage(param1:Boolean) : void
      {
         this._canTakeDamage = param1;
      }
      
      public function canTakeDamage() : Boolean
      {
         return this._canTakeDamage;
      }
      
      final public function calculateHitPoints(param1:String = "Calculate_All", param2:Boolean = true, param3:Boolean = false) : int
      {
         var _loc4_:String = null;
         if(this.cahcedHP == -2147483648 || this.cachedHPType != param1 || param2 != this.cahcedHPIncludeTemp)
         {
            this.cachedHPType = param1;
            this.cahcedHPIncludeTemp = param2;
            _loc4_ = "HP";
            this.cahcedHP = (!!this.stats ? this.stats.getStat(_loc4_) : null).calculateValue(null,null,param1,param2,param3);
         }
         return this.cahcedHP;
      }
      
      final public function getCachedHP() : int
      {
         return this.cahcedHP;
      }
      
      public function resetCahcedHP() : void
      {
         this.cahcedHP = -2147483648;
         this.cachedHPType = null;
         this.cahcedHPIncludeTemp = true;
      }
      
      public function reduceHitPoints(param1:Damage) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         if(param1 == null)
         {
            LogUtils.log("DamageSource is null",this,2,"DamageApply",false,false,false);
         }
         else if(param1.amount != 0 && this._hasHPs)
         {
            _loc3_ = "HP";
            (!!this.stats ? this.stats.getStat(_loc3_) : null).addModifier(param1);
            this.resetCahcedHP();
            _loc2_ = this.calculateHitPoints();
            LogUtils.log("ReduceHitpoints: " + shortName + " takes " + param1.amount + " amount of " + param1.idsOfDamageWithDamage.toString() + " uids: " + param1.uniquesIdsOfDamage.toString() + " hitPoints remaining: " + _loc2_ + ", tagging player: " + param1.taggingPlayer,this,0,"DamageApply",false,false,false);
         }
      }
      
      public function calculateMaxHitPoints() : int
      {
         var _loc1_:String = null;
         if(this.cachedMaxHP == -2147483648)
         {
            _loc1_ = "HP";
            this.cachedMaxHP = (!!this.stats ? this.stats.getStat(_loc1_) : null).calculateValue(null,null,"Calculate_All",false);
         }
         return this.cachedMaxHP;
      }
      
      public function get defence() : Stat
      {
         var _loc1_:String = "Defence";
         return !!this.stats ? this.stats.getStat(_loc1_) : null;
      }
      
      public function get attack() : Stat
      {
         var _loc1_:String = "Attack";
         return !!this.stats ? this.stats.getStat(_loc1_) : null;
      }
      
      public function clearTempHpModifiers() : void
      {
         var _loc1_:String = null;
         if(this._hasHPs)
         {
            _loc1_ = "HP";
            (!!this.stats ? this.stats.getStat(_loc1_) : null).clearTemp();
         }
      }
      
      final public function findStat(param1:String) : Stat
      {
         return !!this.stats ? this.stats.getStat(param1) : null;
      }
      
      public function createStat(param1:String, param2:Body, param3:Number = 0) : Stat
      {
         return this.stats.create(param1,param2,param3,param3 != 0);
      }
      
      public function get stats() : Stats
      {
         return this._stats;
      }
      
      public function affectsGameObject(param1:String, param2:PhysicsGameObject) : Boolean
      {
         if(param1 == "all")
         {
            return true;
         }
         if(param1 != "none" && AFFECTS_LIST.indexOf(param1) == -1)
         {
            LogUtils.log("Override type: " + param1 + " in some extending class and add it to the list in TuxGameObject",this,2,"AffectsGameObject",true,false,true);
            return true;
         }
         return false;
      }
      
      protected function createStats() : Stats
      {
         return new Stats();
      }
   }
}

