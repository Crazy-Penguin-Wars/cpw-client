package tuxwars.trophys
{
   import tuxwars.challenges.*;
   import tuxwars.data.challenges.*;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.player.Player;
   
   public class TrophyManager
   {
      private static var initialized:Boolean = false;
      
      private static const CHALLENGE_TYPES:Array = ["Battle","Grind","Skill","Impossible"];
      
      private static const FIRST_CHALLENGES:Object = {};
      
      public function TrophyManager()
      {
         super();
         throw new Error("TrophyManager is a static class!");
      }
      
      public static function addTrophies(param1:Player) : void
      {
         var _loc8_:* = undefined;
         var _loc9_:Vector.<ChallengeData> = null;
         var _loc10_:Vector.<ItemData> = null;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc2_:ChallengeData = null;
         var _loc3_:* = null;
         var _loc4_:ChallengeData = null;
         var _loc5_:Boolean = false;
         if(!initialized)
         {
            for each(_loc12_ in CHALLENGE_TYPES)
            {
               _loc2_ = ChallengesData.findFirstChallengeOfType(_loc12_);
               if(_loc2_)
               {
                  FIRST_CHALLENGES[_loc12_] = _loc2_;
               }
            }
         }
         var _loc6_:Object = {};
         var _loc7_:int = 0;
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         for each(_loc8_ in ChallengeManager.instance.getPlayerChallenges(param1.id).activeChallenges)
         {
            _loc6_[_loc8_.type] = _loc8_;
         }
         _loc9_ = new Vector.<ChallengeData>();
         for each(_loc3_ in FIRST_CHALLENGES)
         {
            if(_loc6_[_loc3_.type] != null)
            {
               while(_loc3_.id != Challenge(_loc6_[_loc3_.type]).id)
               {
                  _loc9_.push(_loc3_);
                  _loc4_ = null;
                  for each(_loc13_ in _loc3_.nextChallengeIds)
                  {
                     _loc4_ = ChallengesData.getChallengeData(_loc13_);
                     if(_loc4_.type == _loc3_.type)
                     {
                        _loc3_ = _loc4_;
                        break;
                     }
                  }
               }
            }
         }
         _loc3_ = null;
         _loc10_ = ItemManager.findItemDatas("Trophy");
         for each(_loc11_ in _loc10_)
         {
            _loc5_ = true;
            for each(_loc14_ in _loc11_.requiredChallenges)
            {
               _loc3_ = ChallengesData.getChallengeData(_loc14_);
               if(_loc9_.indexOf(_loc3_) == -1)
               {
                  _loc5_ = false;
                  break;
               }
            }
            if(_loc5_ && !param1.inventory.getItem(_loc11_.id))
            {
               param1.inventory.addItem(_loc11_.id);
            }
         }
      }
   }
}

