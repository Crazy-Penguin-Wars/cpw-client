package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class UpdateWorldMessage extends SocketMessage
   {
       
      
      public function UpdateWorldMessage(ttl:int, mtl:int = -2147483648, respawn:Array = null, resume:Array = null, powerup:String = null)
      {
         var _loc8_:Object = {
            "t":1,
            "ttl":ttl
         };
         if(mtl != -2147483648)
         {
            _loc8_["mtl"] = mtl;
         }
         if(respawn && respawn.length > 0)
         {
            _loc8_["respawn"] = [];
            for each(var respawnObj in respawn)
            {
               _loc8_["respawn"].push(respawnObj);
            }
         }
         if(resume && resume.length > 0)
         {
            _loc8_["resume"] = [];
            for each(var resumeObj in resume)
            {
               _loc8_["resume"].push(resumeObj);
            }
         }
         if(powerup != null)
         {
            _loc8_["powerup"] = powerup;
         }
         super(_loc8_);
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
