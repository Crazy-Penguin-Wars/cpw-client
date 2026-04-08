package tuxwars.challenges.counters
{
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   import tuxwars.items.ClothingItem;
   
   public class WearSameClothes extends Counter
   {
      private static const SLOTS_TO_COUNT:Array = ["Head","Torso","Feet"];
      
      public function WearSameClothes(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleEndGameConfirm(param1:ChallengeEndGameConfirm) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         for each(_loc2_ in param1.players)
         {
            _loc3_ = _loc2_;
            if(_loc3_._id == playerId)
            {
               for each(_loc4_ in param1.players)
               {
                  _loc5_ = _loc4_;
                  _loc6_ = _loc2_;
                  if(_loc5_._id != _loc6_._id && Boolean(this.loopClothingSlots(_loc2_,_loc4_)))
                  {
                     updateValue(1);
                  }
               }
               break;
            }
         }
      }
      
      private function loopClothingSlots(param1:PlayerGameObject, param2:PlayerGameObject) : Boolean
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in SLOTS_TO_COUNT)
         {
            if(!this.isSameClothing(param1.wornItemsContainer.getWornItemInSlot(_loc3_),param2.wornItemsContainer.getWornItemInSlot(_loc3_)))
            {
               return false;
            }
         }
         return true;
      }
      
      private function isSameClothing(param1:ClothingItem, param2:ClothingItem) : Boolean
      {
         if(param1 != null && param2 != null && param1.id == param2.id)
         {
            return true;
         }
         return false;
      }
   }
}

