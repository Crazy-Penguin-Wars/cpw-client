package tuxwars.battle.data.stats
{
   import com.dchoc.events.*;
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.gameobjects.stats.modifier.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   
   public class StatReference
   {
      private static const VALUE:String = "Value";
      
      private static const TYPE:String = "Type";
      
      private static const MODIFIER:String = "Modifier";
      
      private var array:Array;
      
      private var name:String;
      
      private var group:String;
      
      public function StatReference(param1:String, param2:Array, param3:String)
      {
         var _loc4_:Error = null;
         super();
         assert("Array is null.",true,param2 != null);
         this.name = param1;
         this.array = param2;
         this.group = param3;
         if(StatTypes.SORT_ORDER.indexOf(param3) == -1)
         {
            _loc4_ = new Error();
            MessageCenter.sendEvent(new ErrorMessage("Type Error",param1,"Type is not one of the following: " + StatTypes.SORT_ORDER.toString() + " correct in configs",param1,_loc4_));
         }
      }
      
      public function getStat() : Stat
      {
         var _loc9_:* = undefined;
         var _loc1_:Array = null;
         var _loc2_:String = null;
         var _loc3_:Error = null;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Error = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Stat = new Stat(this.name,0,"","",false);
         for each(_loc9_ in this.array)
         {
            _loc1_ = _loc9_.split(":");
            _loc2_ = _loc1_[0] as String;
            if(_loc2_ != "Add" && _loc2_ != "Multiply")
            {
               _loc3_ = new Error();
               MessageCenter.sendEvent(new ErrorMessage("Stat Bonus Formatting Error","getStat1","Modifier for: " + this.name + " is not " + "Add" + " or " + "Multiply" + ", data taken from string: " + _loc9_ + " correct in configs",this.name,_loc3_));
            }
            _loc4_ = new Number(_loc1_[1]);
            if(isNaN(_loc4_))
            {
               _loc5_ = new Error();
               MessageCenter.sendEvent(new ErrorMessage("Stat Bonus Formatting Error","getStat2","Value for: " + this.name + " is NaN, data taken from string: " + _loc9_ + " correct in configs",this.name,_loc5_));
            }
            _loc6_ = "Normal";
            if(_loc1_.length >= 3 && _loc1_[2] != null && _loc1_[2] != "")
            {
               _loc6_ = _loc1_[2] as String;
            }
            _loc7_ = "All";
            if(_loc1_.length >= 4 && _loc1_[3] != null && _loc1_[3] != "")
            {
               _loc7_ = _loc1_[3] as String;
            }
            if(_loc2_ == "Add")
            {
               _loc8_.addModifier(new StatAdd(this.name + _loc9_,_loc4_,this.group,_loc6_,_loc7_));
            }
            else if(_loc2_ == "Multiply")
            {
               _loc8_.addModifier(new StatMultiply(this.name + _loc9_,_loc4_,this.group,_loc6_,_loc7_));
            }
            else
            {
               LogUtils.log("Stat modifier: " + _loc2_ + " not found for: " + this.name + " for modifier: " + _loc9_,this,3,"Stats",false,true);
            }
         }
         return _loc8_;
      }
   }
}

