package tuxwars.home.states.slotmachine
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import tuxwars.data.*;
   import tuxwars.states.TuxState;
   
   public class SlotMachineState extends TuxState
   {
      public function SlotMachineState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new SlotMachineLoadAssetsSubState(tuxGame));
      }
      
      override public function exit() : void
      {
         super.exit();
         var _loc1_:SoundReference = Sounds.getSoundReference("SlotMachineSpinLight");
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            _loc1_ = Sounds.getSoundReference("SlotMachineSpinLightAfter");
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            _loc1_ = Sounds.getSoundReference("SlotMachineStart");
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            _loc1_ = Sounds.getSoundReference("SlotMachineReelStop");
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            _loc1_ = Sounds.getSoundReference("SlotMachineSpin");
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            _loc1_ = Sounds.getSoundReference("SlotMachineInsertCoin");
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            _loc1_ = Sounds.getSoundReference("SlotMachineWin");
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            _loc1_ = Sounds.getSoundReference("SlotMachineNoWin");
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
         }
      }
   }
}

