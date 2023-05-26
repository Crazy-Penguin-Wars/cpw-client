package tuxwars.battle.gameobjects.player
{
   import com.citrusengine.physics.PhysicsCollisionCategories;
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.game.DCGame;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.gameobjects.stats.modifier.StatAdd;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.Random;
   import flash.display.MovieClip;
   import flash.utils.getTimer;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.shape.Circle;
   import tuxwars.BattleLoader;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.data.BattleOptions;
   import tuxwars.battle.data.WorldPhysics;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.events.PlayerScoreChanged;
   import tuxwars.battle.gameobjects.Damage;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.graphics.InfoContainer;
   import tuxwars.battle.input.PlayerMoveControls;
   import tuxwars.battle.net.messages.battle.ChangeWeaponMessage;
   import tuxwars.battle.net.messages.battle.DieMessage;
   import tuxwars.battle.net.messages.history.HistoryMessageFactory;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.net.responses.UseBoosterResponse;
   import tuxwars.battle.rewards.EmptyRewardsHandler;
   import tuxwars.battle.rewards.RewardsHandler;
   import tuxwars.battle.states.player.PlayerActiveFireSubState;
   import tuxwars.battle.states.player.PlayerDeadState;
   import tuxwars.battle.states.player.PlayerInactiveState;
   import tuxwars.battle.states.player.PlayerSpawningState;
   import tuxwars.battle.states.player.PlayerState;
   import tuxwars.battle.states.player.ai.AIPlayerActiveFireSubState;
   import tuxwars.battle.states.weapon.WeaponDrawState;
   import tuxwars.battle.states.weapon.WeaponPutAwayState;
   import tuxwars.battle.ui.HealthBar;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.battle.world.SpawnPointFinder;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.data.Tuner;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.EmoticonItem;
   import tuxwars.items.WeaponItem;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.player.Inventory;
   import tuxwars.player.PlayerStats;
   import tuxwars.player.WornItems;
   import tuxwars.utils.IScore;
   
   public class PlayerGameObject extends AvatarGameObject implements IScore
   {
      
      public static const MODE_WALK:String = "WalkMode";
      
      public static const MODE_AIM:String = "AimMode";
      
      public static const MODE_FIRE:String = "FireMode";
      
      private static const SEPARATOR:String = "_";
      
      private static const CHICKEN_OUT_GRAPHIC_EXPORT:String = "chicken_out";
       
      
      private var _checkForShoot:Boolean = true;
      
      private var _mode:String;
      
      private var _moveControls:PlayerMoveControls;
      
      private var _infoContainer:InfoContainer;
      
      private var _weapon:Weapon;
      
      private var _healtBar:HealthBar;
      
      private var _fired:Boolean;
      
      private var _inventory:Inventory;
      
      private var _wornItemsContainer:WornItems;
      
      private var _rewardsHandler:RewardsHandler;
      
      private var _emoticonItem:EmoticonItem;
      
      private var _chickenOutGraphic:MovieClip;
      
      private var playerBoosters:PlayerBoosters;
      
      private var playerBoosterStatContainer:PlayerStats;
      
      private var playingFallAnimation:Boolean;
      
      private var gainedScoreForTextEffect:int;
      
      private var gainedKillScoreForTextEffect:int;
      
      private var fallStartTime:int;
      
      private var _suicide:Boolean;
      
      private var resetSuicideTagger:Tagger;
      
      private var lastDamageTagger:Tagger;
      
      private var lastImpulseTagger:Tagger;
      
      private var _tabIndex:int;
      
      private var _walkDistance:Number;
      
      private var lastX:Number;
      
      private var dieMessageSent:Boolean;
      
      private const _followerIdsAtDeath:Vector.<String> = new Vector.<String>();
      
      public function PlayerGameObject(def:PlayerGameObjectDef, game:TuxWarsGame)
      {
         _inventory = def.inventory;
         _wornItemsContainer = new WornItems(null,this);
         super(def,game);
         resetSuicideTagger = new Tagger(this);
         activate();
         _rewardsHandler = BattleLoader.isPracticeMode() ? new EmptyRewardsHandler(this) : new RewardsHandler(this);
         createStat("WalkSpeed",body);
         createStat("MaxSpeed",body);
         createStat("JumpPower",body);
         createStat("Score",body);
         playerStats.walkSpeed = WorldPhysics.getWalkSpeed();
         playerStats.maxSpeed = WorldPhysics.getMaxSpeed();
         playerStats.jumpPower = WorldPhysics.getJumpPower();
         _moveControls = new PlayerMoveControls(this);
         _infoContainer = new InfoContainer(this);
         setCollisionFilterValues(PhysicsCollisionCategories.Get("PENGUIN"),-1,2);
         changeState(new PlayerInactiveState(this),true);
         MessageCenter.addListener("WeaponSelected",weaponSelected);
         MessageCenter.addListener("ingameBetPlaced",addBetEffect);
         LogUtils.addDebugLine("Player","Player " + this._id + " wearing items.","PlayerGameObject");
         for each(var clothingItem in def.wornItems)
         {
            _wornItemsContainer.wearItem(clothingItem.id);
            avatar.wearClothing(clothingItem);
         }
         playerBoosters = new PlayerBoosters(this);
         playerBoosterStatContainer = new PlayerStats();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _moveControls.dispose();
         _moveControls = null;
         _infoContainer.dispose();
         _infoContainer = null;
         if(_weapon)
         {
            MessageCenter.removeListener("WeaponPutAwayAnimPlayed",removeWeapon);
            _weapon.dispose();
            _weapon = null;
         }
         _inventory = null;
         _wornItemsContainer.dispose();
         _wornItemsContainer = null;
         _rewardsHandler.dispose();
         _rewardsHandler = null;
         _healtBar.dispose();
         _healtBar = null;
         MessageCenter.removeListener("WeaponSelected",weaponSelected);
         MessageCenter.removeListener("ingameBetPlaced",addBetEffect);
      }
      
      override public function physicsUpdate(deltaTime:int) : void
      {
         var _loc3_:* = null;
         if(!body)
         {
            return;
         }
         super.physicsUpdate(deltaTime);
         if(isDead())
         {
            return;
         }
         if(isDeadHP())
         {
            sendDieMessage();
            return;
         }
         var _loc2_:PlayerState = state as PlayerState;
         if(_loc2_ != null)
         {
            _loc2_.physicsUpdate(deltaTime);
         }
         moveControls.physicsUpdate();
         limitWalkSpeed();
         updateWalkDistance();
         playerBoosters.updateBoosters();
         updateEmoticon(deltaTime);
         if(_moveControls.isFallingDown() && linearVelocity.y > 125 && !playingFallAnimation)
         {
            changeAnimation("fall");
            playingFallAnimation = true;
            fallStartTime = DCGame.getTime();
         }
         else if(!_moveControls.isFallingDown() && playingFallAnimation)
         {
            _loc3_ = stats.getStat("HP").getLastModifier(Damage) as Damage;
            changeAnimation(_loc3_ && _loc3_.hasTakenDamage("Collision") && _loc3_.creationTime > fallStartTime ? "damagefall" : "landjump",false,landCallback);
            playingFallAnimation = false;
         }
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(isDead())
         {
            return;
         }
         if(_weapon)
         {
            _weapon.logicUpdate(deltaTime);
         }
         updateHealthBar(deltaTime);
         if(gainedScoreForTextEffect > 0 || gainedKillScoreForTextEffect > 0)
         {
            addScoreEffect();
         }
         else if(gainedScoreForTextEffect < 0)
         {
            reduceScoreEffect();
         }
      }
      
      public function handleAction(response:ActionResponse) : void
      {
         switch(response.responseType)
         {
            case 35:
               if(isDeadHP())
               {
                  die();
               }
               dieMessageSent = false;
               break;
            case 34:
               playerBoosters.addBooster(UseBoosterResponse(response).boosterId);
               break;
            case 9:
            case 55:
            case 37:
            case 17:
               break;
            default:
               PlayerState(state).handleMessage(response);
         }
      }
      
      public function activate() : void
      {
         if(lastDamageTagger != resetSuicideTagger || lastImpulseTagger != resetSuicideTagger)
         {
            lastDamageTagger = resetSuicideTagger;
            lastImpulseTagger = resetSuicideTagger;
            LogUtils.log("Activate: Marking last damage tagger: " + lastDamageTagger + " and impulse tagger: " + lastImpulseTagger,this,0,"Tag",false);
         }
      }
      
      public function get walkDistance() : Number
      {
         return Math.round(_walkDistance);
      }
      
      public function set walkDistance(value:Number) : void
      {
         _walkDistance = value;
      }
      
      public function set mode(mode:String) : void
      {
         LogUtils.addDebugLine("Player",this._id + " Setting mode to " + mode,"PlayerGameObject");
         _mode = mode;
      }
      
      public function get mode() : String
      {
         return _mode;
      }
      
      public function get wornItemsContainer() : WornItems
      {
         return _wornItemsContainer;
      }
      
      override public function get stats() : Stats
      {
         return !!_wornItemsContainer ? _wornItemsContainer.getWornItemsStats() : null;
      }
      
      public function get playerStats() : PlayerStats
      {
         return stats as PlayerStats;
      }
      
      public function addPlayerBoosterStat(statName:String, newStat:Stat) : void
      {
         playerBoosterStatContainer.addStat(statName,newStat,body);
      }
      
      public function findPlayerBoosterStat(statName:String) : Stat
      {
         return playerBoosterStatContainer.getStat(statName);
      }
      
      public function get playerBoosterStats() : Stats
      {
         return playerBoosterStatContainer;
      }
      
      public function removePlayerBoosterStat(statName:String, statToRemove:Stat) : void
      {
         playerBoosterStatContainer.removeStat(statName,statToRemove);
      }
      
      public function get rewardsHandler() : RewardsHandler
      {
         return _rewardsHandler;
      }
      
      public function get suicide() : Boolean
      {
         return _suicide;
      }
      
      public function set suicide(value:Boolean) : void
      {
         _suicide = value;
      }
      
      public function isAI() : Boolean
      {
         return false;
      }
      
      public function createHud() : void
      {
         _healtBar = new HealthBar(this);
         container.addChild(_healtBar);
         (this.game as tuxwars.TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_healtBar,false,true);
      }
      
      public function addScore(idOfScore:String, amount:int, killScore:Boolean = false) : void
      {
         if(amount != 0)
         {
            if(!this._markedForRemoval)
            {
               LogUtils.log(this._id + " got " + amount + " score from " + idOfScore,"PlayerGameObject",0,"Score",false,false,false);
               if(playerStats)
               {
                  if(playerStats.score)
                  {
                     playerStats.score.addModifier(new StatAdd(idOfScore,amount));
                     if(amount > 0)
                     {
                        MessageCenter.sendEvent(new PlayerScoreChanged(this,amount));
                     }
                     HistoryMessageFactory.sendScoreMessage(this);
                     if(!killScore)
                     {
                        gainedScoreForTextEffect += amount;
                     }
                     else
                     {
                        gainedKillScoreForTextEffect += amount;
                     }
                  }
                  else
                  {
                     LogUtils.log(this._id + " stat score is null, markedForRemoval: " + this._markedForRemoval,"PlayerGameObject",2,"Score");
                  }
               }
               else
               {
                  LogUtils.log(this._id + " stats are null, markedForRemoval: " + this._markedForRemoval,"PlayerGameObject",2,"Score");
               }
            }
            else
            {
               LogUtils.log(this._id + " is marked for removal: " + this._markedForRemoval + ", example player get markedForRemoval when they are disconnected","PlayerGameObject",0,"Score");
            }
         }
      }
      
      public function addScoreFromDamage(idOfScore:String, damage:int) : void
      {
         if(damage < 0)
         {
            LogUtils.log("No score for negative damage: " + damage + " from " + idOfScore + " to " + this._id,"PlayerGameObject",3,"Score",true,true);
            return;
         }
         var _loc3_:int = damage * (100 / (90 + damage / 3));
         LogUtils.log("Converted: " + damage + " to score: " + _loc3_,"PlayerGameObject",0,"Score",false,false,false);
         addScore("Damaged_" + idOfScore,_loc3_);
      }
      
      public function reduceScoreFromDamage(idOfScore:String, damage:int) : void
      {
         var _loc5_:BattleOptions = BattleOptions;
         var scoreBasedOnDamage:int = damage * (100 / (90 + damage / 3)) * (-1 * Number(tuxwars.battle.data.BattleOptions.getRow().findField("ScoreDamager").value));
         LogUtils.log("Converted: " + damage + " to score: " + scoreBasedOnDamage,"PlayerGameObject",0,"Score",false,false,false);
         var score:int = getScore();
         if(scoreBasedOnDamage + score < 0)
         {
            scoreBasedOnDamage = score * -1;
         }
         addScore("Damaged_" + idOfScore,scoreBasedOnDamage);
      }
      
      public function getScore() : int
      {
         try
         {
            return playerStats.score.calculateRoundedValue();
         }
         catch(e:Error)
         {
            LogUtils.addDebugLine("Error",e.message);
            LogUtils.addDebugLine("Error",e.getStackTrace());
            return 0;
         }
      }
      
      override public function canTakeDamage() : Boolean
      {
         return !isDead() && !isDeadHP() && !isSpawning();
      }
      
      override public function reduceHitPoints(damageSource:Damage) : void
      {
         super.reduceHitPoints(damageSource);
         if(damageSource.amount != 0)
         {
            if(damageSource.amount > 0)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",Sounds.getHurt()));
            }
            HistoryMessageFactory.sendHitPointsMessage(this);
         }
      }
      
      public function get weapon() : Weapon
      {
         return _weapon;
      }
      
      public function getMissileBoosterEmissions() : Array
      {
         return playerBoosters.getMissileBoostingEmissions();
      }
      
      public function getExplosionBoosterEmissions() : Array
      {
         return playerBoosters.getExplosionBoostingEmissions();
      }
      
      public function changeWeapon(name:String) : void
      {
         LogUtils.log(this._id + " setting weapon to " + name,"PlayerGameObject",1,"Weapon",false);
         if(_weapon)
         {
            if(isDead())
            {
               removeWeapon(new Message("WeaponPutAwayAnimPlayed",{"player":this}));
            }
            else
            {
               _weapon.changeState(new WeaponPutAwayState(_weapon,this.game as tuxwars.TuxWarsGame,name));
            }
         }
         else if(name)
         {
            createWeapon(name);
         }
      }
      
      public function createWeapon(name:String, immediately:Boolean = false) : void
      {
         LogUtils.log(this._id + " creating weapon " + name,"PlayerGameObject",1,"Weapon",false);
         var _loc3_:WeaponItem = _inventory.hasItem(name,true) ? _inventory.getItem(name,true) as WeaponItem : ItemManager.createItem(name) as WeaponItem;
         _weapon = _loc3_.getAsWearableItem() as Weapon;
         replayAnimation();
         _weapon.player = this;
         avatar.addBodyPart(_weapon.bodyPart);
         avatar.putOnItem(_weapon);
         _weapon.changeState(new WeaponDrawState(_weapon,this.game as tuxwars.TuxWarsGame),immediately);
         MessageCenter.addListener("WeaponPutAwayAnimPlayed",removeWeapon);
      }
      
      public function isDead() : Boolean
      {
         return state is PlayerDeadState;
      }
      
      public function isSpawning() : Boolean
      {
         return state is PlayerSpawningState;
      }
      
      public function get moveControls() : PlayerMoveControls
      {
         return _moveControls;
      }
      
      public function get infoContainer() : InfoContainer
      {
         return _infoContainer;
      }
      
      public function set walking(walking:Boolean) : void
      {
         if(_weapon && _weapon.isAiming())
         {
            _weapon.weaponClip.gotoAndStop("aim");
         }
      }
      
      public function updateHealthBar(deltaTime:int) : void
      {
         if(_healtBar)
         {
            _healtBar.logicUpdate(deltaTime);
         }
      }
      
      override public function changeAnimation(animName:String, loop:Boolean = true, callback:Function = null) : Boolean
      {
         var _loc4_:* = null;
         if(avatar.currentAnimation)
         {
            _loc4_ = avatar.currentAnimation.classDefinitionName;
            if(_loc4_ == "dying" && animName != "spawn")
            {
               return false;
            }
         }
         return avatar.animate(getAnimation(animName,loop,callback));
      }
      
      public function aim(vec:Vec2 = null) : Vec2
      {
         var _loc2_:Vec2 = !!vec ? vec.copy() : Vec2.get(container.mouseX,container.mouseY);
         if(direction == 1 && _loc2_.x < 0)
         {
            direction = 0;
         }
         else if(direction == 0 && _loc2_.x >= 0)
         {
            direction = 1;
         }
         if(weapon && weapon.isAiming())
         {
            weapon.aim(_loc2_.copy());
         }
         LogUtils.addDebugLine("Weapon",this._id + " aiming at " + _loc2_,"PlayerGameObject");
         return _loc2_;
      }
      
      public function get fired() : Boolean
      {
         return _fired;
      }
      
      public function set fired(value:Boolean) : void
      {
         _fired = value;
      }
      
      public function get checkForShoot() : Boolean
      {
         return _checkForShoot;
      }
      
      public function set checkForShoot(value:Boolean) : void
      {
         _checkForShoot = value;
      }
      
      public function isShooting() : Boolean
      {
         return state is PlayerActiveFireSubState || state is AIPlayerActiveFireSubState;
      }
      
      public function get inventory() : Inventory
      {
         return _inventory;
      }
      
      override public function affectsGameObject(type:String, taggerGameObject:PhysicsGameObject) : Boolean
      {
         if(type == "penguin" || type == "player" && (taggerGameObject == null || taggerGameObject is PlayerGameObject && _loc3_._id == this._id) || type == "enemy" && (taggerGameObject == null || taggerGameObject is PlayerGameObject && _loc4_._id != this._id))
         {
            return true;
         }
         return super.affectsGameObject(type,taggerGameObject);
      }
      
      public function useBooster(boosterId:String) : void
      {
         playerBoosters.addBooster(boosterId);
      }
      
      public function reduceBoosterDurations(type:String, amount:int) : void
      {
         playerBoosters.reduceBoosterDurations(type,amount);
      }
      
      public function isBoosterCategoryActivated(categories:Array) : Boolean
      {
         return playerBoosters.isBoosterCategoryActivated(categories);
      }
      
      override public function handleExplosionImpulse(location:Vec2, taggerGameObject:PhysicsGameObject) : void
      {
         super.handleExplosionImpulse(location,taggerGameObject);
         if(taggerGameObject)
         {
            lastImpulseTagger = new Tagger(taggerGameObject);
            LogUtils.log("Marking last impulse tagger: " + lastImpulseTagger,this,1,"Tag",false,false,false);
         }
      }
      
      override public function handleExplosionDamage(damageSource:Damage) : void
      {
         if(!canTakeDamage())
         {
            return;
         }
         super.handleExplosionDamage(damageSource);
         if(damageSource.taggingPlayer)
         {
            lastDamageTagger = new Tagger(damageSource.taggingPlayer);
            LogUtils.log("Marking last damage tagger: " + lastDamageTagger,this,1,"Tag",false,false,false);
         }
         if(damageSource.amount > 0)
         {
            changeAnimation("damagehit",false,hitCallback);
            reduceBoosterDurations("Hit",1);
         }
      }
      
      public function useEmoticon(emoticonId:String) : void
      {
         if(_emoticonItem && !_emoticonItem.isFinished())
         {
            return;
         }
         _emoticonItem = ItemManager.createItem(emoticonId) as EmoticonItem;
         _emoticonItem.tagger = new Tagger(this);
         var sound:SoundReference = Sounds.getSoundReference(emoticonId);
         if(sound)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",sound.getMusicID(),sound.getStart(),sound.getType()));
         }
         if(_emoticonItem)
         {
            container.addChild(_emoticonItem.getEmoticonItemGraphicMovieClip());
            _emoticonItem.animIn();
            (this.game as tuxwars.TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_emoticonItem.getEmoticonItemGraphicMovieClip(),true,false);
            MessageCenter.sendMessage("Emoticons",this);
         }
      }
      
      public function chickeningOut(status:int) : void
      {
         if(status == 1)
         {
            if(!_chickenOutGraphic)
            {
               _chickenOutGraphic = DCResourceManager.instance.getFromSWF("flash/characters/penguin_overhead_animations.swf","chicken_out");
            }
            container.addChild(_chickenOutGraphic);
            (this.game as tuxwars.TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_chickenOutGraphic,false,false);
         }
         else if(_chickenOutGraphic)
         {
            container.removeChild(_chickenOutGraphic);
         }
      }
      
      public function setTabIndex(index:int) : void
      {
         _tabIndex = index;
      }
      
      public function getTabIndex() : int
      {
         return _tabIndex;
      }
      
      public function respawn(loc:Vec2, sleep:Boolean) : void
      {
         if(!loc)
         {
            loc = findSpawnPoint();
         }
         body.position = loc.copy(true);
         updateGraphics();
         if(sleep)
         {
            body.allowMovement = false;
         }
         LogUtils.log("Spawning player: " + this + " loc: " + bodyLocation + " stepTime: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"PhysicsWorld",false,false,false);
      }
      
      public function get followerIdsAtDeath() : Vector.<String>
      {
         return _followerIdsAtDeath;
      }
      
      override public function handleBeginContact(otherBody:Body, arbiterList:ArbiterList) : void
      {
         if(!body || otherBody.userData.gameObject.isSensorEnabled)
         {
            return;
         }
         if(!body.allowMovement)
         {
            body.allowMovement = true;
         }
         handleCollision(otherBody,arbiterList);
         var _loc3_:Boolean = BattleManager.isActivePlayer(this._id);
         if(!_loc3_ || _loc3_ && !(otherBody.userData.gameObject is PlayerGameObject))
         {
            updateTag(otherBody.userData.gameObject);
         }
      }
      
      override protected function handleCollision(otherBody:Body, arbiterList:ArbiterList) : void
      {
         if(!canTakeDamage())
         {
            return;
         }
         super.handleCollision(otherBody,arbiterList);
         var _loc3_:Number = findFirstCollisionImpulse(arbiterList,otherBody);
         takeCollisionDamage(_loc3_,otherBody.userData.gameObject);
         LogUtils.log("PlayerGameObject collision impulse: " + _loc3_ + " other: " + (otherBody.userData.gameObject != null ? otherBody.userData.gameObject.id : null) + " stepTime: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Collision",false,false,false);
         LogUtils.log("Other tag: " + otherBody.userData.gameObject.tag,this,1,"Tag",false,false,false);
      }
      
      override protected function outOfWorld() : void
      {
         if(isDead() || isDeadHP() || isSpawning())
         {
            return;
         }
         LogUtils.log("Out of world death: " + this._id,this,0,"Match",false);
         emptyCollectedDamage();
      }
      
      override protected function createStats() : Stats
      {
         return new PlayerStats();
      }
      
      private function die() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(!isDead() && !isSpawning() && isPossibleToDieBasedOnWeaponState())
         {
            LogUtils.log(this._id + " is dead. Rest In Pieces.",this,1,"Match",false,false,true);
            LogUtils.log(this._id + " state: " + state,this,1,"Match",false,false,true);
            _loc1_ = tag.findLatestPlayerTagger();
            if(_loc1_ && _loc3_._id != this._id)
            {
               _loc2_ = _loc1_.gameObject as PlayerGameObject;
               var _loc4_:Tuner = Tuner;
               _loc2_.addScore("Killed_" + this._id,tuxwars.data.Tuner.getField("KillOpponentBonus").value,false);
            }
            _suicide = wasSuicide(_loc1_);
            changeState(new PlayerDeadState(this),true);
            MessageCenter.sendMessage("PlayerDied",this);
            emptyCollectedDamage();
            MessageCenter.sendEvent(new ChallengePlayerDiedMessage(this,"TODO"));
            _followerIdsAtDeath.splice(0,_followerIdsAtDeath.length);
            LogUtils.log("PlayerGameObject died hp: " + calculateHitPoints(),this,1,"Player",false,false,false);
            removeEmoticon();
         }
      }
      
      private function findSpawnPoint() : Vec2
      {
         var _loc2_:SpawnPointFinder = new SpawnPointFinder((this.game as tuxwars.TuxWarsGame).tuxWorld);
         var _loc1_:Number = Number(Circle(body.shapes.at(0)).radius) * 2;
         var _loc3_:Vec2 = _loc2_.findSpawnLocation(_loc1_);
         if(!_loc3_)
         {
            LogUtils.log("Didn\'t find a spawn location for player: " + this,this,2,"PhysicsWorld",false);
         }
         return _loc3_;
      }
      
      private function getAnimation(name:String, looping:Boolean = true, callback:Function = null) : AvatarAnimation
      {
         var _loc4_:String = name.split("_")[0];
         switch(_loc4_)
         {
            case "idle":
            case "walk":
            case "fire":
            case "jump":
            case "damagehit":
            case "landjump":
               if(_weapon)
               {
                  idleMode = false;
                  return new AvatarAnimation(_loc4_ + "_" + _weapon.animationType,looping,callback);
               }
               break;
         }
         if(_weapon)
         {
            idleMode = false;
            return new AvatarAnimation("idle" + "_" + _weapon.animationType,looping,callback);
         }
         return new AvatarAnimation(_loc4_,looping,callback);
      }
      
      private function hitCallback() : void
      {
         if(!isDead())
         {
            idleMode = true;
         }
      }
      
      private function landCallback() : void
      {
         idleMode = true;
      }
      
      private function limitWalkSpeed() : void
      {
         var _loc2_:Number = Math.abs(linearVelocity.x);
         var _loc1_:Number = playerStats.maxSpeed.calculateValue();
         if(_loc2_ > _loc1_)
         {
            body.velocity.x = body.velocity.x > 0 ? _loc1_ : -_loc1_;
         }
      }
      
      private function updateEmoticon(dt:int) : void
      {
         if(_emoticonItem)
         {
            _emoticonItem.reduceDuration(dt);
            if(_emoticonItem.isFinished())
            {
               removeEmoticon();
            }
         }
      }
      
      private function removeEmoticon() : void
      {
         if(_emoticonItem)
         {
            container.removeChild(_emoticonItem.getEmoticonItemGraphicMovieClip());
            _emoticonItem.dispose();
            _emoticonItem = null;
         }
      }
      
      private function removeWeapon(msg:Message) : void
      {
         var _loc2_:PlayerGameObject = msg.data.player;
         if(_loc2_ == this)
         {
            LogUtils.addDebugLine("Weapon",this._id + " removing weapon " + _weapon.id,"PlayerGameObject");
            MessageCenter.removeListener("WeaponPutAwayAnimPlayed",removeWeapon);
            avatar.removeBodyPart(_weapon.bodyPart);
            avatar.takeOffItem(_weapon);
            _weapon.dispose();
            _weapon = null;
            if(msg.data.weapon != null)
            {
               createWeapon(msg.data.weapon);
            }
            else
            {
               replayAnimation();
            }
         }
      }
      
      private function sendDieMessage() : void
      {
         var _loc1_:* = null;
         if(!dieMessageSent && !isDead() && !isSpawning() && isPossibleToDieBasedOnWeaponState() && (BattleManager.isLocalPlayersTurn() || BattleManager.isPracticeMode()))
         {
            _loc1_ = new SpawnPointFinder((this.game as tuxwars.TuxWarsGame).tuxWorld,new Random(getTimer()));
            MessageCenter.sendEvent(new DieMessage(this._id,_loc1_.findSpawnLocation(Number(Circle(body.shapes.at(0)).radius) * 2),_loc1_.wasRandomPoint));
            dieMessageSent = true;
         }
      }
      
      private function wasSuicide(playerTagger:Tagger) : Boolean
      {
         var _loc2_:* = getLatestTagger().gameObject;
         if(_loc2_._id == this._id)
         {
            if(!playerTagger)
            {
               LogUtils.log(this._id + " was Suicide: " + true + " no playerTagger",this,1,"Match",false,false,true);
            }
            else
            {
               var _loc3_:* = playerTagger.gameObject;
               if(_loc3_._id == this._id)
               {
                  LogUtils.log(this._id + " was Suicide: " + true + " self",this,1,"Match",false,false,true);
               }
               else
               {
                  LogUtils.log(this._id + " was Suicide: " + false + " other",this,1,"Match",false,false,true);
               }
            }
         }
         else
         {
            LogUtils.log(this._id + " was Suicide: " + false + " last tagger not self",this,1,"Match",false,false,true);
         }
         return (!playerTagger || _loc4_._id == this._id) && _loc5_._id == this._id;
      }
      
      private function getLatestTagger() : Tagger
      {
         return lastDamageTagger.time > lastImpulseTagger.time ? lastDamageTagger : lastImpulseTagger;
      }
      
      private function isPossibleToDieBasedOnWeaponState() : Boolean
      {
         if(weapon != null && (weapon.state is WeaponDrawState || weapon.state is WeaponPutAwayState))
         {
            return false;
         }
         return true;
      }
      
      private function weaponSelected(msg:Message) : void
      {
         var _loc2_:WeaponItem = msg.data;
         if(BattleManager.isLocalPlayer(this._id) && BattleManager.isLocalPlayersTurn() && !_fired)
         {
            if(_weapon != null && _weapon.id != _loc2_.id)
            {
               MessageCenter.sendEvent(new ChangeWeaponMessage(_loc2_.id,this._id));
            }
            else if(!_weapon)
            {
               MessageCenter.sendMessage("PlayerFireMode",_loc2_.id);
            }
         }
      }
      
      private function replayAnimation() : void
      {
         var _loc1_:Function = avatar.paperDoll.animation.getCallback();
         avatar.paperDoll.animation.clearCallback();
         changeAnimation(avatar.currentAnimation.classDefinitionName,avatar.paperDoll.animation.isLooping(),_loc1_);
      }
      
      private function addScoreEffect() : void
      {
         var scoreString:String = "";
         if(gainedScoreForTextEffect - gainedKillScoreForTextEffect > 0)
         {
            scoreString += ProjectManager.getText("GAINED_SCORE_TEXT_EFFECT",[gainedScoreForTextEffect - gainedKillScoreForTextEffect]) + " ";
         }
         if(gainedKillScoreForTextEffect > 0)
         {
            scoreString += ProjectManager.getText("GAINED_KILL_SCORE_TEXT_EFFECT",[gainedKillScoreForTextEffect]);
         }
         var _loc2_:TextEffect = (this.game as tuxwars.TuxWarsGame).tuxWorld.addTextEffect(2,scoreString,container.x,container.y,false);
         (this.game as tuxwars.TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
         gainedScoreForTextEffect = 0;
         gainedKillScoreForTextEffect = 0;
      }
      
      private function reduceScoreEffect() : void
      {
         var scoreString:String = "";
         if(gainedScoreForTextEffect < 0)
         {
            scoreString += ProjectManager.getText("GAINED_NEGATIVE_SCORE_TEXT_EFFECT",[gainedScoreForTextEffect]) + " ";
         }
         var _loc2_:TextEffect = (this.game as tuxwars.TuxWarsGame).tuxWorld.addTextEffect(2,scoreString,container.x,container.y,false);
         (this.game as tuxwars.TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
         gainedScoreForTextEffect = 0;
         gainedKillScoreForTextEffect = 0;
      }
      
      private function addBetEffect(msg:Message) : void
      {
         var _loc2_:* = null;
         if(this._id == msg.data.id)
         {
            _loc2_ = (this.game as tuxwars.TuxWarsGame).tuxWorld.addTextEffect(8,null,container.x,container.y,false);
            (this.game as tuxwars.TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
         }
      }
      
      private function updateWalkDistance() : void
      {
         if(moveControls.walking)
         {
            if(isNaN(lastX))
            {
               lastX = bodyLocation.x;
               return;
            }
            _walkDistance += Math.abs(lastX - bodyLocation.x);
            lastX = bodyLocation.x;
         }
         else
         {
            lastX = NaN;
         }
      }
   }
}
