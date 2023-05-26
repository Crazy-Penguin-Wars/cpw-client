package tuxwars.home.ui.logic.slotmachine
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.URLResourceLoader;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.slotmachine.SlotMachineIcon;
   import tuxwars.home.ui.screen.slotmachine.SlotMachineReel;
   import tuxwars.home.ui.screen.slotmachine.SlotMachineScreen;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.net.CRMService;
   import tuxwars.states.TuxState;
   
   public class SlotMachineLogic extends TuxUILogic
   {
       
      
      private const _slots:Array = [];
      
      private const _winslots:Array = [];
      
      private var _currentPageIndex:int;
      
      private const WIN_STRAIGHT:Array = [[0,0,0],[1,1,1],[-1,-1,-1],[-1,0,1],[1,0,-1]];
      
      private const PUT_SLOT:Array = [[-1,-1,-1],[0,0,0],[1,1,1]];
      
      private const JACKPOT_LINES:Array = [[1,4,7],[2,5,8],[3,6,9],[3,5,7],[1,5,9]];
      
      private const CHECK_SEQUENCE:Array = [1,2,0,3,4];
      
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
      
      private const lineOfIcons:Vector.<SlotMachineIcon> = new Vector.<SlotMachineIcon>();
      
      public function SlotMachineLogic(game:TuxWarsGame, state:TuxState)
      {
         amountOfFriends = [];
         winLines = [];
         awardArray = [];
         winMessageArray = [];
         super(game,state);
         amountFriends = game.player.friends.getOnlyNeighbors().length + 1;
         var aria:Array = [];
         var _loc7_:ProjectManager = ProjectManager;
         var _loc8_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotMachine");
         for each(var row in _loc8_._rows)
         {
            aria.push(new SlotMachineReference(row));
         }
         aria.sort(sortByPriority);
         var _loc11_:SlotMachineConfReference = SlotMachineConfReference;
         amountOfFriends.push(tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("CentralRowActiveFriends").value);
         var _loc12_:SlotMachineConfReference = SlotMachineConfReference;
         amountOfFriends.push(tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("BottomRowActiveFriends").value);
         var _loc13_:SlotMachineConfReference = SlotMachineConfReference;
         amountOfFriends.push(tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("TopRowActiveFriends").value);
         var _loc14_:SlotMachineConfReference = SlotMachineConfReference;
         amountOfFriends.push(tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("BottomLeftToTopRightActiveFriends").value);
         var _loc15_:SlotMachineConfReference = SlotMachineConfReference;
         amountOfFriends.push(tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("TopLeftToBottomRightActiveFriends").value);
         for each(var hr in aria)
         {
            _slots.push(hr.id);
            _slots.push(hr);
         }
         var _loc18_:ProjectManager = ProjectManager;
         var _loc19_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotWin");
         for each(var row2 in _loc19_._rows)
         {
            _winslots.push(new SlotWinReference(row2));
         }
         _winslots.sort(sortWinByPriority);
         var _loc22_:ProjectManager = ProjectManager;
         var _loc23_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotMachineConfiguration");
         if(!_loc23_._cache["Default"])
         {
            var _loc34_:Row = com.dchoc.utils.DCUtils.find(_loc23_.rows,"id","Default");
            if(!_loc34_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc23_.name + "\'",_loc23_,3);
            }
            _loc23_._cache["Default"] = _loc34_;
         }
         var _loc24_:* = _loc23_._cache["Default"];
         if(!_loc24_._cache["MaxDailySlotMachinePlays"])
         {
            _loc24_._cache["MaxDailySlotMachinePlays"] = com.dchoc.utils.DCUtils.find(_loc24_._fields,"name","MaxDailySlotMachinePlays");
         }
         var _loc25_:* = _loc24_._cache["MaxDailySlotMachinePlays"];
         maxDailySpins = _loc25_.overrideValue != null ? _loc25_.overrideValue : _loc25_._value;
         var _loc26_:ProjectManager = ProjectManager;
         var _loc27_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotMachineConfiguration");
         if(!_loc27_._cache["Default"])
         {
            var _loc38_:Row = com.dchoc.utils.DCUtils.find(_loc27_.rows,"id","Default");
            if(!_loc38_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc27_.name + "\'",_loc27_,3);
            }
            _loc27_._cache["Default"] = _loc38_;
         }
         var _loc28_:* = _loc27_._cache["Default"];
         if(!_loc28_._cache["PlayPriceInCash"])
         {
            _loc28_._cache["PlayPriceInCash"] = com.dchoc.utils.DCUtils.find(_loc28_._fields,"name","PlayPriceInCash");
         }
         var _loc29_:* = _loc28_._cache["PlayPriceInCash"];
         costPerSpin = _loc29_.overrideValue != null ? _loc29_.overrideValue : _loc29_._value;
         addListeners();
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         setStartingPosition();
      }
      
      public function returnMaxDailySpins() : int
      {
         return maxDailySpins;
      }
      
      public function returnCostPerSpin() : int
      {
         return costPerSpin;
      }
      
      public function addListeners() : void
      {
         MessageCenter.addListener("SlotMachineStopReel",reelsStopped);
         MessageCenter.addListener("NextWinLine",nextWinningAnimation);
      }
      
      private function get slotMachineScreen() : SlotMachineScreen
      {
         return screen;
      }
      
      public function getAmountFriends() : int
      {
         var value:int = 0;
         for(value = 4; value >= 0; )
         {
            if(amountFriends >= amountOfFriends[value])
            {
               return value;
            }
            value--;
         }
         return 0;
      }
      
      private function setStartingPosition() : void
      {
         var row:* = null;
         slotMachineScreen.setLineStateDefault(getAmountFriends());
         servedReel1 = Math.round(Math.random() * 23);
         servedReel2 = Math.round(Math.random() * 23);
         servedReel3 = Math.round(Math.random() * 23);
         servedArray = [servedReel1,servedReel2,servedReel3];
         for each(var reel in slotMachineScreen.getReels())
         {
            for each(var icon in reel.getiIcons())
            {
               row = getReel(servedArray[reel.reelNumber] + PUT_SLOT[icon.slotNumber][reel.reelNumber],reel.reelNumber);
               icon.setIcon(row);
            }
         }
      }
      
      public function getReel(returnRow:int, reelNumber:int) : GraphicsReference
      {
         var _loc3_:ProjectManager = ProjectManager;
         var _loc4_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotMachine");
         if(returnRow > Number(_loc4_._rows.length) - 1)
         {
            returnRow = 0;
         }
         else if(returnRow < -1)
         {
            var _loc5_:ProjectManager = ProjectManager;
            var _loc6_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotMachine");
            returnRow = Number(_loc6_._rows.length) - 2;
         }
         else if(returnRow < 0)
         {
            var _loc7_:ProjectManager = ProjectManager;
            var _loc8_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotMachine");
            returnRow = Number(_loc8_._rows.length) - 1;
         }
         return (_slots[_slots.indexOf("Set" + (returnRow + 1)) + 1] as SlotMachineReference).getResult(reelNumber);
      }
      
      public function start() : void
      {
         MessageCenter.addListener("SlotMachineServerPlayResponse",generateReels);
         MessageCenter.sendMessage("SlotMachineServerPlay");
      }
      
      public function generateReels(msg:Message) : void
      {
         var row:* = null;
         var _loc3_:Object = msg.data;
         _data = _loc3_;
         if(_loc3_ != null)
         {
            if(_loc3_.central_row_positions != null && _loc3_.number_of_neighbors != null)
            {
               amountFriends = _loc3_.number_of_neighbors;
               servedReel1 = _loc3_.central_row_positions.reel_0;
               servedReel2 = _loc3_.central_row_positions.reel_1;
               servedReel3 = _loc3_.central_row_positions.reel_2;
               servedArray = [servedReel1,servedReel2,servedReel3];
               if(_loc3_.wins != null && _loc3_.wins.win != null)
               {
                  _loc3_.wins.win is Array ? (winMessageArray = _loc3_.wins.win) : (winMessageArray = [_loc3_.wins.win]);
               }
               winLines.splice(0,winLines.length);
               awardArray.splice(0,awardArray.length);
               slotMachineScreen.playBackGroundRotationAnim();
               for each(var reel in slotMachineScreen.getReels())
               {
                  reel.playReelAnim();
                  for each(var icon in reel.getiIcons())
                  {
                     row = getReel(servedArray[reel.reelNumber] + PUT_SLOT[icon.slotNumber][reel.reelNumber],reel.reelNumber);
                     icon.setIcon(row);
                  }
               }
            }
         }
         checkLine();
         game.player.slotMachineSpinsUsed++;
      }
      
      public function reelsStopped(msg:Message) : void
      {
         slotMachineScreen.spinButtonEnable();
         slotMachineScreen.enableAllButtons();
         var spinlightSound:SoundReference = Sounds.getSoundReference("SlotMachineSpinLight");
         if(spinlightSound)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",spinlightSound.getMusicID(),spinlightSound.getStart(),spinlightSound.getType(),"PlaySound"));
         }
         startWinAnimations();
      }
      
      public function checkLine() : void
      {
         var i:int = 0;
         for(i = 0; i <= 5; )
         {
            if(amountFriends >= amountOfFriends[i])
            {
               compareLine(CHECK_SEQUENCE[i]);
            }
            i++;
         }
      }
      
      public function compareLine(line:int) : void
      {
         var i:int = 0;
         for each(var reel in slotMachineScreen.getReels())
         {
            lineOfIcons.push(reel.getSlotByLine(line));
         }
         for(i = 0; i < _winslots.length; )
         {
            winReel1 = (_winslots[i] as SlotWinReference).winResult1;
            winReel2 = (_winslots[i] as SlotWinReference).winResult2;
            winReel3 = (_winslots[i] as SlotWinReference).winResult3;
            if(winReel1 != null && lineOfIcons[0].graphicsReference.row.id == winReel1.row.id && winReel2 != null && lineOfIcons[1].graphicsReference.row.id == winReel2.row.id && winReel3 != null && lineOfIcons[2].graphicsReference.row.id == winReel3.row.id)
            {
               winLines.push(line);
               winLines.push(2);
               calculateReward(i);
               break;
            }
            if(winReel1 != null && lineOfIcons[0].graphicsReference.row.id == winReel1.row.id && winReel2 != null && lineOfIcons[1].graphicsReference.row.id == winReel2.row.id && winReel3 == null)
            {
               winLines.push(line);
               winLines.push(1);
               calculateReward(i);
               break;
            }
            if(winReel1 != null && lineOfIcons[0].graphicsReference.row.id == winReel1.row.id && winReel2 == null && winReel3 == null)
            {
               winLines.push(line);
               winLines.push(0);
               calculateReward(i);
               break;
            }
            i++;
         }
         lineOfIcons.splice(0,lineOfIcons.length);
      }
      
      private function calculateReward(row:int) : void
      {
         var i:int = 0;
         awardArray.push(_winslots[row] as SlotWinReference);
         if((_winslots[row] as SlotWinReference).rewardXP != 0)
         {
            awardArray.push("Award_Exp");
            awardArray.push(null);
            awardArray.push(0);
         }
         else if((_winslots[row] as SlotWinReference).rewardCoin != 0)
         {
            awardArray.push("Award_Coins");
            awardArray.push(null);
            awardArray.push(0);
         }
         else if((_winslots[row] as SlotWinReference).rewardCash != 0)
         {
            awardArray.push("Award_Cash");
            awardArray.push(null);
            awardArray.push(0);
         }
         else
         {
            if(winMessageArray != null)
            {
               for(i = 0; i < winMessageArray.length; )
               {
                  if(winMessageArray[i].id == (_winslots[row] as SlotWinReference).id)
                  {
                     servedItem = winMessageArray[i].reward_item.id;
                     servedItemAmount = winMessageArray[i].reward_item.amount;
                  }
                  i++;
               }
            }
            else
            {
               servedItem = null;
               servedItemAmount = 0;
            }
            awardArray.push("Award_Item");
            awardArray.push(ItemManager.getItemData(servedItem));
            awardArray.push(servedItemAmount);
         }
      }
      
      private function startWinAnimations() : void
      {
         var spinlightSound:* = null;
         var i:int = 0;
         var jackPotLine:int = 0;
         var sound:* = null;
         if(winLines.length != 0)
         {
            spinlightSound = Sounds.getSoundReference("SlotMachineSpinLightAfter");
            if(spinlightSound)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",spinlightSound.getMusicID(),spinlightSound.getStart(),spinlightSound.getType(),"PlaySound"));
            }
            i = 0;
            while(i < winLines.length / 2)
            {
               slotMachineScreen.winLine(winLines[i * 2]);
               if(winLines[i * 2 + 1] == 2)
               {
                  jackPotLine = int(winLines[i * 2]);
                  slotMachineScreen.startJackpotStar(JACKPOT_LINES[jackPotLine][0]);
                  slotMachineScreen.startJackpotStar(JACKPOT_LINES[jackPotLine][1]);
                  slotMachineScreen.startJackpotStar(JACKPOT_LINES[jackPotLine][2]);
               }
               i++;
            }
            currentWinLine = 0;
            winningAnimations();
         }
         else
         {
            CRMService.sendEvent("Economy","Slotmachine_Reward","Reward","NoWin");
            sound = Sounds.getSoundReference("SlotMachineNoWin");
            if(sound)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",sound.getMusicID(),sound.getStart(),sound.getType(),"PlaySound"));
            }
            slotMachineScreen.displayPressSpin();
            slotMachineScreen.checkNoSpins();
         }
      }
      
      public function nextWinningAnimation(msg:Message) : void
      {
         if(currentWinLine < winLines.length / 2)
         {
            slotMachineScreen.display.gotoDefault();
            winningAnimations();
         }
         else
         {
            slotMachineScreen.checkNoSpins();
            giveAllRewards();
         }
      }
      
      public function winningAnimations() : void
      {
         for each(var reel in slotMachineScreen.getReels())
         {
            if(winLines[currentWinLine * 2 + 1] >= reel.reelNumber)
            {
               reel.flashIcons(winLines[currentWinLine * 2]);
            }
         }
         slotMachineScreen.flashLine(winLines[currentWinLine * 2]);
         if(awardArray[1 + currentWinLine * 4] != null)
         {
            slotMachineScreen.setAward(awardArray[0 + currentWinLine * 4],awardArray[1 + currentWinLine * 4],awardArray[2 + currentWinLine * 4],awardArray[3 + currentWinLine * 4]);
            slotMachineScreen.playBackGroundWinAnim();
            slotMachineScreen.playStartSound();
         }
         currentWinLine++;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("SlotMachineStopReel",reelsStopped);
         MessageCenter.removeListener("NextWinLine",nextWinningAnimation);
         MessageCenter.removeListener("SlotMachineServerPlayResponse",generateReels);
         giveAllRewards();
      }
      
      private function sortByPriority(a:SlotMachineReference, b:SlotMachineReference) : int
      {
         if(a.sortOrder == b.sortOrder)
         {
            return 0;
         }
         if(a.sortOrder < b.sortOrder)
         {
            return -1;
         }
         return 1;
      }
      
      private function sortWinByPriority(a:SlotWinReference, b:SlotWinReference) : int
      {
         if(a.sortOrder == b.sortOrder)
         {
            return 0;
         }
         if(a.sortOrder < b.sortOrder)
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
         var _loc1_:SlotMachineConfReference = SlotMachineConfReference;
         game.player.addPremiumMoney(-Number(tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("PlayPriceInCash").value));
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
      
      private function resetSpinsToCash(msg:Message) : void
      {
         game.player.slotMachineSpinsUsed = returnMaxDailySpins() - game.player.premiumMoney;
         game.player.addPremiumMoney(-game.player.premiumMoney);
         resetSpinSettings();
      }
      
      private function resetSpinsToMax(msg:Message) : void
      {
         game.player.addPremiumMoney(-game.player.slotMachineSpinsUsed);
         game.player.slotMachineSpinsUsed = 0;
         resetSpinSettings();
      }
      
      private function resetSpinSettings() : void
      {
         slotMachineScreen.setSpinsLeft();
         slotMachineScreen.spinButtonEnable();
      }
      
      public function giveAllRewards() : void
      {
         var i:int = 0;
         var _loc1_:* = null;
         for(i = 0; i < awardArray.length / 4; )
         {
            if(awardArray[1 + i * 4] == "Award_Exp")
            {
               CRMService.sendEvent("Economy","Slotmachine_Reward","Reward","Award_Exp",(awardArray[i * 4] as SlotWinReference).rewardXP as String);
               game.player.addExp(scaleXP((awardArray[i * 4] as SlotWinReference).rewardXP));
            }
            else if(awardArray[1 + i * 4] == "Award_Cash")
            {
               CRMService.sendEvent("Economy","Slotmachine_Reward","Reward","Award_Cash",(awardArray[i * 4] as SlotWinReference).rewardCash as String);
               game.player.addPremiumMoney((awardArray[i * 4] as SlotWinReference).rewardCash);
            }
            else if(awardArray[1 + i * 4] == "Award_Item")
            {
               _loc1_ = awardArray[2 + i * 4] as ItemData;
               CRMService.sendEvent("Economy","Slotmachine_Reward","Reward","Award_Item",_loc1_.id);
               game.player.inventory.addItem(_loc1_.id,awardArray[3 + i * 4]);
            }
            else
            {
               CRMService.sendEvent("Economy","Slotmachine_Reward","Reward","Award_Coins",(awardArray[i * 4] as SlotWinReference).rewardCoin as String);
               game.player.addIngameMoney((awardArray[i * 4] as SlotWinReference).rewardCoin);
            }
            i++;
         }
         awardArray.splice(0,awardArray.length);
      }
      
      private function scaleXP(value:int) : int
      {
         var xpScaledValue:int = 0;
         var level:int = game.player.level;
         var _loc6_:ProjectManager = ProjectManager;
         var _loc7_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotMachineConfiguration");
         if(!_loc7_._cache["Default"])
         {
            var _loc12_:Row = com.dchoc.utils.DCUtils.find(_loc7_.rows,"id","Default");
            if(!_loc12_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc7_.name + "\'",_loc7_,3);
            }
            _loc7_._cache["Default"] = _loc12_;
         }
         var _loc8_:* = _loc7_._cache["Default"];
         if(!_loc8_._cache["XPModifier"])
         {
            _loc8_._cache["XPModifier"] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name","XPModifier");
         }
         var _loc9_:* = _loc8_._cache["XPModifier"];
         var modifier:Number = Number(_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value);
         var baseValue:* = value;
         return level * (level * (Math.log(level) * (modifier * baseValue))) + baseValue;
      }
      
      public function getPlayerCash() : int
      {
         return game.player.premiumMoney;
      }
   }
}
