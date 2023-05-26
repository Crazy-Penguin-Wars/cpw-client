package tuxwars.battle.data.stats
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.StatTypes;
   import com.dchoc.gameobjects.stats.modifier.StatAdd;
   import com.dchoc.gameobjects.stats.modifier.StatMultiply;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   
   public class StatReference
   {
      
      private static const VALUE:String = "Value";
      
      private static const TYPE:String = "Type";
      
      private static const MODIFIER:String = "Modifier";
       
      
      private var array:Array;
      
      private var name:String;
      
      private var group:String;
      
      public function StatReference(name:String, array:Array, group:String)
      {
         var modifierError:* = null;
         super();
         assert("Array is null.",true,array != null);
         this.name = name;
         this.array = array;
         this.group = group;
         if(StatTypes.SORT_ORDER.indexOf(group) == -1)
         {
            modifierError = new Error();
            MessageCenter.sendEvent(new ErrorMessage("Type Error",name,"Type is not one of the following: " + StatTypes.SORT_ORDER.toString() + " correct in configs",name,modifierError));
         }
      }
      
      public function getStat() : Stat
      {
         var _loc4_:* = null;
         var _loc1_:* = null;
         var modifierError:* = null;
         var _loc6_:Number = NaN;
         var valueError:* = null;
         var type:* = null;
         var affects:* = null;
         var stat:Stat = new Stat(name,0,"","",false);
         for each(var statString in array)
         {
            _loc4_ = statString.split(":");
            _loc1_ = _loc4_[0] as String;
            if(_loc1_ != "Add" && _loc1_ != "Multiply")
            {
               modifierError = new Error();
               MessageCenter.sendEvent(new ErrorMessage("Stat Bonus Formatting Error","getStat1","Modifier for: " + name + " is not " + "Add" + " or " + "Multiply" + ", data taken from string: " + statString + " correct in configs",name,modifierError));
            }
            _loc6_ = new Number(_loc4_[1]);
            if(isNaN(_loc6_))
            {
               valueError = new Error();
               MessageCenter.sendEvent(new ErrorMessage("Stat Bonus Formatting Error","getStat2","Value for: " + name + " is NaN, data taken from string: " + statString + " correct in configs",name,valueError));
            }
            type = "Normal";
            if(_loc4_.length >= 3 && _loc4_[2] != null && _loc4_[2] != "")
            {
               type = _loc4_[2] as String;
            }
            affects = "All";
            if(_loc4_.length >= 4 && _loc4_[3] != null && _loc4_[3] != "")
            {
               affects = _loc4_[3] as String;
            }
            if(_loc1_ == "Add")
            {
               stat.addModifier(new StatAdd(name + statString,_loc6_,group,type,affects));
            }
            else if(_loc1_ == "Multiply")
            {
               stat.addModifier(new StatMultiply(name + statString,_loc6_,group,type,affects));
            }
            else
            {
               LogUtils.log("Stat modifier: " + _loc1_ + " not found for: " + name + " for modifier: " + statString,this,3,"Stats",false,true);
            }
         }
         return stat;
      }
   }
}
