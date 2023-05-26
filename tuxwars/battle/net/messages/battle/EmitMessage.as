package tuxwars.battle.net.messages.battle
{
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   
   public class EmitMessage extends BattleMessage
   {
      
      public static const DIRECTION_MULTIPLIER:int = 10000;
       
      
      public function EmitMessage(playerId:String, emissionId:String, loc:Vec2, dir:Vec2 = null, powerBar:int = -1, playerAttackValue:int = 0, impulseList:Array = null, damageList:Array = null, terrainList:Array = null)
      {
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Object = {
            "t":9,
            "eid":emissionId,
            "lx":loc.x,
            "ly":loc.y
         };
         if(playerId)
         {
            _loc12_["id"] = playerId;
         }
         if(dir)
         {
            LogUtils.log("Emit message dir: " + dir,this,1,"Emission",false,false,false);
            _loc10_ = dir.x * 10000;
            _loc11_ = dir.y * 10000;
            if(_loc10_ != 0 || _loc11_ != 0)
            {
               _loc12_["dx"] = _loc10_;
               _loc12_["dy"] = _loc11_;
            }
         }
         if(powerBar != -1 && powerBar != 0)
         {
            _loc12_["p"] = powerBar;
         }
         if(playerAttackValue > 0)
         {
            _loc12_["a"] = playerAttackValue;
         }
         if(impulseList && impulseList.length > 0)
         {
            _loc12_["il"] = impulseList;
         }
         if(damageList && damageList.length > 0)
         {
            _loc12_["dl"] = damageList;
         }
         if(terrainList && terrainList.length > 0)
         {
            _loc12_["tl"] = terrainList;
         }
         super(_loc12_);
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
