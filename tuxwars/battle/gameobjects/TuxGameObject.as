package tuxwars.battle.gameobjects
{
   import com.dchoc.game.DCGame;
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.gameobjects.stats.StatsInterface;
   import com.dchoc.utils.LogUtils;
   import nape.phys.Body;
   import tuxwars.TuxWarsGame;
   
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
      
      public function TuxGameObject(def:TuxGameObjectDef, game:DCGame)
      {
         super(def,game);
         _stats = createStats();
         if(def.hitPoints > 0)
         {
            stats.create("HP",null,def.hitPoints);
         }
         setCanTakeDamage(true);
         stats.create("Defence",null,0,false);
         stats.create("Attack",null,0,false);
         stats.create("Luck",null,0,false);
         _hasHPs = (!!this.stats ? this.stats.getStat("HP") : null) != null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _stats.dispose();
         _stats = null;
      }
      
      final public function get tuxGame() : TuxWarsGame
      {
         return this._game as TuxWarsGame;
      }
      
      public function setCanTakeDamage(value:Boolean) : void
      {
         _canTakeDamage = value;
      }
      
      public function canTakeDamage() : Boolean
      {
         return _canTakeDamage;
      }
      
      final public function calculateHitPoints(type:String = "Calculate_All", includeTemp:Boolean = true, debugCalculation:Boolean = false) : int
      {
         if(cahcedHP == -2147483648 || cachedHPType != type || includeTemp != cahcedHPIncludeTemp)
         {
            cachedHPType = type;
            cahcedHPIncludeTemp = includeTemp;
            cahcedHP = (!!this.stats ? this.stats.getStat("HP") : null).calculateValue(null,null,type,includeTemp,debugCalculation);
         }
         return cahcedHP;
      }
      
      final public function getCachedHP() : int
      {
         return cahcedHP;
      }
      
      public function resetCahcedHP() : void
      {
         cahcedHP = -2147483648;
         cachedHPType = null;
         cahcedHPIncludeTemp = true;
      }
      
      public function reduceHitPoints(damageSource:Damage) : void
      {
         var _loc2_:int = 0;
         if(damageSource == null)
         {
            LogUtils.log("DamageSource is null",this,2,"DamageApply",false,false,false);
         }
         else if(damageSource.amount != 0 && _hasHPs)
         {
            (!!this.stats ? this.stats.getStat("HP") : null).addModifier(damageSource);
            resetCahcedHP();
            _loc2_ = calculateHitPoints();
            LogUtils.log("ReduceHitpoints: " + shortName + " takes " + damageSource.amount + " amount of " + damageSource.idsOfDamageWithDamage.toString() + " uids: " + damageSource.uniquesIdsOfDamage.toString() + " hitPoints remaining: " + _loc2_ + ", tagging player: " + damageSource.taggingPlayer,this,0,"DamageApply",false,false,false);
         }
      }
      
      public function calculateMaxHitPoints() : int
      {
         if(cachedMaxHP == -2147483648)
         {
            cachedMaxHP = (!!this.stats ? this.stats.getStat("HP") : null).calculateValue(null,null,"Calculate_All",false);
         }
         return cachedMaxHP;
      }
      
      public function get defence() : Stat
      {
         return !!this.stats ? this.stats.getStat("Defence") : null;
      }
      
      public function get attack() : Stat
      {
         return !!this.stats ? this.stats.getStat("Attack") : null;
      }
      
      public function clearTempHpModifiers() : void
      {
         if(_hasHPs)
         {
            (!!this.stats ? this.stats.getStat("HP") : null).clearTemp();
         }
      }
      
      final public function findStat(statName:String) : Stat
      {
         return !!stats ? stats.getStat(statName) : null;
      }
      
      public function createStat(name:String, body:Body, baseValue:Number = 0) : Stat
      {
         return stats.create(name,body,baseValue,baseValue != 0);
      }
      
      public function get stats() : Stats
      {
         return _stats;
      }
      
      public function affectsGameObject(type:String, taggerGameObject:PhysicsGameObject) : Boolean
      {
         if(type == "all")
         {
            return true;
         }
         if(type != "none" && AFFECTS_LIST.indexOf(type) == -1)
         {
            LogUtils.log("Override type: " + type + " in some extending class and add it to the list in TuxGameObject",this,2,"AffectsGameObject",true,false,true);
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
