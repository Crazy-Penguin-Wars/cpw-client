package tuxwars.home.states.slotmachine
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.states.TuxState;
   
   public class SlotMachineState extends TuxState
   {
       
      
      public function SlotMachineState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new SlotMachineLoadAssetsSubState(tuxGame));
      }
      
      override public function exit() : void
      {
         super.exit();
         var soundref:SoundReference = Sounds.getSoundReference("SlotMachineSpinLight");
         if(soundref)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",soundref.getMusicID(),soundref.getStart(),soundref.getType(),"PlaySound"));
            soundref = Sounds.getSoundReference("SlotMachineSpinLightAfter");
            MessageCenter.sendEvent(new SoundMessage("StopSound",soundref.getMusicID(),soundref.getStart(),soundref.getType(),"PlaySound"));
            soundref = Sounds.getSoundReference("SlotMachineStart");
            MessageCenter.sendEvent(new SoundMessage("StopSound",soundref.getMusicID(),soundref.getStart(),soundref.getType(),"PlaySound"));
            soundref = Sounds.getSoundReference("SlotMachineReelStop");
            MessageCenter.sendEvent(new SoundMessage("StopSound",soundref.getMusicID(),soundref.getStart(),soundref.getType(),"PlaySound"));
            soundref = Sounds.getSoundReference("SlotMachineSpin");
            MessageCenter.sendEvent(new SoundMessage("StopSound",soundref.getMusicID(),soundref.getStart(),soundref.getType(),"PlaySound"));
            soundref = Sounds.getSoundReference("SlotMachineInsertCoin");
            MessageCenter.sendEvent(new SoundMessage("StopSound",soundref.getMusicID(),soundref.getStart(),soundref.getType(),"PlaySound"));
            soundref = Sounds.getSoundReference("SlotMachineWin");
            MessageCenter.sendEvent(new SoundMessage("StopSound",soundref.getMusicID(),soundref.getStart(),soundref.getType(),"PlaySound"));
            soundref = Sounds.getSoundReference("SlotMachineNoWin");
            MessageCenter.sendEvent(new SoundMessage("StopSound",soundref.getMusicID(),soundref.getStart(),soundref.getType(),"PlaySound"));
         }
      }
   }
}
