package tuxwars.battle.rewards
{
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class EmptyRewardsHandler extends RewardsHandler
   {
       
      
      public function EmptyRewardsHandler(player:PlayerGameObject)
      {
         super(player);
      }
      
      override public function get itemsLooted() : Vector.<LootItem>
      {
         return new Vector.<LootItem>();
      }
      
      override public function getInGameMoneyGained() : int
      {
         return 0;
      }
      
      override public function getPremiumMoneyGained() : int
      {
         return 0;
      }
      
      override public function getExperienceGained() : int
      {
         return 0;
      }
      
      override public function addInGameMoneyGained(gain:int, targetObject:PhysicsGameObject) : void
      {
      }
      
      override public function damageDoneToTarget(damage:int, targetObject:PhysicsGameObject) : void
      {
      }
   }
}
