package tuxwars.ui.popups
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   import tuxwars.ui.popups.states.levelup.LevelUpPopupSubState;
   import tuxwars.ui.popups.states.refund.RefundPopupSubState;
   
   public class PopUpManager
   {
      
      public static const TYPE_INFORMATION:String = "TypeInformation";
      
      public static const FLAG_RECENT_CB_REFUND:String = "recent_cb_refund";
      
      private static const POPUP_FLAG_KEYS:Array = ["recent_cb_refund"];
      
      private static const POPUPS:Vector.<PopUpBaseSubState> = new Vector.<PopUpBaseSubState>();
      
      private static var _instance:PopUpManager;
      
      private static var _game:TuxWarsGame;
      
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
      
      private static function handleSendGame(msg:Message) : void
      {
         _game = msg.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
      
      public static function get game() : TuxWarsGame
      {
         return _game;
      }
      
      public function triggerLevelUpPopup(whatLevelReached:int, show:Boolean) : void
      {
         if(_game)
         {
            addPopup(new LevelUpPopupSubState(_game,whatLevelReached));
            if(show)
            {
               showPopUps(tuxwars.ui.popups.PopUpManager._game.currentState);
            }
         }
      }
      
      public function triggerPopup(popUp:PopUpBaseSubState, state:TuxState) : void
      {
         if(_game)
         {
            addPopup(popUp);
            showPopUps(state);
         }
      }
      
      public function addPopup(popUp:PopUpBaseSubState) : void
      {
         if(!popUp)
         {
            LogUtils.log("PopUp is null!",this,2,"PopUpManager",false,true,true);
         }
         else if(popUp.type == "Base")
         {
            LogUtils.log("PopUp uses default type: " + popUp.type,this,2,"PopUpManager",false,true,true);
         }
         else if(SORT_ORDER_TYPE.indexOf(popUp.type) < 0)
         {
            LogUtils.log("PopUp of type: " + popUp.type + " has no display order assigned to it!",this,2,"PopUpManager",false,true,true);
         }
         POPUPS.push(popUp);
      }
      
      public function showPopUps(state:TuxState) : void
      {
         if(state)
         {
            POPUPS.sort(sortByTypeAndSubType);
            for each(var popup in POPUPS)
            {
               state.changeState(popup,popup.forcePopup());
               if(popup.forcePopup())
               {
                  POPUPS.splice(POPUPS.indexOf(popup),1);
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
      
      public function sortByTypeAndSubType(a:PopUpBaseSubState, b:PopUpBaseSubState) : int
      {
         var _loc3_:int = SORT_ORDER_TYPE.indexOf(a.type);
         var _loc4_:int = SORT_ORDER_TYPE.indexOf(b.type);
         if(a.type == "TypeLoot" && b.type == "TypeLoot" && a.params is ItemData && b.params is ItemData)
         {
            return ItemManager.sortByItemTypeAndPriority(a.params,b.params);
         }
         if(a.type == "TypeLevelUp" && b.type == "TypeLevelUp" && a.params is int && b.params is int)
         {
            return a.params - b.params;
         }
         return _loc4_ - _loc3_;
      }
      
      public function loadFlags(flags:Object) : void
      {
         if(flags && flags.flag is Array)
         {
            for each(var flag in flags.flag)
            {
               if(flag.hasOwnProperty("key") && flag.hasOwnProperty("value") && POPUP_FLAG_KEYS.indexOf(flag.key) != -1)
               {
                  triggerFlagPopups(flag.key,flag.value);
               }
            }
         }
      }
      
      private function triggerFlagPopups(key:String, value:String) : void
      {
         var _loc3_:* = key;
         if("recent_cb_refund" === _loc3_)
         {
            addPopup(new RefundPopupSubState(_game,value));
         }
      }
   }
}
