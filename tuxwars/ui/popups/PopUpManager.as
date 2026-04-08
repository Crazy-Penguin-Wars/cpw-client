package tuxwars.ui.popups
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.states.*;
   import tuxwars.ui.popups.states.levelup.*;
   import tuxwars.ui.popups.states.refund.*;
   
   public class PopUpManager
   {
      private static var _instance:PopUpManager;
      
      private static var _game:TuxWarsGame;
      
      public static const TYPE_INFORMATION:String = "TypeInformation";
      
      public static const FLAG_RECENT_CB_REFUND:String = "recent_cb_refund";
      
      private static const POPUP_FLAG_KEYS:Array = ["recent_cb_refund"];
      
      private static const POPUPS:Vector.<PopUpBaseSubState> = new Vector.<PopUpBaseSubState>();
      
      private static const SORT_ORDER_TYPE:Array = ["Base","SlotMachinePrize","TypeLoot","TypeLevelUp","PassedStat","QuestionMessageType","TypeCRM","TypeInformation","MessageType","TypeNotEnoughAmmo","TypeNoMoney","TypeError"];
      
      public function PopUpManager()
      {
         super();
         if(!_instance)
         {
            MessageCenter.addListener("SendGame",handleSendGame);
            MessageCenter.sendMessage("GetGame");
         }
      }
      
      public static function get instance() : PopUpManager
      {
         if(!_instance)
         {
            _instance = new PopUpManager();
         }
         return _instance;
      }
      
      private static function handleSendGame(param1:Message) : void
      {
         _game = param1.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
      
      public static function get game() : TuxWarsGame
      {
         return _game;
      }
      
      public function triggerLevelUpPopup(param1:int, param2:Boolean) : void
      {
         if(_game)
         {
            this.addPopup(new LevelUpPopupSubState(_game,param1));
            if(param2)
            {
               this.showPopUps(PopUpManager._game.currentState);
            }
         }
      }
      
      public function triggerPopup(param1:PopUpBaseSubState, param2:TuxState) : void
      {
         if(_game)
         {
            this.addPopup(param1);
            this.showPopUps(param2);
         }
      }
      
      public function addPopup(param1:PopUpBaseSubState) : void
      {
         if(!param1)
         {
            LogUtils.log("PopUp is null!",this,2,"PopUpManager",false,true,true);
         }
         else if(param1.type == "Base")
         {
            LogUtils.log("PopUp uses default type: " + param1.type,this,2,"PopUpManager",false,true,true);
         }
         else if(SORT_ORDER_TYPE.indexOf(param1.type) < 0)
         {
            LogUtils.log("PopUp of type: " + param1.type + " has no display order assigned to it!",this,2,"PopUpManager",false,true,true);
         }
         POPUPS.push(param1);
      }
      
      public function showPopUps(param1:TuxState) : void
      {
         var _loc2_:* = undefined;
         if(param1)
         {
            POPUPS.sort(this.sortByTypeAndSubType);
            for each(_loc2_ in POPUPS)
            {
               param1.changeState(_loc2_,_loc2_.forcePopup());
               if(_loc2_.forcePopup())
               {
                  POPUPS.splice(POPUPS.indexOf(_loc2_),1);
                  return;
               }
            }
            POPUPS.splice(0,POPUPS.length);
         }
      }
      
      public function hasPopUps() : Boolean
      {
         return POPUPS.length > 0;
      }
      
      public function sortByTypeAndSubType(param1:PopUpBaseSubState, param2:PopUpBaseSubState) : int
      {
         var _loc3_:int = int(SORT_ORDER_TYPE.indexOf(param1.type));
         var _loc4_:int = int(SORT_ORDER_TYPE.indexOf(param2.type));
         if(param1.type == "TypeLoot" && param2.type == "TypeLoot" && param1.params is ItemData && param2.params is ItemData)
         {
            return ItemManager.sortByItemTypeAndPriority(param1.params,param2.params);
         }
         if(param1.type == "TypeLevelUp" && param2.type == "TypeLevelUp" && param1.params is int && param2.params is int)
         {
            return param1.params - param2.params;
         }
         return _loc4_ - _loc3_;
      }
      
      public function loadFlags(param1:Object) : void
      {
         var _loc2_:* = undefined;
         if(Boolean(param1) && param1.flag is Array)
         {
            for each(_loc2_ in param1.flag)
            {
               if(Boolean(_loc2_.hasOwnProperty("key")) && Boolean(_loc2_.hasOwnProperty("value")) && POPUP_FLAG_KEYS.indexOf(_loc2_.key) != -1)
               {
                  this.triggerFlagPopups(_loc2_.key,_loc2_.value);
               }
            }
         }
      }
      
      private function triggerFlagPopups(param1:String, param2:String) : void
      {
         var _loc3_:* = param1;
         if("recent_cb_refund" === _loc3_)
         {
            this.addPopup(new RefundPopupSubState(_game,param2));
         }
      }
   }
}

