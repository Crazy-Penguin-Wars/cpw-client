package tuxwars.battle.net.messages.battle
{
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import tuxwars.battle.*;
   
   public class EmitMessage extends BattleMessage
   {
      public static const DIRECTION_MULTIPLIER:int = 10000;
      
      public function EmitMessage(param1:String, param2:String, param3:Vec2, param4:Vec2 = null, param5:int = -1, param6:int = 0, param7:Array = null, param8:Array = null, param9:Array = null)
      {
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Object = {
            "t":9,
            "eid":param2,
            "lx":int(param3.x),
            "ly":int(param3.y)
         };
         if(param1)
         {
            _loc12_["id"] = param1;
         }
         if(param4)
         {
            LogUtils.log("Emit message dir: " + param4,this,1,"Emission",false,false,false);
            _loc10_ = int(param4.x * 10000);
            _loc11_ = int(param4.y * 10000);
            if(_loc10_ != 0 || _loc11_ != 0)
            {
               _loc12_["dx"] = _loc10_;
               _loc12_["dy"] = _loc11_;
            }
         }
         if(param5 != -1 && param5 != 0)
         {
            _loc12_["p"] = param5;
         }
         if(param6 > 0)
         {
            _loc12_["a"] = param6;
         }
         if(Boolean(param7) && param7.length > 0)
         {
            _loc12_["il"] = param7;
         }
         if(Boolean(param8) && param8.length > 0)
         {
            _loc12_["dl"] = param8;
         }
         if(Boolean(param9) && param9.length > 0)
         {
            _loc12_["tl"] = param9;
         }
         super(_loc12_);
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

