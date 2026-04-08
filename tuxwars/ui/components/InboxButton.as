package tuxwars.ui.components
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.home.ui.logic.inbox.*;
   import tuxwars.utils.*;
   
   public class InboxButton extends UIButton
   {
      private var counter:UIAutoTextField;
      
      private var animatedInbox:MovieClip;
      
      private var idleInbox:MovieClip;
      
      public function InboxButton(param1:MovieClip, param2:Object = null, param3:Boolean = true, param4:Object = null, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
         this.counter = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Number") as TextField,InboxManager.messageCount.toString());
         this.idleInbox = (param1 as MovieClip).getChildByName("Inbox_Idle") as MovieClip;
         this.animatedInbox = (param1 as MovieClip).getChildByName("Inbox_Animated") as MovieClip;
         this.testForAnimation();
         MessageCenter.addListener("InboxUpdateCounter",this.updateCounter);
      }
      
      private function updateCounter(param1:Message) : void
      {
         this.counter.setText(InboxManager.messageCount.toString());
         this.testForAnimation();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("InboxUpdateCounter",this.updateCounter);
         super.dispose();
      }
      
      private function testForAnimation() : void
      {
         if(InboxManager.messageCount > 0)
         {
            this.animatedInbox.visible = true;
            this.idleInbox.visible = false;
            this.animatedInbox.play();
         }
         else
         {
            this.animatedInbox.visible = false;
            this.idleInbox.visible = true;
            this.animatedInbox.stop();
         }
      }
   }
}

