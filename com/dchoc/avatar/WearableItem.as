package com.dchoc.avatar
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.DisplayObject;
   
   public class WearableItem
   {
       
      
      protected var data:Object;
      
      private var _displayObject:DisplayObject;
      
      public function WearableItem(data:Object)
      {
         super();
         this.data = data;
         if(swf && export && !DCResourceManager.instance.isLoaded(swf))
         {
            DCResourceManager.instance.load(Config.getDataDir() + swf,swf,null,false);
            DCResourceManager.instance.addCustomEventListener("complete",displayObjectLoaded,swf);
         }
      }
      
      public function dispose() : void
      {
         data = null;
         _displayObject = null;
      }
      
      public function get wearableSlot() : int
      {
         return data.wearableSlot;
      }
      
      public function get swf() : String
      {
         return data.swf;
      }
      
      public function get export() : String
      {
         return data.export;
      }
      
      public function get id() : String
      {
         return !!data ? data.id : null;
      }
      
      public function get name() : String
      {
         return !!data ? data.name : "Disposed";
      }
      
      public function isDisplayObjectLoaded() : Boolean
      {
         return DCResourceManager.instance.isLoaded(swf);
      }
      
      public function get displayObject() : DisplayObject
      {
         if(!_displayObject && isDisplayObjectLoaded() && export)
         {
            _displayObject = DCResourceManager.instance.getFromSWF(swf,export);
         }
         return _displayObject;
      }
      
      protected function displayObjectLoaded(event:DCLoadingEvent) : void
      {
         DCResourceManager.instance.removeCustomEventListener("complete",displayObjectLoaded,swf);
      }
   }
}
