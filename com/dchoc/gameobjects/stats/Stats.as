package com.dchoc.gameobjects.stats
{
   import com.dchoc.gameobjects.stats.modifier.StatModifier;
   import com.dchoc.gameobjects.stats.modifier.StatMultiply;
   import com.dchoc.gameobjects.stats.physics.DensityStat;
   import com.dchoc.gameobjects.stats.physics.FrictionStat;
   import com.dchoc.gameobjects.stats.physics.GravityScaleStat;
   import com.dchoc.gameobjects.stats.physics.RestitutionStat;
   import com.dchoc.utils.LogUtils;
   import nape.phys.Body;
   import tuxwars.items.Equippable;
   
   public class Stats
   {
      
      private static const PHYSICS_STATS:Array = ["Density","GravityScale","Restitution","Friction"];
      
      private static const PHYSICS_STAT_CLASSES:Object = {};
      
      {
         PHYSICS_STAT_CLASSES["GravityScale"] = GravityScaleStat;
         PHYSICS_STAT_CLASSES["Density"] = DensityStat;
         PHYSICS_STAT_CLASSES["Restitution"] = RestitutionStat;
         PHYSICS_STAT_CLASSES["Friction"] = FrictionStat;
      }
      
      private var _stats:Object;
      
      public function Stats()
      {
         super();
         _stats = {};
      }
      
      public static function copyStats(from:Stats, to:Stats) : Stats
      {
         if(from != null && from._stats != null)
         {
            for each(var statName in Equippable.BOOSTER_BONUS_STATS)
            {
               if(from.hasStat(statName))
               {
                  if(to == null || to._stats == null)
                  {
                     to = new Stats();
                  }
                  to.setStat(statName,from.getStat(statName),true);
               }
            }
         }
         return to;
      }
      
      public function getStat(statName:String) : Stat
      {
         return _stats[statName];
      }
      
      public function setStat(statName:String, stat:Stat, clone:Boolean = false) : void
      {
         if(!clone)
         {
            _stats[statName] = stat;
         }
         else
         {
            _stats[statName] = stat.clone();
         }
      }
      
      public function hasStats(names:Array) : Boolean
      {
         var hasStat:Boolean = false;
         for each(var name in names)
         {
            hasStat = getStat(name) != null;
            if(hasStat)
            {
               return hasStat;
            }
         }
         return false;
      }
      
      public function hasStat(name:String) : Boolean
      {
         return getStat(name) != null;
      }
      
      public function addStat(statName:String, statToAdd:Stat, body:Body) : void
      {
         var stat:* = null;
         if(statToAdd != null)
         {
            stat = getStat(statName);
            if(!stat)
            {
               create(statName,body,0,false);
               stat = getStat(statName);
            }
            for each(var statModifier in statToAdd.getModifiers())
            {
               stat.addModifier(statModifier);
               if(statModifier && (statModifier.value != 0 || statModifier is StatMultiply))
               {
                  LogUtils.log("Stat: " + statName + ", StatsModifier added: " + statModifier.toString(),this,0,"Stats",false,false,false);
               }
            }
         }
      }
      
      public function deleteStat(statName:String) : void
      {
         var stat:Stat = getStat(statName);
         if(stat != null)
         {
            stat.dispose();
            delete _stats[statName];
         }
      }
      
      public function removeStat(statName:String, statToRemove:Stat) : void
      {
         var stat:* = null;
         var i:int = 0;
         var statModifier:* = null;
         if(statToRemove != null)
         {
            stat = getStat(statName);
            if(stat != null)
            {
               for(i = statToRemove.getModifiers().length - 1; i >= 0; )
               {
                  statModifier = statToRemove.getModifiers()[i];
                  stat.removeModifier(statModifier);
                  LogUtils.log("Stat: " + statName + ", StatsModifier removed: " + statModifier.toString(),this,0,"Stats",false,false,false);
                  i--;
               }
            }
         }
      }
      
      public function create(statName:String, body:Body, baseValue:Number = 0, includeBase:Boolean = true) : Stat
      {
         if(_stats[statName] != null)
         {
            LogUtils.log("Stat named: " + statName + " already exists",this,2,"Stats",false,false,false);
            return null;
         }
         if(PHYSICS_STATS.indexOf(statName) != -1)
         {
            _stats[statName] = new PHYSICS_STAT_CLASSES[statName](statName,body,baseValue,"Group_Base","Normal",includeBase);
         }
         else
         {
            _stats[statName] = new Stat(statName,baseValue,"Group_Base","Normal",includeBase);
         }
         return _stats[statName];
      }
      
      public function toString() : String
      {
         var s:String = "";
         for each(var stat in _stats)
         {
            s += stat.toString();
         }
         return s;
      }
      
      public function dispose() : void
      {
         if(_stats != null)
         {
            for each(var stat in _stats)
            {
               if(stat != null)
               {
                  stat.dispose();
               }
               stat = null;
            }
            _stats = null;
         }
      }
   }
}
