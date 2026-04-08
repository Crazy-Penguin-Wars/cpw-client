package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.data.*;
   
   public class SlotMachineReel
   {
      private var _design:MovieClip;
      
      private var _reelNumber:int;
      
      private var _slotMachineIcon:Vector.<SlotMachineIcon>;
      
      public function SlotMachineReel(param1:MovieClip, param2:int)
      {
         var _loc3_:int = 0;
         this._slotMachineIcon = new Vector.<SlotMachineIcon>();
         super();
         this._design = param1;
         this._reelNumber = param2;
         param1.gotoAndStop("Default");
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            this._slotMachineIcon.push(new SlotMachineIcon((param1 as MovieClip).getChildByName("Slot_0" + (param2 * 3 + (_loc3_ + 1))) as MovieClip,_loc3_));
            _loc3_++;
         }
      }
      
      public function get reelNumber() : int
      {
         return this._reelNumber;
      }
      
      public function playReelAnim() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this._design,"Stop"));
         this._design.addFrameScript(_loc1_,this.stopReelAnim);
         var _loc2_:int = int(DCUtils.indexOfLabel(this._design,"Reel_Stop_01"));
         this._design.addFrameScript(_loc2_,this.playStopSound);
         this._design.gotoAndPlay("Rotation");
      }
      
      public function playStopSound() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SoundReference = null;
         if(this._design != null)
         {
            _loc1_ = int(DCUtils.indexOfLabel(this._design,"Reel_Stop_01"));
            this._design.addFrameScript(_loc1_,null);
            _loc2_ = Sounds.getSoundReference("SlotMachineReelStop");
            if(_loc2_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
            }
         }
      }
      
      public function stopReelAnim() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this._design,"Stop"));
         this._design.addFrameScript(_loc1_,null);
         MessageCenter.sendMessage("SlotMachineStopReel",this);
         this._design.gotoAndStop("Stop");
         var _loc2_:SoundReference = Sounds.getSoundReference("SlotMachineSpin");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:int = int(DCUtils.indexOfLabel(this._design,"Stop"));
         this._design.addFrameScript(_loc1_,null);
         this._design = null;
         for each(_loc2_ in this._slotMachineIcon)
         {
            _loc2_.dispose();
         }
         this._slotMachineIcon.splice(0,this._slotMachineIcon.length);
      }
      
      public function getiIcons() : Vector.<SlotMachineIcon>
      {
         return this._slotMachineIcon;
      }
      
      public function getSlotByLine(param1:int) : SlotMachineIcon
      {
         if(param1 < 3)
         {
            return this._slotMachineIcon[param1];
         }
         if(param1 == 3)
         {
            return this._slotMachineIcon[2 - this.reelNumber];
         }
         if(param1 == 4)
         {
            return this._slotMachineIcon[this.reelNumber];
         }
         LogUtils.log("Too many lines",this,3,"SlotMachine");
         return null;
      }
      
      public function flashIcons(param1:int) : void
      {
         this.getSlotByLine(param1).playIconAnim();
      }
   }
}

