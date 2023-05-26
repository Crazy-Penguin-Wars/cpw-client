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
         var _loc5_:* = null;
         var _loc6_:* = null;
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
            _loc7_["sx"] = scriptObject.location.x;
            _loc7_["sy"] = scriptObject.location.y;
         }
         if(params.pgoA)
         {
            _loc5_ = params.pgoA.bodyLocation;
            if(_loc5_)
            {
               _loc7_["ax"] = _loc5_.x;
               _loc7_["ay"] = _loc5_.y;
            }
         }
         if(params.pgoB)
         {
            _loc6_ = params.pgoB.bodyLocation;
            if(_loc6_)
            {
               _loc7_["bx"] = _loc6_.x;
               _loc7_["by"] = _loc6_.y;
            }
         }
         if(params.emission && params.emission.location)
         {
            _loc7_["ex"] = params.emission.location.x;
            _loc7_["ey"] = params.emission.location.y;
         }
         super(_loc7_);
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
