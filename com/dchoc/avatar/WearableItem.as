package com.dchoc.avatar
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.resources.*;
   import flash.display.DisplayObject;
   
   public class WearableItem
   {
      protected var data:Object;
      
      private var _displayObject:DisplayObject;
      
      public function WearableItem(param1:Object)
      {
         super();
         this.data = param1;
         if(Boolean(this.swf) && Boolean(this.export) && !DCResourceManager.instance.isLoaded(this.swf))
         {
            DCResourceManager.instance.load(Config.getDataDir() + this.swf,this.swf,null,false);
            DCResourceManager.instance.addCustomEventListener("complete",this.displayObjectLoaded,this.swf);
         }
      }
      
      public function dispose() : void
      {
         this.data = null;
         this._displayObject = null;
      }
      
      public function get wearableSlot() : int
      {
         return this.data.wearableSlot;
      }
      
      public function get swf() : String
      {
         return this.data.swf;
      }
      
      public function get export() : String
      {
         return this.data.export;
      }
      
      public function get id() : String
      {
         return !!this.data ? this.data.id : null;
      }
      
      public function get name() : String
      {
         return !!this.data ? this.data.name : "Disposed";
      }
      
      public function isDisplayObjectLoaded() : Boolean
      {
         return DCResourceManager.instance.isLoaded(this.swf);
      }
      
      public function get displayObject() : DisplayObject
      {
         if(!this._displayObject && this.isDisplayObjectLoaded() && Boolean(this.export))
         {
            this._displayObject = DCResourceManager.instance.getFromSWF(this.swf,this.export);
         }
         return this._displayObject;
      }
      
      protected function displayObjectLoaded(param1:DCLoadingEvent) : void
      {
         DCResourceManager.instance.removeCustomEventListener("complete",this.displayObjectLoaded,this.swf);
      }
   }
}

