package tuxwars.battle.gameobjects.player
{
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.effects.BoosterEffect;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.events.BoosterActivatedMessage;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.gameobjects.EmissionSpawn;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.net.messages.history.HistoryMessageFactory;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   import tuxwars.challenges.events.ChallengeBoosterUsedMessage;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.items.BoosterItem;
   import tuxwars.items.Equippable;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.items.references.EmissionReference;
   import tuxwars.utils.UniqueCounters;
   
   public class PlayerBoosters
   {
       
      
      private const activatedBoosters:Vector.<BoosterItem> = new Vector.<BoosterItem>();
      
      private var player:PlayerGameObject;
      
      private var boosterEffectNormal:BoosterEffect;
      
      private var boosterEffectStart:BoosterEffect;
      
      public function PlayerBoosters(player:PlayerGameObject)
      {
         super();
         this.player = player;
      }
      
      public function addBooster(boosterId:String) : void
      {
         var _loc6_:* = null;
         if(player.isAI())
         {
            return;
         }
         var _loc4_:BoosterItem = player.inventory.hasItem(boosterId,true) ? player.inventory.getItem(boosterId,true) as BoosterItem : ItemManager.createItem(boosterId) as BoosterItem;
         var _loc7_:BoosterItem = findBoosterEffect(_loc4_);
         if(_loc7_)
         {
            removeBoosterEffect(_loc7_);
         }
         _loc4_.reset();
         var _loc5_:Stats = _loc4_.statBonuses;
         _loc4_.tagger = new Tagger(player);
         if(_loc5_)
         {
            if(!player.stats)
            {
               var _loc8_:PlayerGameObject = player;
               LogUtils.addDebugLine("Booster",_loc8_._id + " cannot use booster " + boosterId + ". No Stats found for the player.","PlayerBoosters");
               return;
            }
            for each(var s in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               LogUtils.log("Adding stat boost: " + s + " stat: " + _loc5_.getStat(s));
               player.addPlayerBoosterStat(s,_loc5_.getStat(s));
            }
         }
         var _loc3_:SoundReference = Sounds.getSoundReference(boosterId);
         if(_loc3_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
         }
         var _loc11_:PlayerGameObject = player;
         _loc4_.uniqueId = _loc11_._uniqueId + "Booster" + UniqueCounters.next(boosterId,"PlayerBoosters");
         applyEmissions(_loc4_);
         activatedBoosters.push(_loc4_);
         reduceBoosterDurations("Instant",1);
         if(player.container)
         {
            var _loc12_:PlayerGameObject = player;
            _loc6_ = (_loc12_.game as tuxwars.TuxWarsGame).tuxWorld.addTextEffect(2,_loc4_.name,player.container.x,player.container.y,false);
            var _loc13_:PlayerGameObject = player;
            (_loc13_.game as tuxwars.TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc6_.movieClip,true,false);
            if(boosterEffectNormal)
            {
               boosterEffectNormal.dispose();
            }
            boosterEffectNormal = new BoosterEffect(1,_loc4_);
            if(boosterEffectNormal.movieClip)
            {
               player.container.addChild(boosterEffectNormal.movieClip);
               var _loc14_:PlayerGameObject = player;
               (_loc14_.game as tuxwars.TuxWarsGame).tuxWorld.ignoreLevelSizeScale(boosterEffectNormal.movieClip,true,false);
            }
            if(boosterEffectStart)
            {
               boosterEffectStart.dispose();
            }
            boosterEffectStart = new BoosterEffect(0,_loc4_);
            player.container.addChild(boosterEffectStart.movieClip);
         }
         player.inventory.removeItem(boosterId);
         var _loc15_:PlayerGameObject = player;
         MessageCenter.sendEvent(new BoosterActivatedMessage(_loc15_._id,_loc4_));
         var _loc16_:PlayerGameObject = player;
         MessageCenter.sendEvent(new ChallengeBoosterUsedMessage(_loc4_.id,_loc16_._id));
         var _loc17_:PlayerGameObject = player;
         HistoryMessageFactory.sendUsedItemsMessage(_loc17_._id,_loc4_.id);
      }
      
      private function findBoosterEffect(boosterItem:BoosterItem) : BoosterItem
      {
         for each(var item in activatedBoosters)
         {
            for each(var category in item.categories)
            {
               if(boosterItem.categories.indexOf(category) != -1)
               {
                  return item;
               }
            }
         }
         return null;
      }
      
      public function updateBoosters() : void
      {
         if(player.isAI())
         {
            return;
         }
         for each(var boosterItem in activatedBoosters)
         {
            if(boosterItem.isBoosterEffectUsed())
            {
               removeBoosterEffect(boosterItem);
            }
            else if(boosterItem.className)
            {
               var _loc2_:SimpleScriptManager = SimpleScriptManager;
               if(!tuxwars.battle.simplescript.SimpleScriptManager._instance)
               {
                  new tuxwars.battle.simplescript.SimpleScriptManager();
               }
               tuxwars.battle.simplescript.SimpleScriptManager._instance.run(true,boosterItem,new SimpleScriptParams(player));
            }
         }
      }
      
      public function reduceBoosterDurations(type:String, amount:int) : void
      {
         if(player.isAI())
         {
            return;
         }
         for each(var boosterItem in activatedBoosters)
         {
            boosterItem.reduceBoosterDuration(type,amount);
         }
      }
      
      private function applyEmissions(boosterItem:BoosterItem) : void
      {
         if(boosterItem.emissions)
         {
            boosterItem.location = player.bodyLocation.copy();
            boosterItem.emitLocation = player.bodyLocation.copy();
            boosterItem.playerBoosterStats = player.playerBoosterStats;
            var _loc2_:PlayerGameObject = player;
            MessageCenter.sendEvent(new EmissionMessage(new EmissionSpawn(boosterItem,boosterItem.location,boosterItem.tagger),_loc2_._id));
            if(boosterItem.playerBoosterStats != null)
            {
               boosterItem.playerBoosterStats.dispose();
               boosterItem.playerBoosterStats = null;
            }
         }
      }
      
      private function removeBoosterEffect(boosterItem:BoosterItem) : void
      {
         var _loc3_:Stats = boosterItem.statBonuses;
         if(_loc3_)
         {
            for each(var statId in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               player.removePlayerBoosterStat(statId,_loc3_.getStat(statId));
            }
         }
         activatedBoosters.splice(activatedBoosters.indexOf(boosterItem),1);
         boosterItem = null;
         if(boosterEffectNormal)
         {
            boosterEffectNormal.dispose();
         }
         boosterEffectNormal = null;
         if(boosterEffectStart)
         {
            boosterEffectStart.dispose();
         }
         boosterEffectStart = null;
      }
      
      public function isBoosterCategoryActivated(categories:Array) : Boolean
      {
         for each(var boosterItem in activatedBoosters)
         {
            for each(var categoryId in categories)
            {
               if(boosterItem.hasCategory(categoryId))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getMissileBoostingEmissions() : Array
      {
         var boosterEmissions:Array = [];
         for each(var boosterItem in activatedBoosters)
         {
            for each(var er in boosterItem.getBoosterMissileEmissions())
            {
               boosterEmissions.push(er);
            }
         }
         return boosterEmissions;
      }
      
      public function getExplosionBoostingEmissions() : Array
      {
         var boosterEmissions:Array = [];
         for each(var boosterItem in activatedBoosters)
         {
            for each(var e in boosterItem.getBoosterExplosionEmissions())
            {
               boosterEmissions.push(e);
            }
         }
         return boosterEmissions;
      }
   }
}
