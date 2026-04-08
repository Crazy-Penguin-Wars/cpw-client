package com.dchoc.ui.windows
{
   import com.dchoc.utils.*;
   import flash.events.Event;
   
   public class UIContainers
   {
      private const containers:Object = {};
      
      private var currentContainerId:String;
      
      private var previousContainerId:String;
      
      private var _isLoop:Boolean;
      
      public function UIContainers()
      {
         super();
      }
      
      public function add(param1:String, param2:UIContainer) : void
      {
         this.containers[param1] = param2;
         param2.setShowTransitions(false);
         param2.setVisible(false);
         param2.setShowTransitions(true);
         this._isLoop = false;
      }
      
      public function show(param1:String, param2:Boolean = true, param3:Boolean = false) : void
      {
         var _loc4_:UIContainer = null;
         var _loc5_:Boolean = false;
         var _loc6_:UIContainer = this.containers[param1];
         if(param2)
         {
            if(!_loc6_.getVisible())
            {
               if(this.currentContainerId != null)
               {
                  _loc4_ = this.containers[this.currentContainerId];
                  _loc4_.addEventListener("transition_end",this.hideAnimEnded);
                  _loc4_.setVisible(false);
                  this.previousContainerId = this.currentContainerId;
                  this._isLoop = true;
               }
               else
               {
                  _loc6_.setVisible(true);
               }
               this.currentContainerId = param1;
            }
            else if(param3)
            {
               _loc6_.setVisible(false);
               this._isLoop = true;
            }
         }
         else
         {
            if(this.currentContainerId != null)
            {
               _loc5_ = Boolean((this.containers[this.currentContainerId] as UIContainer).getShowTransitions());
               (this.containers[this.currentContainerId] as UIContainer).setShowTransitions(false);
               (this.containers[this.currentContainerId] as UIContainer).setVisible(false);
               (this.containers[this.currentContainerId] as UIContainer).setShowTransitions(_loc5_);
            }
            _loc5_ = _loc6_.getShowTransitions();
            _loc6_.setShowTransitions(false);
            _loc6_.setVisible(true);
            _loc6_.setShowTransitions(_loc5_);
            this.currentContainerId = param1;
         }
         (this.containers[this.currentContainerId] as UIContainer).shown();
      }
      
      private function hideAnimEnded(param1:Event) : void
      {
         (this.containers[this.previousContainerId] as UIContainer).removeEventListener("transition_end",this.hideAnimEnded);
         (this.containers[this.currentContainerId] as UIContainer).setVisible(true);
         this._isLoop = false;
      }
      
      public function isLoop() : Boolean
      {
         return this._isLoop;
      }
      
      public function getContainer(param1:String) : UIContainer
      {
         return this.containers[param1];
      }
      
      public function getCurrentContainer() : UIContainer
      {
         return this.getContainer(this.currentContainerId);
      }
      
      public function getCurrentContainerId() : String
      {
         return this.currentContainerId;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.getContainers())
         {
            if(_loc2_ == this.getCurrentContainer())
            {
               _loc2_.setVisible(param1);
            }
            else
            {
               _loc2_.setVisible(!param1);
            }
         }
      }
      
      public function setAllVisible(param1:Boolean) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.containers)
         {
            _loc2_.setVisible(param1);
         }
      }
      
      public function getContainers() : Object
      {
         return this.containers;
      }
      
      public function dispose() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:UIContainer = null;
         if(this.previousContainerId != null)
         {
            _loc1_ = this.containers[this.previousContainerId];
            if(_loc1_)
            {
               _loc1_.removeEventListener("transition_end",this.hideAnimEnded);
            }
         }
         for each(_loc2_ in this.containers)
         {
            _loc2_.dispose();
         }
         DCUtils.deleteProperties(this.containers);
      }
   }
}

