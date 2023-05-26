package tuxwars.ui.components
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.home.ui.logic.inbox.InboxManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class InboxButton extends UIButton
   {
       
      
      private var counter:UIAutoTextField;
      
      private var animatedInbox:MovieClip;
      
      private var idleInbox:MovieClip;
      
      public function InboxButton(design:MovieClip, parameter:Object = null, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         super(design,parameter,useDefaultSound,sounds,customSoundStatus);
         counter = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Number") as TextField,InboxManager.messageCount.toString());
         idleInbox = (design as MovieClip).getChildByName("Inbox_Idle") as MovieClip;
         animatedInbox = (design as MovieClip).getChildByName("Inbox_Animated") as MovieClip;
         testForAnimation();
         MessageCenter.addListener("InboxUpdateCounter",updateCounter);
      }
      
      private function updateCounter(msg:Message) : void
      {
         counter.setText(InboxManager.messageCount.toString());
         testForAnimation();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("InboxUpdateCounter",updateCounter);
         super.dispose();
      }
      
      private function testForAnimation() : void
      {
         if(InboxManager.messageCount > 0)
         {
            animatedInbox.visible = true;
            idleInbox.visible = false;
            animatedInbox.play();
         }
         else
         {
            animatedInbox.visible = false;
            idleInbox.visible = true;
            animatedInbox.stop();
         }
      }
   }
}
