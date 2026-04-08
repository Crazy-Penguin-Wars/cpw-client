package tuxwars.home.ui.logic.slotmachine
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.slotmachine.*;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.net.*;
   import tuxwars.states.TuxState;
   
   public class SlotMachineLogic extends TuxUILogic
   {
      private const _slots:Array;
      
      private const _winslots:Array;
      
      private var _currentPageIndex:int;
      
      private const WIN_STRAIGHT:Array;
      
      private const PUT_SLOT:Array;
      
      private const JACKPOT_LINES:Array;
      
      private const CHECK_SEQUENCE:Array;
      
      private var amountOfFriends:Array;
      
      private var winLines:Array;
      
      private var awardArray:Array;
      
      private var winMessageArray:Array;
      
      private var servedItem:String;
      
      private var servedItemAmount:int;
      
      private var _data:Object;
      
      public var maxDailySpins:int;
      
      public var costPerSpin:int;
      
      private var loader:URLResourceLoader;
      
      private var servedReel1:int;
      
      private var servedReel2:int;
      
      private var servedReel3:int;
      
      private var friendAmount:int;
      
      private var currentWinLine:int;
      
      private var amountFriends:int;
      
      private var reel1:GraphicsReference;
      
      private var reel2:GraphicsReference;
      
      private var reel3:GraphicsReference;
      
      private var winReel1:GraphicsReference;
      
      private var winReel2:GraphicsReference;
      
      private var winReel3:GraphicsReference;
      
      private var servedArray:Array;
      
      private const lineOfIcons:Vector.<SlotMachineIcon>;
      
      public function SlotMachineLogic(param1:TuxWarsGame, param2:TuxState)
      {
         var _loc6_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:String = null;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:* = undefined;
         var _loc28_:Row = null;
         var _loc29_:Row = null;
         this._slots = [];
         this._winslots = [];
         this.WIN_STRAIGHT = [[0,0,0],[1,1,1],[-1,-1,-1],[-1,0,1],[1,0,-1]];
         this.PUT_SLOT = [[-1,-1,-1],[0,0,0],[1,1,1]];
         this.JACKPOT_LINES = [[1,4,7],[2,5,8],[3,6,9],[3,5,7],[1,5,9]];
         this.CHECK_SEQUENCE = [1,2,0,3,4];
         this.amountOfFriends = [];
         this.winLines = [];
         this.awardArray = [];
         this.winMessageArray = [];
         this.lineOfIcons = new Vector.<SlotMachineIcon>();
         super(param1,param2);
         this.amountFriends = param1.player.friends.getOnlyNeighbors().length + 1;
         var _loc3_:Array = [];
         var _loc4_:String = "SlotMachine";
         var _loc5_:* = ProjectManager.findTable(_loc4_);
         for each(_loc6_ in _loc5_._rows)
         {
            _loc3_.push(new SlotMachineReference(_loc6_));
         }
         _loc3_.sort(this.sortByPriority);
         this.amountOfFriends.push(SlotMachineConfReference.getRow().findField("CentralRowActiveFriends").value);
         this.amountOfFriends.push(SlotMachineConfReference.getRow().findField("BottomRowActiveFriends").value);
         this.amountOfFriends.push(SlotMachineConfReference.getRow().findField("TopRowActiveFriends").value);
         this.amountOfFriends.push(SlotMachineConfReference.getRow().findField("BottomLeftToTopRightActiveFriends").value);
         this.amountOfFriends.push(SlotMachineConfReference.getRow().findField("TopLeftToBottomRightActiveFriends").value);
         for each(_loc12_ in _loc3_)
         {
            this._slots.push(_loc12_.id);
            this._slots.push(_loc12_);
         }
         _loc13_ = "SlotWin";
         _loc14_ = ProjectManager.findTable(_loc13_);
         for each(_loc15_ in _loc14_._rows)
         {
            this._winslots.push(new SlotWinReference(_loc15_));
         }
         this._winslots.sort(this.sortWinByPriority);
         _loc16_ = "SlotMachineConfiguration";
         _loc17_ = "Default";
         _loc18_ = ProjectManager.findTable(_loc16_);
         if(!_loc18_.getCache[_loc17_])
         {
            _loc28_ = DCUtils.find(_loc18_.rows,"id",_loc17_);
            if(!_loc28_)
            {
               LogUtils.log("No row with name: \'" + _loc17_ + "\' was found in table: \'" + _loc18_.name + "\'",_loc18_,3);
            }
            _loc18_.getCache[_loc17_] = _loc28_;
         }
         var _loc19_:String = "MaxDailySlotMachinePlays";
         var _loc20_:* = _loc18_.getCache[_loc17_];
         if(!_loc20_.getCache[_loc19_])
         {
            _loc20_.getCache[_loc19_] = DCUtils.find(_loc20_.getFields(),"name",_loc19_);
         }
         var _loc21_:* = _loc20_.getCache[_loc19_];
         this.maxDailySpins = _loc21_.overrideValue != null ? int(_loc21_.overrideValue) : int(_loc21_._value);
         var _loc22_:String = "SlotMachineConfiguration";
         var _loc23_:String = "Default";
         var _loc24_:* = ProjectManager.findTable(_loc22_);
         if(!_loc24_.getCache[_loc23_])
         {
            _loc29_ = DCUtils.find(_loc24_.rows,"id",_loc23_);
            if(!_loc29_)
            {
               LogUtils.log("No row with name: \'" + _loc23_ + "\' was found in table: \'" + _loc24_.name + "\'",_loc24_,3);
            }
            _loc24_.getCache[_loc23_] = _loc29_;
         }
         var _loc25_:String = "PlayPriceInCash";
         var _loc26_:* = _loc24_.getCache[_loc23_];
         if(!_loc26_.getCache[_loc25_])
         {
            _loc26_.getCache[_loc25_] = DCUtils.find(_loc26_.getFields(),"name",_loc25_);
         }
         var _loc27_:* = _loc26_.getCache[_loc25_];
         this.costPerSpin = _loc27_.overrideValue != null ? int(_loc27_.overrideValue) : int(_loc27_._value);
         this.addListeners();
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.setStartingPosition();
      }
      
      public function returnMaxDailySpins() : int
      {
         return this.maxDailySpins;
      }
      
      public function returnCostPerSpin() : int
      {
         return this.costPerSpin;
      }
      
      public function addListeners() : void
      {
         MessageCenter.addListener("SlotMachineStopReel",this.reelsStopped);
         MessageCenter.addListener("NextWinLine",this.nextWinningAnimation);
      }
      
      private function get slotMachineScreen() : SlotMachineScreen
      {
         return screen;
      }
      
      public function getAmountFriends() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 4;
         while(_loc1_ >= 0)
         {
            if(this.amountFriends >= this.amountOfFriends[_loc1_])
            {
               return _loc1_;
            }
            _loc1_--;
         }
         return 0;
      }
      
      private function setStartingPosition() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc1_:GraphicsReference = null;
         this.slotMachineScreen.setLineStateDefault(this.getAmountFriends());
         this.servedReel1 = Math.round(Math.random() * 23);
         this.servedReel2 = Math.round(Math.random() * 23);
         this.servedReel3 = Math.round(Math.random() * 23);
         this.servedArray = [this.servedReel1,this.servedReel2,this.servedReel3];
         for each(_loc2_ in this.slotMachineScreen.getReels())
         {
            for each(_loc3_ in _loc2_.getiIcons())
            {
               _loc1_ = this.getReel(this.servedArray[_loc2_.reelNumber] + this.PUT_SLOT[_loc3_.slotNumber][_loc2_.reelNumber],_loc2_.reelNumber);
               _loc3_.setIcon(_loc1_);
            }
         }
      }
      
      public function getReel(param1:int, param2:int) : GraphicsReference
      {
         trace("GetReel: " + param1 + " for reel: " + param2);
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc3_:String = "SlotMachine";
         var _loc4_:* = ProjectManager.findTable(_loc3_);
         if(param1 > _loc4_._rows.length - 1)
         {
            param1 = 0;
         }
         else if(param1 < -1)
         {
            _loc5_ = "SlotMachine";
            _loc6_ = ProjectManager.findTable(_loc5_);
            param1 = _loc6_._rows.length - 2;
         }
         else if(param1 < 0)
         {
            _loc7_ = "SlotMachine";
            _loc8_ = ProjectManager.findTable(_loc7_);
            param1 = _loc8_._rows.length - 1;
         }
		 trace("Set" + (param1 + 1) + 1)
         return (this._slots[this._slots.indexOf("Set" + (param1 + 1)) + 1] as SlotMachineReference).getResult(param2);
      }
      
      public function start() : void
      {
         MessageCenter.addListener("SlotMachineServerPlayResponse",this.generateReels);
         MessageCenter.sendMessage("SlotMachineServerPlay");
      }
      
      public function generateReels(param1:Message) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:GraphicsReference = null;
         var _loc3_:Object = param1.data;
         this._data = _loc3_;
         if(_loc3_ != null)
         {
            if(_loc3_.central_row_positions != null && _loc3_.number_of_neighbors != null)
            {
               this.amountFriends = _loc3_.number_of_neighbors;
               this.servedReel1 = _loc3_.central_row_positions.reel_0;
               this.servedReel2 = _loc3_.central_row_positions.reel_1;
               this.servedReel3 = _loc3_.central_row_positions.reel_2;
               this.servedArray = [this.servedReel1,this.servedReel2,this.servedReel3];
               if(_loc3_.wins != null && _loc3_.wins.win != null)
               {
                  if(_loc3_.wins.win is Array)
                  {
                     this.winMessageArray = _loc3_.wins.win;
                  }
                  else
                  {
                     this.winMessageArray = [_loc3_.wins.win];
                  }
               }
               this.winLines.splice(0,this.winLines.length);
               this.awardArray.splice(0,this.awardArray.length);
               this.slotMachineScreen.playBackGroundRotationAnim();
               for each(_loc4_ in this.slotMachineScreen.getReels())
               {
                  _loc4_.playReelAnim();
                  for each(_loc5_ in _loc4_.getiIcons())
                  {
                     _loc2_ = this.getReel(this.servedArray[_loc4_.reelNumber] + this.PUT_SLOT[_loc5_.slotNumber][_loc4_.reelNumber],_loc4_.reelNumber);
                     _loc5_.setIcon(_loc2_);
                  }
               }
            }
         }
         this.checkLine();
         ++game.player.slotMachineSpinsUsed;
      }
      
      public function reelsStopped(param1:Message) : void
      {
         this.slotMachineScreen.spinButtonEnable();
         this.slotMachineScreen.enableAllButtons();
         var _loc2_:SoundReference = Sounds.getSoundReference("SlotMachineSpinLight");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
         }
         this.startWinAnimations();
      }
      
      public function checkLine() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ <= 5)
         {
            if(this.amountFriends >= this.amountOfFriends[_loc1_])
            {
               this.compareLine(this.CHECK_SEQUENCE[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      public function compareLine(param1:int) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         for each(_loc3_ in this.slotMachineScreen.getReels())
         {
            this.lineOfIcons.push(_loc3_.getSlotByLine(param1));
         }
         _loc2_ = 0;
         while(_loc2_ < this._winslots.length)
         {
            this.winReel1 = (this._winslots[_loc2_] as SlotWinReference).winResult1;
            this.winReel2 = (this._winslots[_loc2_] as SlotWinReference).winResult2;
            this.winReel3 = (this._winslots[_loc2_] as SlotWinReference).winResult3;
            if(this.winReel1 != null && this.lineOfIcons[0].graphicsReference.row.id == this.winReel1.row.id && this.winReel2 != null && this.lineOfIcons[1].graphicsReference.row.id == this.winReel2.row.id && this.winReel3 != null && this.lineOfIcons[2].graphicsReference.row.id == this.winReel3.row.id)
            {
               this.winLines.push(param1);
               this.winLines.push(2);
               this.calculateReward(_loc2_);
               break;
            }
            if(this.winReel1 != null && this.lineOfIcons[0].graphicsReference.row.id == this.winReel1.row.id && this.winReel2 != null && this.lineOfIcons[1].graphicsReference.row.id == this.winReel2.row.id && this.winReel3 == null)
            {
               this.winLines.push(param1);
               this.winLines.push(1);
               this.calculateReward(_loc2_);
               break;
            }
            if(this.winReel1 != null && this.lineOfIcons[0].graphicsReference.row.id == this.winReel1.row.id && this.winReel2 == null && this.winReel3 == null)
            {
               this.winLines.push(param1);
               this.winLines.push(0);
               this.calculateReward(_loc2_);
               break;
            }
            _loc2_++;
         }
         this.lineOfIcons.splice(0,this.lineOfIcons.length);
      }
      
      private function calculateReward(param1:int) : void
      {
         var _loc2_:int = 0;
         this.awardArray.push(this._winslots[param1] as SlotWinReference);
         if((this._winslots[param1] as SlotWinReference).rewardXP != 0)
         {
            this.awardArray.push("Award_Exp");
            this.awardArray.push(null);
            this.awardArray.push(0);
         }
         else if((this._winslots[param1] as SlotWinReference).rewardCoin != 0)
         {
            this.awardArray.push("Award_Coins");
            this.awardArray.push(null);
            this.awardArray.push(0);
         }
         else if((this._winslots[param1] as SlotWinReference).rewardCash != 0)
         {
            this.awardArray.push("Award_Cash");
            this.awardArray.push(null);
            this.awardArray.push(0);
         }
         else
         {
            if(this.winMessageArray != null)
            {
               _loc2_ = 0;
               while(_loc2_ < this.winMessageArray.length)
               {
                  if(this.winMessageArray[_loc2_].id == (this._winslots[param1] as SlotWinReference).id)
                  {
                     this.servedItem = this.winMessageArray[_loc2_].reward_item.id;
                     this.servedItemAmount = this.winMessageArray[_loc2_].reward_item.amount;
                  }
                  _loc2_++;
               }
            }
            else
            {
               this.servedItem = null;
               this.servedItemAmount = 0;
            }
            this.awardArray.push("Award_Item");
            this.awardArray.push(ItemManager.getItemData(this.servedItem));
            this.awardArray.push(this.servedItemAmount);
         }
      }
      
      private function startWinAnimations() : void
      {
         var _loc1_:SoundReference = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SoundReference = null;
         if(this.winLines.length != 0)
         {
            _loc1_ = Sounds.getSoundReference("SlotMachineSpinLightAfter");
            if(_loc1_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            }
            _loc2_ = 0;
            while(_loc2_ < this.winLines.length / 2)
            {
               this.slotMachineScreen.winLine(this.winLines[_loc2_ * 2]);
               if(this.winLines[_loc2_ * 2 + 1] == 2)
               {
                  _loc3_ = int(this.winLines[_loc2_ * 2]);
                  this.slotMachineScreen.startJackpotStar(this.JACKPOT_LINES[_loc3_][0]);
                  this.slotMachineScreen.startJackpotStar(this.JACKPOT_LINES[_loc3_][1]);
                  this.slotMachineScreen.startJackpotStar(this.JACKPOT_LINES[_loc3_][2]);
               }
               _loc2_++;
            }
            this.currentWinLine = 0;
            this.winningAnimations();
         }
         else
         {
            CRMService.sendEvent("Economy","Slotmachine_Reward","Reward","NoWin");
            _loc4_ = Sounds.getSoundReference("SlotMachineNoWin");
            if(_loc4_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc4_.getMusicID(),_loc4_.getStart(),_loc4_.getType(),"PlaySound"));
            }
            this.slotMachineScreen.displayPressSpin();
            this.slotMachineScreen.checkNoSpins();
         }
      }
      
      public function nextWinningAnimation(param1:Message) : void
      {
         if(this.currentWinLine < this.winLines.length / 2)
         {
            this.slotMachineScreen.display.gotoDefault();
            this.winningAnimations();
         }
         else
         {
            this.slotMachineScreen.checkNoSpins();
            this.giveAllRewards();
         }
      }
      
      public function winningAnimations() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.slotMachineScreen.getReels())
         {
            if(this.winLines[this.currentWinLine * 2 + 1] >= _loc1_.reelNumber)
            {
               _loc1_.flashIcons(this.winLines[this.currentWinLine * 2]);
            }
         }
         this.slotMachineScreen.flashLine(this.winLines[this.currentWinLine * 2]);
         if(this.awardArray[1 + this.currentWinLine * 4] != null)
         {
            this.slotMachineScreen.setAward(this.awardArray[0 + this.currentWinLine * 4],this.awardArray[1 + this.currentWinLine * 4],this.awardArray[2 + this.currentWinLine * 4],this.awardArray[3 + this.currentWinLine * 4]);
            this.slotMachineScreen.playBackGroundWinAnim();
            this.slotMachineScreen.playStartSound();
         }
         ++this.currentWinLine;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("SlotMachineStopReel",this.reelsStopped);
         MessageCenter.removeListener("NextWinLine",this.nextWinningAnimation);
         MessageCenter.removeListener("SlotMachineServerPlayResponse",this.generateReels);
         this.giveAllRewards();
      }
      
      private function sortByPriority(param1:SlotMachineReference, param2:SlotMachineReference) : int
      {
         if(param1.sortOrder == param2.sortOrder)
         {
            return 0;
         }
         if(param1.sortOrder < param2.sortOrder)
         {
            return -1;
         }
         return 1;
      }
      
      private function sortWinByPriority(param1:SlotWinReference, param2:SlotWinReference) : int
      {
         if(param1.sortOrder == param2.sortOrder)
         {
            return 0;
         }
         if(param1.sortOrder < param2.sortOrder)
         {
            return -1;
         }
         return 1;
      }
      
      public function cashSpin() : Boolean
      {
         if(game.player.premiumMoney <= 0)
         {
            return false;
         }
         
         game.player.addPremiumMoney(-SlotMachineConfReference.getRow().findField("PlayPriceInCash").value);
         CRMService.sendEvent("Economy","Spend PC","Confirmed","Slotmachine_Pull_Lever");
         return true;
      }
      
      public function checkOutOfCash() : Boolean
      {
         if(game.player.premiumMoney <= 0)
         {
            return true;
         }
         return false;
      }
      
      private function resetSpinsToCash(param1:Message) : void
      {
         game.player.slotMachineSpinsUsed = this.returnMaxDailySpins() - game.player.premiumMoney;
         game.player.addPremiumMoney(-game.player.premiumMoney);
         this.resetSpinSettings();
      }
      
      private function resetSpinsToMax(param1:Message) : void
      {
         game.player.addPremiumMoney(-game.player.slotMachineSpinsUsed);
         game.player.slotMachineSpinsUsed = 0;
         this.resetSpinSettings();
      }
      
      private function resetSpinSettings() : void
      {
         this.slotMachineScreen.setSpinsLeft();
         this.slotMachineScreen.spinButtonEnable();
      }
      
      public function giveAllRewards() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ItemData = null;
         _loc1_ = 0;
         while(_loc1_ < this.awardArray.length / 4)
         {
            if(this.awardArray[1 + _loc1_ * 4] == "Award_Exp")
            {
               CRMService.sendEvent("Economy","Slotmachine_Reward","Reward","Award_Exp",(this.awardArray[_loc1_ * 4] as SlotWinReference).rewardXP as String);
               game.player.addExp(this.scaleXP((this.awardArray[_loc1_ * 4] as SlotWinReference).rewardXP));
            }
            else if(this.awardArray[1 + _loc1_ * 4] == "Award_Cash")
            {
               CRMService.sendEvent("Economy","Slotmachine_Reward","Reward","Award_Cash",(this.awardArray[_loc1_ * 4] as SlotWinReference).rewardCash as String);
               game.player.addPremiumMoney((this.awardArray[_loc1_ * 4] as SlotWinReference).rewardCash);
            }
            else if(this.awardArray[1 + _loc1_ * 4] == "Award_Item")
            {
               _loc2_ = this.awardArray[2 + _loc1_ * 4] as ItemData;
               CRMService.sendEvent("Economy","Slotmachine_Reward","Reward","Award_Item",_loc2_.id);
               game.player.inventory.addItem(_loc2_.id,this.awardArray[3 + _loc1_ * 4]);
            }
            else
            {
               CRMService.sendEvent("Economy","Slotmachine_Reward","Reward","Award_Coins",(this.awardArray[_loc1_ * 4] as SlotWinReference).rewardCoin as String);
               game.player.addIngameMoney((this.awardArray[_loc1_ * 4] as SlotWinReference).rewardCoin);
            }
            _loc1_++;
         }
         this.awardArray.splice(0,this.awardArray.length);
      }
      
      private function scaleXP(param1:int) : int
      {
         var _loc12_:Row = null;
         var _loc2_:int = 0;
         var _loc3_:int = game.player.level;
         var _loc4_:String = "SlotMachineConfiguration";
         var _loc5_:String = "Default";
         var _loc6_:* = ProjectManager.findTable(_loc4_);
         if(!_loc6_.getCache[_loc5_])
         {
            _loc12_ = DCUtils.find(_loc6_.rows,"id",_loc5_);
            if(!_loc12_)
            {
               LogUtils.log("No row with name: \'" + _loc5_ + "\' was found in table: \'" + _loc6_.name + "\'",_loc6_,3);
            }
            _loc6_.getCache[_loc5_] = _loc12_;
         }
         var _loc7_:String = "XPModifier";
         var _loc8_:* = _loc6_.getCache[_loc5_];
         if(!_loc8_.getCache[_loc7_])
         {
            _loc8_.getCache[_loc7_] = DCUtils.find(_loc8_.getFields(),"name",_loc7_);
         }
         var _loc9_:* = _loc8_.getCache[_loc7_];
         var _loc10_:Number = Number(_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value);
         var _loc11_:* = param1;
         return int(_loc3_ * (_loc3_ * (Math.log(_loc3_) * (_loc10_ * _loc11_))) + _loc11_);
      }
      
      public function getPlayerCash() : int
      {
         return game.player.premiumMoney;
      }
   }
}

