package tuxwars.ui.popups.logic.crm
{
   import com.dchoc.utils.*;
   import tuxwars.net.*;
   
   public class CRMPopUpData
   {
      private var _title:String;
      
      private var _description:String;
      
      private var _imageURL:String;
      
      private var _actionCode:String;
      
      private var _actionLabel:String;
      
      private var _actionParameters:Array;
      
      private var _actionEventTracking:Array;
      
      public function CRMPopUpData(param1:String, param2:String, param3:String, param4:Object)
      {
         super();
         this._title = param1;
         this._description = param2;
         this._imageURL = param3;
         this.parseActionButtonObject(param4);
      }
      
      private function parseActionButtonObject(param1:Object) : void
      {
         if(param1)
         {
            this._actionCode = param1.action;
            this._actionLabel = param1.label;
            this._actionParameters = param1.params is Array ? param1.params : [param1.params];
            this._actionEventTracking = param1.tracking is Array ? param1.tracking : [param1.tracking];
         }
         else
         {
            LogUtils.log("No action button in crmPopup: " + this.toString(),this,0,"CRMDataPopup",false,false,false);
         }
      }
      
      public function sendCRMEventTracking(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         if(param1)
         {
            for each(_loc2_ in this._actionEventTracking)
            {
               if(Boolean(_loc2_.event as String) && (_loc2_.event as String).toLowerCase() == param1.toLowerCase())
               {
                  CRMService.sendEvent(_loc2_.group,_loc2_.type,_loc2_.label,_loc2_.product);
                  return true;
               }
            }
         }
         LogUtils.log("No action tracking found for event: " + param1 + " crmPopup: " + this.toString(),this,2,"CRMDataPopup",false,false,false);
         return false;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function get imageURL() : String
      {
         return this._imageURL;
      }
      
      private function toString() : String
      {
         return "title: " + this.title + ", description: " + this.description + ", image: " + this.imageURL;
      }
      
      public function get actionCode() : String
      {
         return this._actionCode;
      }
      
      public function get actionLabel() : String
      {
         return this._actionLabel;
      }
      
      public function get actionParameters() : Array
      {
         return this._actionParameters;
      }
      
      public function getActionParameterValue(param1:String) : *
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._actionParameters)
         {
            if(_loc2_.hasOwnProperty(param1))
            {
               return _loc2_[param1];
            }
         }
         return null;
      }
   }
}

