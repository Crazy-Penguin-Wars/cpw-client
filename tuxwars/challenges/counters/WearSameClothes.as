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
       
      
      public function WearSameClothes(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleEndGameConfirm(msg:ChallengeEndGameConfirm) : void
      {
         for each(var self in msg.players)
         {
            var _loc4_:* = self;
            if(_loc4_._id == playerId)
            {
               for each(var other in msg.players)
               {
                  var _loc5_:* = other;
                  var _loc6_:* = self;
                  if(_loc5_._id != _loc6_._id && loopClothingSlots(self,other))
                  {
                     updateValue(1);
                  }
               }
               break;
            }
         }
      }
      
      private function loopClothingSlots(self:PlayerGameObject, other:PlayerGameObject) : Boolean
      {
         for each(var slotID in SLOTS_TO_COUNT)
         {
            if(!isSameClothing(self.wornItemsContainer.getWornItemInSlot(slotID),other.wornItemsContainer.getWornItemInSlot(slotID)))
            {
               return false;
            }
         }
         return true;
      }
      
      private function isSameClothing(itemSelf:ClothingItem, itemOther:ClothingItem) : Boolean
      {
         if(itemSelf != null && itemOther != null && itemSelf.id == itemOther.id)
         {
            return true;
         }
         return false;
      }
   }
}
