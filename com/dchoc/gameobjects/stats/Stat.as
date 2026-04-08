package com.dchoc.gameobjects.stats
{
   import com.dchoc.gameobjects.stats.modifier.*;
   import com.dchoc.utils.*;
   import flash.utils.*;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.data.*;
   
   public class Stat
   {
      private static var initialized:Boolean = false;
      
      public static const STAT_MINIMUMS:Dictionary = new Dictionary();
      
      protected var name:String;
      
      protected var _modifiers:Array;
      
      public function Stat(param1:String, param2:Number = 0, param3:String = "Group_Base", param4:String = "Normal", param5:Boolean = true)
      {
         super();
         this.name = param1;
         this._modifiers = [];
         if(param5)
         {
            this._modifiers.push(new StatAdd(param1 + param3 + param4,param2,param3,param4));
         }
      }
      
      public static function init() : void
      {
         if(!initialized)
         {
            STAT_MINIMUMS["Attack"] = Tuner.getField("AttackStatMin").value;
            STAT_MINIMUMS["Attackers_Stat"] = Tuner.getField("AttackStatMin").value;
            STAT_MINIMUMS["Defence"] = Tuner.getField("DefenceStatMin").value;
            STAT_MINIMUMS["Luck"] = Tuner.getField("LuckStatMin").value;
            initialized = true;
         }
      }
      
      protected static function sortByType(param1:Stat) : void
      {
         param1._modifiers.sort(sortByTypeComparision);
      }
      
      private static function sortByTypeComparision(param1:StatModifier, param2:StatModifier) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = int(StatTypes.SORT_ORDER.indexOf(param1.getGroup()));
         var _loc6_:int = int(StatTypes.SORT_ORDER.indexOf(param2.getGroup()));
         if(_loc5_ < 0 || _loc6_ < 0)
         {
            LogUtils.log("Unspecified type for sort (aType: " + param1.getGroup() + " bType: " + param2.getGroup() + ")","Stat",3,"Stats",false,false,false);
            return 0;
         }
         if(_loc5_ == _loc6_)
         {
            _loc3_ = param1.getPriority();
            _loc4_ = param2.getPriority();
            if(_loc3_ == _loc4_)
            {
               return 0;
            }
            if(_loc3_ < _loc4_)
            {
               return -1;
            }
            return 1;
         }
         if(_loc5_ < _loc6_)
         {
            return -1;
         }
         return 1;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         if(this._modifiers)
         {
            for each(_loc1_ in this._modifiers)
            {
               if(_loc1_)
               {
                  _loc1_.dispose();
               }
            }
            this._modifiers.splice(0,this._modifiers.length);
            this._modifiers = null;
         }
      }
      
      public function clone() : Stat
      {
         var _loc2_:* = undefined;
         var _loc1_:Stat = new Stat(this.name,0,"Group_Base","Normal",false);
         for each(_loc2_ in this._modifiers)
         {
            _loc1_.addModifier(_loc2_.clone());
         }
         return _loc1_;
      }
      
      public function getBaseModifierName() : String
      {
         return this.name + "Group_Base" + "Normal";
      }
      
      public function getBaseModifier() : StatModifier
      {
         return this.getModifier(this.getBaseModifierName());
      }
      
      public function getModifiers() : Array
      {
         return this._modifiers;
      }
      
      public function getLastModifier(param1:Class) : StatModifier
      {
         var _loc2_:int = 0;
         _loc2_ = this._modifiers.length - 1;
         while(_loc2_ >= 0)
         {
            if(this._modifiers[_loc2_] is param1)
            {
               return this._modifiers[_loc2_];
            }
            _loc2_--;
         }
         return null;
      }
      
      public function getModifier(param1:String) : StatModifier
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._modifiers)
         {
            if(param1 == _loc2_.getId())
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function addModifier(param1:StatModifier) : void
      {
         if(this._modifiers)
         {
            this._modifiers.push(param1);
            sortByType(this);
         }
      }
      
      public function calculateRoundedValue(param1:PhysicsGameObject = null, param2:PhysicsGameObject = null, param3:String = "Calculate_All", param4:Boolean = true, param5:Boolean = false) : int
      {
         return int(this.calculateValue(param1,param2,param3,param4,param5));
      }
      
      private function applyMinValues(param1:Number) : Number
      {
         if(STAT_MINIMUMS[this.name] != null)
         {
            return Math.max(param1,STAT_MINIMUMS[this.name]);
         }
         return param1;
      }
      
      public function calculateValue(param1:PhysicsGameObject = null, param2:PhysicsGameObject = null, param3:String = "Calculate_All", param4:Boolean = true, param5:Boolean = false) : Number
      {
         var _loc7_:* = undefined;
         if(param5)
         {
            LogUtils.log("Calculating value for: " + this.name + ", includeTemp: " + param4 + ", type: " + param3,"Stat",0,"Stats",false,false,param5);
         }
         var _loc6_:Number = 0;
         for each(_loc7_ in this._modifiers)
         {
            if(param3 == "Calculate_All" || param3 == _loc7_.getType() || _loc7_.getType() == "Normal")
            {
               if(param4 || _loc7_.getGroup() != "Group_Temp")
               {
                  if(_loc7_.affects == "All" || param1 != null && param1.affectsGameObject(_loc7_.affects,param2))
                  {
                     if(param5)
                     {
                        LogUtils.log("Input value: " + _loc6_ + " modified by: " + _loc7_.toString(),"Stat",0,"Stats",false,false,param5);
                     }
                     _loc6_ = Number(_loc7_.modify(_loc6_));
                  }
               }
            }
         }
         if(param5)
         {
            LogUtils.log("Final calculated value: " + _loc6_,"Stat",0,"Stats",false,false,param5);
         }
         return this.applyMinValues(_loc6_);
      }
      
      public function getFormattedCalculatedValue(param1:String = "Calculate_All", param2:Boolean = true, param3:Boolean = false) : String
      {
         var _loc4_:int = 0;
         var _loc5_:Number = this.calculateValue(null,null,param1,param2,param3);
         if(_loc5_ == 0)
         {
            return "";
         }
         if(this.isPercentage())
         {
            _loc5_ = Math.round((_loc5_ - 1) * 1000) / 10;
            return this.getSign(_loc5_) + _loc5_ + "%";
         }
         _loc4_ = _loc5_;
         return this.getSign(_loc5_) + _loc4_;
      }
      
      private function getSign(param1:Number) : String
      {
         return param1 > 0 ? "+" : "";
      }
      
      public function isPercentage(param1:String = "Calculate_All", param2:Boolean = true) : Boolean
      {
         var _loc3_:* = undefined;
         if(this._modifiers.length <= 0)
         {
            return false;
         }
         for each(_loc3_ in this._modifiers)
         {
            if(param1 == "Calculate_All" || param1 == _loc3_.getType() || _loc3_.getType() == "Normal")
            {
               if(param2 || _loc3_.getGroup() != "Group_Temp")
               {
                  if(_loc3_ is StatAdd)
                  {
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      public function removeModifier(param1:StatModifier) : void
      {
         var _loc2_:int = 0;
         if(this._modifiers)
         {
            _loc2_ = int(this._modifiers.indexOf(param1));
            if(_loc2_ != -1)
            {
               this._modifiers.splice(_loc2_,1);
            }
         }
      }
      
      public function clearTemp() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         sortByType(this);
         for each(_loc2_ in this._modifiers)
         {
            if(_loc2_.getGroup() == "Group_Temp")
            {
               _loc1_ = int(this._modifiers.indexOf(_loc2_));
               this._modifiers.splice(_loc1_);
               return;
            }
         }
      }
      
      public function combine(param1:Stat, param2:Boolean = false) : Stat
      {
         if(!param2 && this.name != param1.name)
         {
            LogUtils.log("The two stats are not same, cannot combine.","Stat",2,"Stats",false,false,false);
            return null;
         }
         var _loc3_:Stat = new Stat(this.name,0,"Group_Base","Normal",false);
         _loc3_._modifiers = _loc3_._modifiers.concat(this._modifiers);
         _loc3_._modifiers = _loc3_._modifiers.concat(param1._modifiers);
         sortByType(_loc3_);
         return _loc3_;
      }
      
      public function toString() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:* = null;
         if(Boolean(this._modifiers) && this._modifiers.length > 0)
         {
            _loc1_ = "\n<Name: " + this.name + " Modifiers listed below>";
            for each(_loc2_ in this._modifiers)
            {
               _loc1_ += "\n" + _loc2_.toString();
            }
            return _loc1_;
         }
         return "";
      }
   }
}

