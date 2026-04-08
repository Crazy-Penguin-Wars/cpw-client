package tuxwars.battle.net.messages.battle
{
   import nape.geom.Vec2;
   import tuxwars.battle.*;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class SimpleScriptMessage extends BattleMessage
   {
      public function SimpleScriptMessage(param1:String, param2:String, param3:SimpleScript, param4:SimpleScriptParams)
      {
         var _loc5_:Vec2 = null;
         var _loc6_:Vec2 = null;
         var _loc7_:Object = {
            "t":55,
            "sid":param2
         };
         if(param1)
         {
            _loc7_["id"] = param1;
         }
         if(Boolean(param3) && Boolean(param3.location))
         {
            _loc7_["sx"] = int(param3.location.x);
            _loc7_["sy"] = int(param3.location.y);
         }
         if(param4.pgoA)
         {
            _loc5_ = param4.pgoA.bodyLocation;
            if(_loc5_)
            {
               _loc7_["ax"] = int(_loc5_.x);
               _loc7_["ay"] = int(_loc5_.y);
            }
         }
         if(param4.pgoB)
         {
            _loc6_ = param4.pgoB.bodyLocation;
            if(_loc6_)
            {
               _loc7_["bx"] = int(_loc6_.x);
               _loc7_["by"] = int(_loc6_.y);
            }
         }
         if(Boolean(param4.emission) && Boolean(param4.emission.location))
         {
            _loc7_["ex"] = int(param4.emission.location.x);
            _loc7_["ey"] = int(param4.emission.location.y);
         }
         super(_loc7_);
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

