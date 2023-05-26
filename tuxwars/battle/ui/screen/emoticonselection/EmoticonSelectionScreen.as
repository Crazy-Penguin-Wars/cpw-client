package tuxwars.battle.ui.screen.emoticonselection
{
   import com.dchoc.messages.MessageCenter;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.messages.control.UseEmoticonMessage;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.items.data.EmoticonData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.ui.components.IconToggleButton;
   import tuxwars.utils.TuxUiUtils;
   
   public class EmoticonSelectionScreen extends TuxUIElementScreen
   {
      
      private static const ANIM_IN:String = "Visible_To_Hover";
      
      private static const ANIM_OUT:String = "Hover_To_Visible";
      
      private static const EMOTE_CONTAINER:String = "Tooltip_Emote";
       
      
      private var emoteContainer:MovieClip;
      
      public function EmoticonSelectionScreen(from:MovieClip, game:TuxWarsGame)
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         emoteContainer = from.getChildByName("Tooltip_Emote") as MovieClip;
         super(emoteContainer,game);
         emoteContainer.mouseEnabled = false;
         emoteContainer.mouseChildren = false;
         var _loc6_:Vector.<ItemData> = ItemManager.findItemDatas("Emoticon");
         for each(var eData in _loc6_)
         {
            _loc3_ = emoteContainer.getChildAt(eData.sortPriority) as MovieClip;
            _loc5_ = TuxUiUtils.createButton(IconToggleButton,_loc3_,null,emoticonSelectedCallBack);
            _loc5_.setIcon(eData.icon);
         }
         setShowTransitions(false);
         setVisible(false);
         setShowTransitions(true);
      }
      
      override public function dispose() : void
      {
         emoteContainer = null;
         super.dispose();
      }
      
      private function animIn() : void
      {
         setVisible(true);
         emoteContainer.mouseEnabled = true;
         emoteContainer.mouseChildren = true;
      }
      
      private function animOut() : void
      {
         setVisible(false);
         emoteContainer.mouseEnabled = false;
         emoteContainer.mouseChildren = false;
      }
      
      public function emoteCallback(event:MouseEvent) : void
      {
         if(getVisible())
         {
            animOut();
         }
         else
         {
            animIn();
         }
      }
      
      private function emoticonSelectedCallBack(event:MouseEvent) : void
      {
         var _loc2_:int = emoteContainer.getChildIndex(emoteContainer.getChildByName(event.target.name));
         var _loc4_:Vector.<ItemData> = ItemManager.findItemDatas("Emoticon");
         MessageCenter.sendMessage("EmoticonUsed");
         for each(var eData in _loc4_)
         {
            if(eData.sortPriority == _loc2_)
            {
               MessageCenter.sendEvent(new UseEmoticonMessage(game.player.id,eData.id));
               break;
            }
         }
         animOut();
      }
   }
}
