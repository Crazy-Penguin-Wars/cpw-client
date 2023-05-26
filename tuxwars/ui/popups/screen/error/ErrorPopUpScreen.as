package tuxwars.ui.popups.screen.error
{
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PopUpData;
   import tuxwars.net.CRMService;
   import tuxwars.ui.popups.logic.error.ErrorPopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseImageScreen;
   
   public class ErrorPopUpScreen extends PopUpBaseImageScreen
   {
       
      
      public function ErrorPopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_message");
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         if(params)
         {
            if(params.popupDataID)
            {
               headerField.setText(PopUpData.getTitle(params.popupDataID));
               messageField.setText(PopUpData.getDescription(params.popupDataID));
            }
            else
            {
               if(params.code)
               {
                  messageField.setText(params.code + "\n" + params.description);
               }
               else
               {
                  messageField.setText(params.description);
               }
               if(params.title)
               {
                  headerField.setText(params.title);
               }
               else
               {
                  headerField.setText(ProjectManager.getText(errorLogic.header));
               }
            }
            CRMService.sendEvent("Game Error","Client",params.code,!!params.product ? params.product : "Unspecified",params.productDetail);
         }
         else
         {
            headerField.setText(ProjectManager.getText(errorLogic.header));
            CRMService.sendEvent("Game Error","Client","Unspecified","Unspecified");
         }
      }
      
      override public function get popupDataID() : String
      {
         if(params && params.popupDataID)
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
         if(params && params.popupDataID)
         {
            return PopUpData.getPicture(params.popupDataID);
         }
         return errorLogic.picture;
      }
   }
}
