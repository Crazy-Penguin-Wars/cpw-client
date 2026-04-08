package tuxwars.battle.ui.screen.emoticonselection
{
   import com.dchoc.messages.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.ui.components.*;
   import tuxwars.utils.*;
   
   public class EmoticonSelectionScreen extends TuxUIElementScreen
   {
      private static const ANIM_IN:String = "Visible_To_Hover";
      
      private static const ANIM_OUT:String = "Hover_To_Visible";
      
      private static const EMOTE_CONTAINER:String = "Tooltip_Emote";
      
      private var emoteContainer:MovieClip;
      
      public function EmoticonSelectionScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         var _loc6_:* = undefined;
         var _loc3_:MovieClip = null;
         var _loc4_:IconToggleButton = null;
         this.emoteContainer = param1.getChildByName("Tooltip_Emote") as MovieClip;
         super(this.emoteContainer,param2);
         this.emoteContainer.mouseEnabled = false;
         this.emoteContainer.mouseChildren = false;
         var _loc5_:Vector.<ItemData> = ItemManager.findItemDatas("Emoticon");
         for each(_loc6_ in _loc5_)
         {
            _loc3_ = this.emoteContainer.getChildAt(_loc6_.sortPriority) as MovieClip;
            _loc4_ = TuxUiUtils.createButton(IconToggleButton,_loc3_,null,this.emoticonSelectedCallBack);
            _loc4_.setIcon(_loc6_.icon);
         }
         setShowTransitions(false);
         setVisible(false);
         setShowTransitions(true);
      }
      
      override public function dispose() : void
      {
         this.emoteContainer = null;
         super.dispose();
      }
      
      private function animIn() : void
      {
         setVisible(true);
         this.emoteContainer.mouseEnabled = true;
         this.emoteContainer.mouseChildren = true;
      }
      
      private function animOut() : void
      {
         setVisible(false);
         this.emoteContainer.mouseEnabled = false;
         this.emoteContainer.mouseChildren = false;
      }
      
      public function emoteCallback(param1:MouseEvent) : void
      {
         if(getVisible())
         {
            this.animOut();
         }
         else
         {
            this.animIn();
         }
      }
      
      private function emoticonSelectedCallBack(param1:MouseEvent) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:int = int(this.emoteContainer.getChildIndex(this.emoteContainer.getChildByName(param1.target.name)));
         var _loc3_:Vector.<ItemData> = ItemManager.findItemDatas("Emoticon");
         MessageCenter.sendMessage("EmoticonUsed");
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.sortPriority == _loc2_)
            {
               MessageCenter.sendEvent(new UseEmoticonMessage(game.player.id,_loc4_.id));
               break;
            }
         }
         this.animOut();
      }
   }
}

