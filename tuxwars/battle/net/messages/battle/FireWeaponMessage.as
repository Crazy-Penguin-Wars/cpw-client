package tuxwars.battle.net.messages.battle
{
   import nape.geom.Vec2;
   import tuxwars.battle.*;
   
   public class FireWeaponMessage extends BattleMessage
   {
      public function FireWeaponMessage(param1:Vec2, param2:Vec2, param3:int, param4:String, param5:String)
      {
         super({
            "t":10,
            "id":param5,
            "x":int(param1.x),
            "y":int(param1.y),
            "pb":param3,
            "wid":param4,
            "lx":int(param2.x),
            "ly":int(param2.y)
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

