package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   
   public class SlotMachineReel
   {
       
      
      private var _design:MovieClip;
      
      private var _reelNumber:int;
      
      private var _slotMachineIcon:Vector.<SlotMachineIcon>;
      
      public function SlotMachineReel(design:MovieClip, reelNumber:int)
      {
         var i:int = 0;
         _slotMachineIcon = new Vector.<SlotMachineIcon>();
         super();
         _design = design;
         _reelNumber = reelNumber;
         design.gotoAndStop("Default");
         for(i = 0; i < 3; )
         {
            _slotMachineIcon.push(new SlotMachineIcon((design as MovieClip).getChildByName("Slot_0" + (reelNumber * 3 + (i + 1))) as MovieClip,i));
            i++;
         }
      }
      
      public function get reelNumber() : int
      {
         return _reelNumber;
      }
      
      public function playReelAnim() : void
      {
         var index:int = DCUtils.indexOfLabel(_design,"Stop");
         _design.addFrameScript(index,stopReelAnim);
         var stopReel1:int = DCUtils.indexOfLabel(_design,"Reel_Stop_01");
         _design.addFrameScript(stopReel1,playStopSound);
         _design.gotoAndPlay("Rotation");
      }
      
      public function playStopSound() : void
      {
         var stopReel1:int = 0;
         var sound:* = null;
         if(_design != null)
         {
            stopReel1 = DCUtils.indexOfLabel(_design,"Reel_Stop_01");
            _design.addFrameScript(stopReel1,null);
            sound = Sounds.getSoundReference("SlotMachineReelStop");
            if(sound)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",sound.getMusicID(),sound.getStart(),sound.getType(),"PlaySound"));
            }
         }
      }
      
      public function stopReelAnim() : void
      {
         var _loc1_:int = DCUtils.indexOfLabel(_design,"Stop");
         _design.addFrameScript(_loc1_,null);
         MessageCenter.sendMessage("SlotMachineStopReel",this);
         _design.gotoAndStop("Stop");
         var sound:SoundReference = Sounds.getSoundReference("SlotMachineSpin");
         if(sound)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",sound.getMusicID(),sound.getStart(),sound.getType(),"PlaySound"));
         }
      }
      
      public function dispose() : void
      {
         var index:int = DCUtils.indexOfLabel(_design,"Stop");
         _design.addFrameScript(index,null);
         _design = null;
         for each(var icon in _slotMachineIcon)
         {
            icon.dispose();
         }
         _slotMachineIcon.splice(0,_slotMachineIcon.length);
      }
      
      public function getiIcons() : Vector.<SlotMachineIcon>
      {
         return _slotMachineIcon;
      }
      
      public function getSlotByLine(linenumber:int) : SlotMachineIcon
      {
         if(linenumber < 3)
         {
            return _slotMachineIcon[linenumber];
         }
         if(linenumber == 3)
         {
            return _slotMachineIcon[2 - reelNumber];
         }
         if(linenumber == 4)
         {
            return _slotMachineIcon[reelNumber];
         }
         LogUtils.log("Too many lines",this,3,"SlotMachine");
         return null;
      }
      
      public function flashIcons(icon:int) : void
      {
         getSlotByLine(icon).playIconAnim();
      }
   }
}
