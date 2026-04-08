package tuxwars.ui.containers.slotitem.uicontainers.container.buttons
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.utils.*;
   
   public class LockButton extends SaleButton
   {
      private var _lockIcon:MovieClip;
      
      private var _lockIconVip:MovieClip;
      
      private var _lockIconOpen:MovieClip;
      
      private var _lockIconLevel:MovieClip;
      
      private var _lockText:UIAutoTextField;
      
      private var _lockIconLeveText:UIAutoTextField;
      
      private var _lockIconOpenLevelText:UIAutoTextField;
      
      public function LockButton(param1:MovieClip, param2:Object = null, param3:Boolean = true, param4:Object = null, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
         if(param1.Icon_Lock)
         {
            this._lockIcon = param1.Icon_Lock;
            if(this._lockIcon.Icon_Lock_Membership)
            {
               this._lockIconVip = this._lockIcon.Icon_Lock_Membership;
            }
            this._lockIconLevel = this._lockIcon.Icon_Lock_Level;
            this._lockIconOpen = this._lockIcon.Icon_Lock_Level_Open;
            if(this._lockIconLevel)
            {
               this._lockIconLeveText = TuxUiUtils.createAutoTextFieldWithText(this._lockIconLevel.Text,"");
            }
            if(this._lockIconOpen)
            {
               this._lockIconOpenLevelText = TuxUiUtils.createAutoTextFieldWithText(this._lockIconOpen.Text,"");
            }
         }
         if(param1.Text_Lock)
         {
            this._lockText = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Lock,"");
            this._lockText.setVisible(false);
         }
         MessageCenter.addListener("UnlockIcon",this.unlockIcon);
         MessageCenter.addListener("LockIcon",this.lockIcon);
      }
      
      private function unlockIcon(param1:Message) : void
      {
         if(Boolean(this._lockIcon) && param1.data == shopItem.id)
         {
            this._lockIconLevel.visible = false;
            if(this._lockIconOpen)
            {
               this._lockIconOpen.visible = true;
            }
         }
      }
      
      private function lockIcon(param1:Message) : void
      {
         if(Boolean(this._lockIcon) && param1.data == shopItem.id)
         {
            this._lockIconLevel.visible = true;
            if(this._lockIconOpen)
            {
               this._lockIconOpen.visible = false;
            }
         }
      }
      
      override public function setSlotElement(param1:SlotElement) : void
      {
         super.setSlotElement(param1);
         if(shopItem.isLevelLocked(slotElement.game.player.level))
         {
            if(this._lockIcon)
            {
               this._lockIcon.visible = true;
               if(this._lockIconVip)
               {
                  this._lockIconVip.visible = shopItem.isVip;
               }
               this._lockIconLevel.visible = !shopItem.isVip;
               if(this._lockIconOpen)
               {
                  this._lockIconOpen.visible = false;
               }
               this._lockIconLeveText.setText(shopItem.requiredLevel.toString());
               if(this._lockIconOpenLevelText)
               {
                  this._lockIconOpenLevelText.setText(shopItem.requiredLevel.toString());
               }
            }
         }
         else if(shopItem.type == "Trophy")
         {
            if(this._lockIcon)
            {
               this._lockIcon.visible = true;
               if(this._lockIconVip)
               {
                  this._lockIconVip.visible = false;
               }
               this._lockIconLevel.visible = true;
               this._lockIconLeveText.setText("-");
               if(this._lockIconOpen)
               {
                  this._lockIconOpen.visible = false;
               }
               if(this._lockIconOpenLevelText)
               {
                  this._lockIconOpenLevelText.setText("-");
               }
            }
         }
      }
      
      override protected function setItemText() : void
      {
         super.setItemText();
         if(this._lockText)
         {
            this._lockText.setTextField(this._design.Text_Lock);
            if(shopItem.isLevelLocked(slotElement.game.player.level))
            {
               if(shopItem.isVip)
               {
                  this._lockText.setText(ProjectManager.getText("Unlock_Vip"));
                  this._lockText.setVisible(false);
               }
               else
               {
                  if(shopItem.unlockPrice <= 0)
                  {
                     this._lockText.setVisible(false);
                     return;
                  }
                  this._lockText.setText(ProjectManager.getText("Unlock"));
                  this._lockText.setVisible(false);
               }
            }
            else
            {
               this._lockText.setText(ProjectManager.getText(""));
               this._lockText.setVisible(false);
            }
         }
      }
      
      override public function dispose() : void
      {
         this._lockIcon = null;
         this._lockText = null;
         MessageCenter.removeListener("UnlockIcon",this.unlockIcon);
         MessageCenter.removeListener("LockIcon",this.lockIcon);
         super.dispose();
      }
   }
}

