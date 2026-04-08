package tuxwars.home.ui.screen.matchloading
{
   import flash.display.*;
   import flash.text.*;
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
      
      public function RematchSlot(param1:MovieClip)
      {
         super();
         this._design = param1;
         this._player = null;
         this._slotWaiting = this._design.getChildByName("Slot_Waiting") as MovieClip;
         this._slotReady = this._design.getChildByName("Slot_Ready") as MovieClip;
         this._slotNew = this._design.getChildByName("Slot_New") as MovieClip;
         this.hideStates();
         this.status = 2;
      }
      
      public function get status() : int
      {
         return this._status;
      }
      
      public function set status(param1:int) : void
      {
         var _loc2_:TextField = null;
         this._status = param1;
         this._slotWaiting.visible = param1 == 0;
         this._slotReady.visible = param1 == 1;
         this._slotNew.visible = param1 == 2;
         var _loc3_:MovieClip = this.getSlotMovieClip();
         if(_loc3_)
         {
            _loc2_ = _loc3_.getChildByName("Text") as TextField;
            _loc2_.text = !!this._player ? this._player.name : "";
         }
      }
      
      public function set player(param1:RematchDataPlayer) : void
      {
         this._player = param1;
         if(!this._player)
         {
            this.status = 2;
            return;
         }
         this.status = 1;
         this.characterContainer = this._slotReady.getChildByName("Container_Character") as MovieClip;
         this.characterContainer.addChild(this._player.avatar);
      }
      
      public function get player() : RematchDataPlayer
      {
         return this._player;
      }
      
      private function getSlotMovieClip() : MovieClip
      {
         if(this._slotReady.visible)
         {
            return this._slotReady;
         }
         if(this._slotNew.visible)
         {
            return this._slotNew;
         }
         if(this._slotWaiting.visible)
         {
            return this._slotWaiting;
         }
         return null;
      }
      
      private function hideStates() : void
      {
         this._slotWaiting.visible = false;
         this._slotReady.visible = false;
         this._slotNew.visible = false;
      }
   }
}

