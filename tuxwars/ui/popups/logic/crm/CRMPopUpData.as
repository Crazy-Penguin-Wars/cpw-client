package tuxwars.ui.popups.logic.crm
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.net.CRMService;
   
   public class CRMPopUpData
   {
       
      
      private var _title:String;
      
      private var _description:String;
      
      private var _imageURL:String;
      
      private var _actionCode:String;
      
      private var _actionLabel:String;
      
      private var _actionParameters:Array;
      
      private var _actionEventTracking:Array;
      
      public function CRMPopUpData(title:String, description:String, imageURL:String, actionButton:Object)
      {
         super();
         _title = title;
         _description = description;
         _imageURL = imageURL;
         parseActionButtonObject(actionButton);
      }
      
      private function parseActionButtonObject(actionButton:Object) : void
      {
         if(actionButton)
         {
            _actionCode = actionButton.action;
            _actionLabel = actionButton.label;
            _actionParameters = actionButton.params is Array ? actionButton.params : [actionButton.params];
            _actionEventTracking = actionButton.tracking is Array ? actionButton.tracking : [actionButton.tracking];
         }
         else
         {
            LogUtils.log("No action button in crmPopup: " + toString(),this,0,"CRMDataPopup",false,false,false);
         }
      }
      
      public function sendCRMEventTracking(eventID:String) : Boolean
      {
         if(eventID)
         {
            for each(var obj in _actionEventTracking)
            {
               if(obj.event as String && (obj.event as String).toLowerCase() == eventID.toLowerCase())
               {
                  CRMService.sendEvent(obj.group,obj.type,obj.label,obj.product);
                  return true;
               }
            }
         }
         LogUtils.log("No action tracking found for event: " + eventID + " crmPopup: " + toString(),this,2,"CRMDataPopup",false,false,false);
         return false;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get imageURL() : String
      {
         return _imageURL;
      }
      
      private function toString() : String
      {
         return "title: " + title + ", description: " + description + ", image: " + imageURL;
      }
      
      public function get actionCode() : String
      {
         return _actionCode;
      }
      
      public function get actionLabel() : String
      {
         return _actionLabel;
      }
      
      public function get actionParameters() : Array
      {
         return _actionParameters;
      }
      
      public function getActionParameterValue(param:String) : *
      {
         for each(var action in _actionParameters)
         {
            if(action.hasOwnProperty(param))
            {
               return action[param];
            }
         }
         return null;
      }
   }
}
