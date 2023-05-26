package com.dchoc.gameobjects.stats
{
   import com.dchoc.gameobjects.stats.modifier.StatAdd;
   import com.dchoc.gameobjects.stats.modifier.StatModifier;
   import com.dchoc.utils.LogUtils;
   import flash.utils.Dictionary;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.data.Tuner;
   
   public class Stat
   {
      
      public static const STAT_MINIMUMS:Dictionary = new Dictionary();
      
      private static var initialized:Boolean = false;
       
      
      protected var name:String;
      
      protected var _modifiers:Array;
      
      public function Stat(statName:String, value:Number = 0, group:String = "Group_Base", type:String = "Normal", includeBase:Boolean = true)
      {
         super();
         name = statName;
         _modifiers = [];
         if(includeBase)
         {
            _modifiers.push(new StatAdd(statName + group + type,value,group,type));
         }
      }
      
      public static function init() : void
      {
         if(!initialized)
         {
            var _loc1_:Tuner = Tuner;
            STAT_MINIMUMS["Attack"] = tuxwars.data.Tuner.getField("AttackStatMin").value;
            var _loc2_:Tuner = Tuner;
            STAT_MINIMUMS["Attackers_Stat"] = tuxwars.data.Tuner.getField("AttackStatMin").value;
            var _loc3_:Tuner = Tuner;
            STAT_MINIMUMS["Defence"] = tuxwars.data.Tuner.getField("DefenceStatMin").value;
            var _loc4_:Tuner = Tuner;
            STAT_MINIMUMS["Luck"] = tuxwars.data.Tuner.getField("LuckStatMin").value;
            initialized = true;
         }
      }
      
      protected static function sortByType(stat:Stat) : void
      {
         stat._modifiers.sort(sortByTypeComparision);
      }
      
      private static function sortByTypeComparision(modA:StatModifier, modB:StatModifier) : int
      {
         var aPriority:int = 0;
         var bPriority:int = 0;
         var aIndex:int = StatTypes.SORT_ORDER.indexOf(modA.getGroup());
         var bIndex:int = StatTypes.SORT_ORDER.indexOf(modB.getGroup());
         if(aIndex < 0 || bIndex < 0)
         {
            LogUtils.log("Unspecified type for sort (aType: " + modA.getGroup() + " bType: " + modB.getGroup() + ")","Stat",3,"Stats",false,false,false);
            return 0;
         }
         if(aIndex == bIndex)
         {
            aPriority = modA.getPriority();
            bPriority = modB.getPriority();
            if(aPriority == bPriority)
            {
               return 0;
            }
            if(aPriority < bPriority)
            {
               return -1;
            }
            return 1;
         }
         if(aIndex < bIndex)
         {
            return -1;
         }
         return 1;
      }
      
      public function dispose() : void
      {
         if(_modifiers)
         {
            for each(var modifier in _modifiers)
            {
               if(modifier)
               {
                  modifier.dispose();
               }
            }
            _modifiers.splice(0,_modifiers.length);
            _modifiers = null;
         }
      }
      
      public function clone() : Stat
      {
         var _loc2_:Stat = new Stat(name,0,"Group_Base","Normal",false);
         for each(var modifier in _modifiers)
         {
            _loc2_.addModifier(modifier.clone());
         }
         return _loc2_;
      }
      
      public function getBaseModifierName() : String
      {
         return name + "Group_Base" + "Normal";
      }
      
      public function getBaseModifier() : StatModifier
      {
         return getModifier(getBaseModifierName());
      }
      
      public function getModifiers() : Array
      {
         return _modifiers;
      }
      
      public function getLastModifier(type:Class) : StatModifier
      {
         var i:int = 0;
         for(i = _modifiers.length - 1; i >= 0; )
         {
            if(_modifiers[i] is type)
            {
               return _modifiers[i];
            }
            i--;
         }
         return null;
      }
      
      public function getModifier(id:String) : StatModifier
      {
         for each(var modifier in _modifiers)
         {
            if(id == modifier.getId())
            {
               return modifier;
            }
         }
         return null;
      }
      
      public function addModifier(statModifier:StatModifier) : void
      {
         if(_modifiers)
         {
            _modifiers.push(statModifier);
            sortByType(this);
         }
      }
      
      public function calculateRoundedValue(affected:PhysicsGameObject = null, affecting:PhysicsGameObject = null, type:String = "Calculate_All", includeTemp:Boolean = true, debugCalculation:Boolean = false) : int
      {
         return calculateValue(affected,affecting,type,includeTemp,debugCalculation);
      }
      
      private function applyMinValues(calculatedValue:Number) : Number
      {
         if(STAT_MINIMUMS[name] != null)
         {
            return Math.max(calculatedValue,STAT_MINIMUMS[name]);
         }
         return calculatedValue;
      }
      
      public function calculateValue(affected:PhysicsGameObject = null, affecting:PhysicsGameObject = null, type:String = "Calculate_All", includeTemp:Boolean = true, debugCalculation:Boolean = false) : Number
      {
         if(debugCalculation)
         {
            LogUtils.log("Calculating value for: " + name + ", includeTemp: " + includeTemp + ", type: " + type,"Stat",0,"Stats",false,false,debugCalculation);
         }
         var returnValue:Number = 0;
         for each(var modifier in _modifiers)
         {
            if(type == "Calculate_All" || type == modifier.getType() || modifier.getType() == "Normal")
            {
               if(includeTemp || modifier.getGroup() != "Group_Temp")
               {
                  if(modifier.affects == "All" || affected != null && affected.affectsGameObject(modifier.affects,affecting))
                  {
                     if(debugCalculation)
                     {
                        LogUtils.log("Input value: " + returnValue + " modified by: " + modifier.toString(),"Stat",0,"Stats",false,false,debugCalculation);
                     }
                     returnValue = modifier.modify(returnValue);
                  }
               }
            }
         }
         if(debugCalculation)
         {
            LogUtils.log("Final calculated value: " + returnValue,"Stat",0,"Stats",false,false,debugCalculation);
         }
         return applyMinValues(returnValue);
      }
      
      public function getFormattedCalculatedValue(type:String = "Calculate_All", includeTemp:Boolean = true, debugCalculation:Boolean = false) : String
      {
         var intNumber:int = 0;
         var value:Number = calculateValue(null,null,type,includeTemp,debugCalculation);
         if(value == 0)
         {
            return "";
         }
         if(isPercentage())
         {
            value = Math.round((value - 1) * 1000) / 10;
            return getSign(value) + value + "%";
         }
         intNumber = value;
         return getSign(value) + intNumber;
      }
      
      private function getSign(value:Number) : String
      {
         return value > 0 ? "+" : "";
      }
      
      public function isPercentage(type:String = "Calculate_All", includeTemp:Boolean = true) : Boolean
      {
         if(_modifiers.length <= 0)
         {
            return false;
         }
         for each(var modifier in _modifiers)
         {
            if(type == "Calculate_All" || type == modifier.getType() || modifier.getType() == "Normal")
            {
               if(includeTemp || modifier.getGroup() != "Group_Temp")
               {
                  if(modifier is StatAdd)
                  {
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      public function removeModifier(statModifier:StatModifier) : void
      {
         var index:int = 0;
         if(_modifiers)
         {
            index = _modifiers.indexOf(statModifier);
            if(index != -1)
            {
               _modifiers.splice(index,1);
            }
         }
      }
      
      public function clearTemp() : void
      {
         var index:int = 0;
         sortByType(this);
         for each(var modifier in _modifiers)
         {
            if(modifier.getGroup() == "Group_Temp")
            {
               index = _modifiers.indexOf(modifier);
               _modifiers.splice(index);
               return;
            }
         }
      }
      
      public function combine(stat:Stat, ignoreName:Boolean = false) : Stat
      {
         if(!ignoreName && this.name != stat.name)
         {
            LogUtils.log("The two stats are not same, cannot combine.","Stat",2,"Stats",false,false,false);
            return null;
         }
         var _loc3_:Stat = new Stat(this.name,0,"Group_Base","Normal",false);
         _loc3_._modifiers = _loc3_._modifiers.concat(this._modifiers);
         _loc3_._modifiers = _loc3_._modifiers.concat(stat._modifiers);
         sortByType(_loc3_);
         return _loc3_;
      }
      
      public function toString() : String
      {
         var s:* = null;
         if(_modifiers && _modifiers.length > 0)
         {
            s = "\n<Name: " + name + " Modifiers listed below>";
            for each(var modifier in _modifiers)
            {
               s += "\n" + modifier.toString();
            }
            return s;
         }
         return "";
      }
   }
}
