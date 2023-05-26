package tuxwars.home.ui.screen.matchloading
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.data.RematchDataPlayer;
   
   public class RematchSlot
   {
      
      private static const SLOT_WAITING:String = "Slot_Waiting";
      
      private static const SLOT_READY:String = "Slot_Ready";
      
      private static const SLOT_NEW:String = "Slot_New";
      
      private static const CHARACTER_CONTAINER:String = "Container_Character";
       
      
      private var _design:MovieClip;
      
      private var _slotWaiting:MovieClip;
      
      private var _slotReady:MovieClip;
      
      private var _slotNew:MovieClip;
      
      private var _player:RematchDataPlayer;
      
      private var _status:int;
      
      private var characterContainer:MovieClip;
      
      private var playerAvatar:TuxAvatar;
      
      public function RematchSlot(design:MovieClip)
      {
         super();
         _design = design;
         _player = null;
         _slotWaiting = _design.getChildByName("Slot_Waiting") as MovieClip;
         _slotReady = _design.getChildByName("Slot_Ready") as MovieClip;
         _slotNew = _design.getChildByName("Slot_New") as MovieClip;
         hideStates();
         status = 2;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function set status(value:int) : void
      {
         var nameTF:* = null;
         _status = value;
         _slotWaiting.visible = value == 0;
         _slotReady.visible = value == 1;
         _slotNew.visible = value == 2;
         var _loc3_:MovieClip = getSlotMovieClip();
         if(_loc3_)
         {
            nameTF = _loc3_.getChildByName("Text") as TextField;
            nameTF.text = !!_player ? _player.name : "";
         }
      }
      
      public function set player(player:RematchDataPlayer) : void
      {
         _player = player;
         if(!_player)
         {
            status = 2;
            return;
         }
         status = 1;
         characterContainer = _slotReady.getChildByName("Container_Character") as MovieClip;
         characterContainer.addChild(_player.avatar);
      }
      
      public function get player() : RematchDataPlayer
      {
         return _player;
      }
      
      private function getSlotMovieClip() : MovieClip
      {
         if(_slotReady.visible)
         {
            return _slotReady;
         }
         if(_slotNew.visible)
         {
            return _slotNew;
         }
         if(_slotWaiting.visible)
         {
            return _slotWaiting;
         }
         return null;
      }
      
      private function hideStates() : void
      {
         _slotWaiting.visible = false;
         _slotReady.visible = false;
         _slotNew.visible = false;
      }
   }
}
