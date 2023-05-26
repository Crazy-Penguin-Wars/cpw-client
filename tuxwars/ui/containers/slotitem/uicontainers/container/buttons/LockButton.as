package tuxwars.ui.containers.slotitem.uicontainers.container.buttons
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.utils.TuxUiUtils;
   
   public class LockButton extends SaleButton
   {
       
      
      private var _lockIcon:MovieClip;
      
      private var _lockIconVip:MovieClip;
      
      private var _lockIconOpen:MovieClip;
      
      private var _lockIconLevel:MovieClip;
      
      private var _lockText:UIAutoTextField;
      
      private var _lockIconLeveText:UIAutoTextField;
      
      private var _lockIconOpenLevelText:UIAutoTextField;
      
      public function LockButton(design:MovieClip, parameter:Object = null, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         super(design,parameter,useDefaultSound,sounds,customSoundStatus);
         if(design.Icon_Lock)
         {
            _lockIcon = design.Icon_Lock;
            if(_lockIcon.Icon_Lock_Membership)
            {
               _lockIconVip = _lockIcon.Icon_Lock_Membership;
            }
            _lockIconLevel = _lockIcon.Icon_Lock_Level;
            _lockIconOpen = _lockIcon.Icon_Lock_Level_Open;
            if(_lockIconLevel)
            {
               _lockIconLeveText = TuxUiUtils.createAutoTextFieldWithText(_lockIconLevel.Text,"");
            }
            if(_lockIconOpen)
            {
               _lockIconOpenLevelText = TuxUiUtils.createAutoTextFieldWithText(_lockIconOpen.Text,"");
            }
         }
         if(design.Text_Lock)
         {
            _lockText = TuxUiUtils.createAutoTextFieldWithText(design.Text_Lock,"");
            _lockText.setVisible(false);
         }
         MessageCenter.addListener("UnlockIcon",unlockIcon);
         MessageCenter.addListener("LockIcon",lockIcon);
      }
      
      private function unlockIcon(msg:Message) : void
      {
         if(_lockIcon && msg.data == shopItem.id)
         {
            _lockIconLevel.visible = false;
            if(_lockIconOpen)
            {
               _lockIconOpen.visible = true;
            }
         }
      }
      
      private function lockIcon(msg:Message) : void
      {
         if(_lockIcon && msg.data == shopItem.id)
         {
            _lockIconLevel.visible = true;
            if(_lockIconOpen)
            {
               _lockIconOpen.visible = false;
            }
         }
      }
      
      override public function setSlotElement(sloteElement:SlotElement) : void
      {
         super.setSlotElement(sloteElement);
         if(shopItem.isLevelLocked(slotElement.game.player.level))
         {
            if(_lockIcon)
            {
               _lockIcon.visible = true;
               if(_lockIconVip)
               {
                  _lockIconVip.visible = shopItem.isVip;
               }
               _lockIconLevel.visible = !shopItem.isVip;
               if(_lockIconOpen)
               {
                  _lockIconOpen.visible = false;
               }
               _lockIconLeveText.setText(shopItem.requiredLevel.toString());
               if(_lockIconOpenLevelText)
               {
                  _lockIconOpenLevelText.setText(shopItem.requiredLevel.toString());
               }
            }
         }
         else if(shopItem.type == "Trophy")
         {
            if(_lockIcon)
            {
               _lockIcon.visible = true;
               if(_lockIconVip)
               {
                  _lockIconVip.visible = false;
               }
               _lockIconLevel.visible = true;
               _lockIconLeveText.setText("-");
               if(_lockIconOpen)
               {
                  _lockIconOpen.visible = false;
               }
               if(_lockIconOpenLevelText)
               {
                  _lockIconOpenLevelText.setText("-");
               }
            }
         }
      }
      
      override protected function setItemText() : void
      {
         super.setItemText();
         if(_lockText)
         {
            _lockText.setTextField(this._design.Text_Lock);
            if(shopItem.isLevelLocked(slotElement.game.player.level))
            {
               if(shopItem.isVip)
               {
                  _lockText.setText(ProjectManager.getText("Unlock_Vip"));
                  _lockText.setVisible(false);
               }
               else
               {
                  if(shopItem.unlockPrice <= 0)
                  {
                     _lockText.setVisible(false);
                     return;
                  }
                  _lockText.setText(ProjectManager.getText("Unlock"));
                  _lockText.setVisible(false);
               }
            }
            else
            {
               _lockText.setText(ProjectManager.getText(""));
               _lockText.setVisible(false);
            }
         }
      }
      
      override public function dispose() : void
      {
         _lockIcon = null;
         _lockText = null;
         MessageCenter.removeListener("UnlockIcon",unlockIcon);
         MessageCenter.removeListener("LockIcon",lockIcon);
         super.dispose();
      }
   }
}
