package tuxwars.battle.gameobjects.player
{
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.effects.*;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.net.messages.history.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.challenges.events.*;
   import tuxwars.data.*;
   import tuxwars.items.*;
   import tuxwars.items.managers.*;
   import tuxwars.utils.*;
   
   public class PlayerBoosters
   {
      private const activatedBoosters:Vector.<BoosterItem> = new Vector.<BoosterItem>();
      
      private var player:PlayerGameObject;
      
      private var boosterEffectNormal:BoosterEffect;
      
      private var boosterEffectStart:BoosterEffect;
      
      public function PlayerBoosters(param1:PlayerGameObject)
      {
         super();
         this.player = param1;
      }
      
      public function addBooster(param1:String) : void
      {
         var _loc11_:* = undefined;
         var _loc12_:PlayerGameObject = null;
         var _loc13_:PlayerGameObject = null;
         var _loc14_:PlayerGameObject = null;
         var _loc15_:PlayerGameObject = null;
         var _loc2_:TextEffect = null;
         if(this.player.isAI())
         {
            return;
         }
         var _loc3_:BoosterItem = !!this.player.inventory.hasItem(param1,true) ? this.player.inventory.getItem(param1,true) as BoosterItem : ItemManager.createItem(param1) as BoosterItem;
         var _loc4_:BoosterItem = this.findBoosterEffect(_loc3_);
         if(_loc4_)
         {
            this.removeBoosterEffect(_loc4_);
         }
         _loc3_.reset();
         var _loc5_:Stats = _loc3_.statBonuses;
         _loc3_.tagger = new Tagger(this.player);
         if(_loc5_)
         {
            if(!this.player.stats)
            {
               _loc12_ = this.player;
               LogUtils.addDebugLine("Booster",_loc12_._id + " cannot use booster " + param1 + ". No Stats found for the player.","PlayerBoosters");
               return;
            }
            for each(_loc11_ in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               LogUtils.log("Adding stat boost: " + _loc11_ + " stat: " + _loc5_.getStat(_loc11_));
               this.player.addPlayerBoosterStat(_loc11_,_loc5_.getStat(_loc11_));
            }
         }
         var _loc6_:SoundReference = Sounds.getSoundReference(param1);
         if(_loc6_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc6_.getMusicID(),_loc6_.getStart(),_loc6_.getType(),"PlaySound"));
         }
         var _loc7_:PlayerGameObject = this.player;
         _loc3_.uniqueId = _loc7_._uniqueId + "Booster" + UniqueCounters.next(param1,"PlayerBoosters");
         this.applyEmissions(_loc3_);
         this.activatedBoosters.push(_loc3_);
         this.reduceBoosterDurations("Instant",1);
         if(this.player.container)
         {
            _loc13_ = this.player;
            _loc2_ = (_loc13_.game as TuxWarsGame).tuxWorld.addTextEffect(2,_loc3_.name,this.player.container.x,this.player.container.y,false);
            _loc14_ = this.player;
            (_loc14_.game as TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
            if(this.boosterEffectNormal)
            {
               this.boosterEffectNormal.dispose();
            }
            this.boosterEffectNormal = new BoosterEffect(1,_loc3_);
            if(this.boosterEffectNormal.movieClip)
            {
               this.player.container.addChild(this.boosterEffectNormal.movieClip);
               _loc15_ = this.player;
               (_loc15_.game as TuxWarsGame).tuxWorld.ignoreLevelSizeScale(this.boosterEffectNormal.movieClip,true,false);
            }
            if(this.boosterEffectStart)
            {
               this.boosterEffectStart.dispose();
            }
            this.boosterEffectStart = new BoosterEffect(0,_loc3_);
            this.player.container.addChild(this.boosterEffectStart.movieClip);
         }
         this.player.inventory.removeItem(param1);
         var _loc8_:PlayerGameObject = this.player;
         MessageCenter.sendEvent(new BoosterActivatedMessage(_loc8_._id,_loc3_));
         var _loc9_:PlayerGameObject = this.player;
         MessageCenter.sendEvent(new ChallengeBoosterUsedMessage(_loc3_.id,_loc9_._id));
         var _loc10_:PlayerGameObject = this.player;
         HistoryMessageFactory.sendUsedItemsMessage(_loc10_._id,_loc3_.id);
      }
      
      private function findBoosterEffect(param1:BoosterItem) : BoosterItem
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         for each(_loc2_ in this.activatedBoosters)
         {
            for each(_loc3_ in _loc2_.categories)
            {
               if(param1.categories.indexOf(_loc3_) != -1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function updateBoosters() : void
      {
         var _loc1_:* = undefined;
         if(this.player.isAI())
         {
            return;
         }
         for each(_loc1_ in this.activatedBoosters)
         {
            if(_loc1_.isBoosterEffectUsed())
            {
               this.removeBoosterEffect(_loc1_);
            }
            else if(_loc1_.className)
            {
               if(!SimpleScriptManager.instance)
               {
                  new SimpleScriptManager();
               }
               SimpleScriptManager.instance.run(true,_loc1_,new SimpleScriptParams(this.player));
            }
         }
      }
      
      public function reduceBoosterDurations(param1:String, param2:int) : void
      {
         var _loc3_:* = undefined;
         if(this.player.isAI())
         {
            return;
         }
         for each(_loc3_ in this.activatedBoosters)
         {
            _loc3_.reduceBoosterDuration(param1,param2);
         }
      }
      
      private function applyEmissions(param1:BoosterItem) : void
      {
         var _loc2_:PlayerGameObject = null;
         if(param1.emissions)
         {
            param1.location = this.player.bodyLocation.copy();
            param1.emitLocation = this.player.bodyLocation.copy();
            param1.playerBoosterStats = this.player.playerBoosterStats;
            _loc2_ = this.player;
            MessageCenter.sendEvent(new EmissionMessage(new EmissionSpawn(param1,param1.location,param1.tagger),_loc2_._id));
            if(param1.playerBoosterStats != null)
            {
               param1.playerBoosterStats.dispose();
               param1.playerBoosterStats = null;
            }
         }
      }
      
      private function removeBoosterEffect(param1:BoosterItem) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Stats = param1.statBonuses;
         if(_loc2_)
         {
            for each(_loc3_ in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               this.player.removePlayerBoosterStat(_loc3_,_loc2_.getStat(_loc3_));
            }
         }
         this.activatedBoosters.splice(this.activatedBoosters.indexOf(param1),1);
         param1 = null;
         if(this.boosterEffectNormal)
         {
            this.boosterEffectNormal.dispose();
         }
         this.boosterEffectNormal = null;
         if(this.boosterEffectStart)
         {
            this.boosterEffectStart.dispose();
         }
         this.boosterEffectStart = null;
      }
      
      public function isBoosterCategoryActivated(param1:Array) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         for each(_loc2_ in this.activatedBoosters)
         {
            for each(_loc3_ in param1)
            {
               if(_loc2_.hasCategory(_loc3_))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getMissileBoostingEmissions() : Array
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc1_:Array = [];
         for each(_loc2_ in this.activatedBoosters)
         {
            for each(_loc3_ in _loc2_.getBoosterMissileEmissions())
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function getExplosionBoostingEmissions() : Array
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc1_:Array = [];
         for each(_loc2_ in this.activatedBoosters)
         {
            for each(_loc3_ in _loc2_.getBoosterExplosionEmissions())
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
   }
}

