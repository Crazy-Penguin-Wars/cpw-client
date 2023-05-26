package com.dchoc.ui.windows
{
   import com.dchoc.utils.DCUtils;
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
      
      public function add(id:String, container:UIContainer) : void
      {
         containers[id] = container;
         container.setShowTransitions(false);
         container.setVisible(false);
         container.setShowTransitions(true);
         _isLoop = false;
      }
      
      public function show(id:String, useTransitioning:Boolean = true, useLoop:Boolean = false) : void
      {
         var _loc6_:* = null;
         var oldUseTransitions:Boolean = false;
         var _loc5_:UIContainer = containers[id];
         if(useTransitioning)
         {
            if(!_loc5_.getVisible())
            {
               if(currentContainerId != null)
               {
                  _loc6_ = containers[currentContainerId];
                  _loc6_.addEventListener("transition_end",hideAnimEnded);
                  _loc6_.setVisible(false);
                  previousContainerId = currentContainerId;
                  _isLoop = true;
               }
               else
               {
                  _loc5_.setVisible(true);
               }
               currentContainerId = id;
            }
            else if(useLoop)
            {
               _loc5_.setVisible(false);
               _isLoop = true;
            }
         }
         else
         {
            if(currentContainerId != null)
            {
               oldUseTransitions = (containers[currentContainerId] as UIContainer).getShowTransitions();
               (containers[currentContainerId] as UIContainer).setShowTransitions(false);
               (containers[currentContainerId] as UIContainer).setVisible(false);
               (containers[currentContainerId] as UIContainer).setShowTransitions(oldUseTransitions);
            }
            oldUseTransitions = _loc5_.getShowTransitions();
            _loc5_.setShowTransitions(false);
            _loc5_.setVisible(true);
            _loc5_.setShowTransitions(oldUseTransitions);
            currentContainerId = id;
         }
         (containers[currentContainerId] as UIContainer).shown();
      }
      
      private function hideAnimEnded(event:Event) : void
      {
         (containers[previousContainerId] as UIContainer).removeEventListener("transition_end",hideAnimEnded);
         (containers[currentContainerId] as UIContainer).setVisible(true);
         _isLoop = false;
      }
      
      public function isLoop() : Boolean
      {
         return _isLoop;
      }
      
      public function getContainer(id:String) : UIContainer
      {
         return containers[id];
      }
      
      public function getCurrentContainer() : UIContainer
      {
         return getContainer(currentContainerId);
      }
      
      public function getCurrentContainerId() : String
      {
         return currentContainerId;
      }
      
      public function setVisible(isVisible:Boolean) : void
      {
         for each(var container in getContainers())
         {
            if(container == getCurrentContainer())
            {
               container.setVisible(isVisible);
            }
            else
            {
               container.setVisible(!isVisible);
            }
         }
      }
      
      public function setAllVisible(isVisible:Boolean) : void
      {
         for each(var container in containers)
         {
            container.setVisible(isVisible);
         }
      }
      
      public function getContainers() : Object
      {
         return containers;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(previousContainerId != null)
         {
            _loc1_ = containers[previousContainerId];
            if(_loc1_)
            {
               _loc1_.removeEventListener("transition_end",hideAnimEnded);
            }
         }
         for each(var container in containers)
         {
            container.dispose();
         }
         DCUtils.deleteProperties(containers);
      }
   }
}
