package tuxwars.battle.net.messages.battle
{
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   
   public class FireWeaponMessage extends BattleMessage
   {
      public function FireWeaponMessage(vec:Vec2, loc:Vec2, powerBar:int, weaponId:String, id:String)
      {
         super({
            "t":10,
            "id":id,
            "x":int(vec.x),
            "y":int(vec.y),
            "pb":powerBar,
            "wid":weaponId,
            "lx":int(loc.x),
            "ly":int(loc.y)
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

