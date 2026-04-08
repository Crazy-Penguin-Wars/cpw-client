package com.dchoc.gameobjects.stats
{
   import com.dchoc.gameobjects.stats.modifier.*;
   import com.dchoc.gameobjects.stats.physics.*;
   import com.dchoc.utils.*;
   import nape.phys.Body;
   import tuxwars.items.*;
   
   public class Stats
   {
      private static const PHYSICS_STATS:Array = ["Density","GravityScale","Restitution","Friction"];
      
      private static const PHYSICS_STAT_CLASSES:Object = {};
      
      PHYSICS_STAT_CLASSES["GravityScale"] = GravityScaleStat;
      PHYSICS_STAT_CLASSES["Density"] = DensityStat;
      PHYSICS_STAT_CLASSES["Restitution"] = RestitutionStat;
      PHYSICS_STAT_CLASSES["Friction"] = FrictionStat;
      
      private var _stats:Object;
      
      public function Stats()
      {
         super();
         this._stats = {};
      }
      
      public static function copyStats(param1:Stats, param2:Stats) : Stats
      {
         var _loc3_:* = undefined;
         if(param1 != null && param1._stats != null)
         {
            for each(_loc3_ in Equippable.BOOSTER_BONUS_STATS)
            {
               if(param1.hasStat(_loc3_))
               {
                  if(param2 == null || param2._stats == null)
                  {
                     param2 = new Stats();
                  }
                  param2.setStat(_loc3_,param1.getStat(_loc3_),true);
               }
            }
         }
         return param2;
      }
      
      public function getStat(param1:String) : Stat
      {
         return this._stats[param1];
      }
      
      public function setStat(param1:String, param2:Stat, param3:Boolean = false) : void
      {
         if(!param3)
         {
            this._stats[param1] = param2;
         }
         else
         {
            this._stats[param1] = param2.clone();
         }
      }
      
      public function hasStats(param1:Array) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc2_:* = false;
         for each(_loc3_ in param1)
         {
            _loc2_ = this.getStat(_loc3_) != null;
            if(_loc2_)
            {
               return _loc2_;
            }
         }
         return false;
      }
      
      public function hasStat(param1:String) : Boolean
      {
         return this.getStat(param1) != null;
      }
      
      public function addStat(param1:String, param2:Stat, param3:Body) : void
      {
         var _loc5_:* = undefined;
         var _loc4_:Stat = null;
         if(param2 != null)
         {
            _loc4_ = this.getStat(param1);
            if(!_loc4_)
            {
               this.create(param1,param3,0,false);
               _loc4_ = this.getStat(param1);
            }
            for each(_loc5_ in param2.getModifiers())
            {
               _loc4_.addModifier(_loc5_);
               if(_loc5_ && (_loc5_.value != 0 || _loc5_ is StatMultiply))
               {
                  LogUtils.log("Stat: " + param1 + ", StatsModifier added: " + _loc5_.toString(),this,0,"Stats",false,false,false);
               }
            }
         }
      }
      
      public function deleteStat(param1:String) : void
      {
         var _loc2_:Stat = this.getStat(param1);
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            delete this._stats[param1];
         }
      }
      
      public function removeStat(param1:String, param2:Stat) : void
      {
         var _loc3_:Stat = null;
         var _loc4_:int = 0;
         var _loc5_:StatModifier = null;
         if(param2 != null)
         {
            _loc3_ = this.getStat(param1);
            if(_loc3_ != null)
            {
               _loc4_ = int(param2.getModifiers().length - 1);
               while(_loc4_ >= 0)
               {
                  _loc5_ = param2.getModifiers()[_loc4_];
                  _loc3_.removeModifier(_loc5_);
                  LogUtils.log("Stat: " + param1 + ", StatsModifier removed: " + _loc5_.toString(),this,0,"Stats",false,false,false);
                  _loc4_--;
               }
            }
         }
      }
      
      public function create(param1:String, param2:Body, param3:Number = 0, param4:Boolean = true) : Stat
      {
         if(this._stats[param1] != null)
         {
            LogUtils.log("Stat named: " + param1 + " already exists",this,2,"Stats",false,false,false);
            return null;
         }
         if(PHYSICS_STATS.indexOf(param1) != -1)
         {
            this._stats[param1] = new PHYSICS_STAT_CLASSES[param1](param1,param2,param3,"Group_Base","Normal",param4);
         }
         else
         {
            this._stats[param1] = new Stat(param1,param3,"Group_Base","Normal",param4);
         }
         return this._stats[param1];
      }
      
      public function toString() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:String = "";
         for each(_loc2_ in this._stats)
         {
            _loc1_ += _loc2_.toString();
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         if(this._stats != null)
         {
            for each(_loc1_ in this._stats)
            {
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc1_ = null;
            }
            this._stats = null;
         }
      }
   }
}

