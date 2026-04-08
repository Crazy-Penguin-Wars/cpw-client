package tuxwars.battle.rewards
{
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class EmptyRewardsHandler extends RewardsHandler
   {
      public function EmptyRewardsHandler(param1:PlayerGameObject)
      {
         super(param1);
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
      
      override public function addInGameMoneyGained(param1:int, param2:PhysicsGameObject) : void
      {
      }
      
      override public function damageDoneToTarget(param1:int, param2:PhysicsGameObject) : void
      {
      }
   }
}

