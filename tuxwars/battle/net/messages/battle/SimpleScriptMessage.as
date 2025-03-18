package tuxwars.battle.net.messages.battle
{
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class SimpleScriptMessage extends BattleMessage
   {
      public function SimpleScriptMessage(playerId:String, emissionId:String, scriptObject:SimpleScript, params:SimpleScriptParams)
      {
         var _loc5_:Vec2 = null;
         var _loc6_:Vec2 = null;
         var _loc7_:Object = {
            "t":55,
            "sid":emissionId
         };
         if(playerId)
         {
            _loc7_["id"] = playerId;
         }
         if(scriptObject && scriptObject.location)
         {
            _loc7_["sx"] = int(scriptObject.location.x);
            _loc7_["sy"] = int(scriptObject.location.y);
         }
         if(params.pgoA)
         {
            _loc5_ = params.pgoA.bodyLocation;
            if(_loc5_)
            {
               _loc7_["ax"] = int(_loc5_.x);
               _loc7_["ay"] = int(_loc5_.y);
            }
         }
         if(params.pgoB)
         {
            _loc6_ = params.pgoB.bodyLocation;
            if(_loc6_)
            {
               _loc7_["bx"] = int(_loc6_.x);
               _loc7_["by"] = int(_loc6_.y);
            }
         }
         if(params.emission && params.emission.location)
         {
            _loc7_["ex"] = int(params.emission.location.x);
            _loc7_["ey"] = int(params.emission.location.y);
         }
         super(_loc7_);
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

