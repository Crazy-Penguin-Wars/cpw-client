package tuxwars.ui.popups.screen.error
{
   import com.dchoc.projectdata.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.net.*;
   import tuxwars.ui.popups.logic.error.*;
   import tuxwars.ui.popups.screen.PopUpBaseImageScreen;
   
   public class ErrorPopUpScreen extends PopUpBaseImageScreen
   {
      public function ErrorPopUpScreen(param1:TuxWarsGame)
      {
         super(param1,"flash/ui/popups.swf","popup_message");
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         if(param1)
         {
            if(param1.popupDataID)
            {
               headerField.setText(PopUpData.getTitle(param1.popupDataID));
               messageField.setText(PopUpData.getDescription(param1.popupDataID));
            }
            else
            {
               if(param1.code)
               {
                  messageField.setText(param1.code + "\n" + param1.description);
               }
               else
               {
                  messageField.setText(param1.description);
               }
               if(param1.title)
               {
                  headerField.setText(param1.title);
               }
               else
               {
                  headerField.setText(ProjectManager.getText(this.errorLogic.header));
               }
            }
            CRMService.sendEvent("Game Error","Client",param1.code,!!param1.product ? param1.product : "Unspecified",param1.productDetail);
         }
         else
         {
            headerField.setText(ProjectManager.getText(this.errorLogic.header));
            CRMService.sendEvent("Game Error","Client","Unspecified","Unspecified");
         }
      }
      
      override public function get popupDataID() : String
      {
         if(params && Boolean(params.popupDataID))
         {
            return params.popupDataID;
         }
         return null;
      }
      
      private function get errorLogic() : ErrorPopUpLogic
      {
         return logic as ErrorPopUpLogic;
      }
      
      override public function getResourceUrl() : String
      {
         if(params && Boolean(params.popupDataID))
         {
            return PopUpData.getPicture(params.popupDataID);
         }
         return this.errorLogic.picture;
      }
   }
}

