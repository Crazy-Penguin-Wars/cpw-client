package tuxwars.ui.components
{
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.buttons.UIToggleButton;
   import com.dchoc.ui.groups.UIRadialGroup;
   import com.dchoc.ui.transitions.UITransition;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import no.olog.utilfunctions.assert;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.ui.containers.shopitem.ButtonContainers;
   import tuxwars.utils.TuxUiUtils;
   
   public class ObjectContainer extends TuxUIElementScreen
   {
      
      public static const TRANSITION_SLOTS_LEFT:String = "transition_slots_left";
      
      public static const TRANSITION_SLOTS_RIGHT:String = "transition_slots_right";
      
      public static const TRANSITION_CHARSHOP_LEFT:String = "transition_charshop_left";
      
      public static const TRANSITION_CHARSHOP_RIGHT:String = "transition_charshop_right";
      
      public static const TRANSITION_LOOT_LEFT:String = "transition_loot_left";
      
      public static const TRANSITION_LOOT_RIGHT:String = "transition_loot_right";
      
      public static const TRANSITION_MAPS_LEFT:String = "transition_maps_left";
      
      public static const TRANSITION_MAPS_RIGHT:String = "transition_maps_right";
      
      public static const TRANSITION_CHALLENGES_UP:String = "transition_challenges_down";
      
      public static const TRANSITION_CHALLENGES_DOWN:String = "transition_challenges_up";
      
      private static const SLOT:String = "Slot_";
      
      private static const CONTAINER:String = "Container_";
      
      private static const CONTAINER_SLOTS:String = "Container_Slots";
      
      private static const BUTTON_SCROLL_LEFT:String = "Button_Scroll_Left";
      
      private static const BUTTON_SCROLL_RIGHT:String = "Button_Scroll_Right";
       
      
      private const containerForObjects:Array = [];
      
      private const _radialGroup:UIRadialGroup = new UIRadialGroup();
      
      private var getSlotContentObject:Function;
      
      private var _curPage:int;
      
      private var numPages:int;
      
      private var objectsPerPage:int;
      
      private var containerType:String;
      
      private var slotObjects;
      
      private var container:MovieClip;
      
      private var scrollLeftButton:UIButton;
      
      private var scrollRightButton:UIButton;
      
      private var radial:Boolean;
      
      private var _transitionNameLeft:String;
      
      private var _transitionNameRight:String;
      
      private var _transitionBefore:UITransition;
      
      private var _transitionAfter:UITransition;
      
      public function ObjectContainer(design:MovieClip, game:TuxWarsGame, getSlotContentObject:Function, transitionNameLeft:String, transitionNameRight:String, radial:Boolean = true)
      {
         super(design,game);
         _transitionNameLeft = transitionNameLeft;
         _transitionNameRight = transitionNameRight;
         this.getSlotContentObject = getSlotContentObject;
         this.radial = radial;
         container = getDesignMovieClip().getChildByName("Container_Slots") as MovieClip;
         if(container)
         {
            objectsPerPage = countObjects("Slot_");
            containerType = "Slot_";
            if(objectsPerPage <= 0)
            {
               objectsPerPage = countObjects("Container_");
               containerType = "Container_";
            }
            if(getDesignMovieClip().Button_Scroll_Left)
            {
               scrollLeftButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Scroll_Left",scrollLeftButtonHandler);
            }
            if(getDesignMovieClip().Button_Scroll_Right)
            {
               scrollRightButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Scroll_Right",scrollRightButtonHandler);
            }
         }
      }
      
      private function countObjects(name:String) : int
      {
         var i:int = 0;
         var _loc2_:* = null;
         var count:int = 0;
         for(i = 0; i < container.numChildren; )
         {
            _loc2_ = container.getChildAt(i);
            if(_loc2_ != null && _loc2_.name.indexOf(name) != -1)
            {
               count++;
            }
            i++;
         }
         return count;
      }
      
      public function init(slotObjects:*, useCurrentPage:Boolean = true, initialSlotIndexThatMustBeShown:int = -1, initialPageToShow:int = -1) : void
      {
         assert("Will cause divide / zero",true,objectsPerPage > 0);
         var _loc5_:int = numPages;
         numPages = Math.ceil(Number(slotObjects.length) / objectsPerPage);
         var currentPageToShow:* = -1;
         if(numPages > initialPageToShow)
         {
            currentPageToShow = initialPageToShow;
         }
         if(initialSlotIndexThatMustBeShown != -1)
         {
            currentPageToShow = initialSlotIndexThatMustBeShown / objectsPerPage;
         }
         if(currentPageToShow >= 0)
         {
            _curPage = currentPageToShow;
         }
         else if(!useCurrentPage || _loc5_ > numPages)
         {
            _curPage = 0;
         }
         this.slotObjects = slotObjects;
         showPage(_curPage);
         if(scrollRightButton)
         {
            scrollRightButton.setEnabled(_curPage < numPages - 1 && numPages > 1);
            scrollLeftButton.setEnabled(_curPage > 0);
         }
      }
      
      override public function dispose() : void
      {
         removeSlotObjects();
         getSlotContentObject = null;
         slotObjects = null;
         container = null;
         if(scrollLeftButton)
         {
            scrollLeftButton.dispose();
            scrollLeftButton = null;
         }
         if(scrollRightButton)
         {
            scrollRightButton.dispose();
            scrollRightButton = null;
         }
         super.dispose();
      }
      
      public function get objects() : Array
      {
         return containerForObjects;
      }
      
      public function get radialGroup() : UIRadialGroup
      {
         return _radialGroup;
      }
      
      public function isRadial() : Boolean
      {
         return radial;
      }
      
      public function getSelectedButton() : UIButton
      {
         if(radial)
         {
            return _radialGroup.getSelectedButton();
         }
         return null;
      }
      
      public function getCurrentIndex() : int
      {
         if(radial)
         {
            return _curPage * objectsPerPage + _radialGroup.getSelectedIndex();
         }
         return 0;
      }
      
      public function getSelectedObject() : *
      {
         return getSlotObject(getCurrentIndex());
      }
      
      public function getSlotObject(slotIndex:int) : *
      {
         return slotObjects[slotIndex];
      }
      
      public function getContainerForObjects() : Array
      {
         return containerForObjects;
      }
      
      public function showObjectAtIndex(index:int) : void
      {
         var _loc2_:int = 0;
         _curPage = index / objectsPerPage;
         showPage(_curPage);
         if(scrollRightButton)
         {
            scrollRightButton.setEnabled(_curPage < numPages - 1 && numPages > 1);
         }
         if(scrollLeftButton)
         {
            scrollLeftButton.setEnabled(_curPage > 0);
         }
         if(radial)
         {
            _loc2_ = index - _curPage * objectsPerPage;
            _radialGroup.setSelectedIndex(_loc2_);
         }
      }
      
      private function hideAllButtons() : void
      {
         var i:int = 0;
         for(i = 1; i <= objectsPerPage; )
         {
            if(containerType == "Slot_")
            {
               container.getChildByName("Slot_" + getIndexString(i)).visible = false;
            }
            else if(containerType == "Container_")
            {
               container.getChildByName("Container_" + getIndexString(i)).visible = false;
            }
            i++;
         }
      }
      
      private function getIndexString(index:int) : String
      {
         return index < 10 ? "0" + index : index.toString();
      }
      
      private function showPage(index:int) : void
      {
         removeSlotObjects();
         hideAllButtons();
         var _loc2_:* = getObjectsOnPage(index);
         var i:int = 0;
         for each(var object in _loc2_)
         {
            addObject(i,object);
            i++;
         }
      }
      
      private function addObject(slotIndex:int, object:*) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = getSlotContentObject(slotIndex,object,container.getChildByName((containerType == "Slot_" ? "Slot_" : "Container_") + getIndexString(slotIndex + 1)));
         if(_loc3_ != null)
         {
            _loc3_.setVisible(true);
            containerForObjects.push(_loc3_);
            if(radial)
            {
               if(_loc3_ is UIToggleButton)
               {
                  _radialGroup.add(_loc3_);
               }
               if(_loc3_ is ButtonContainers)
               {
                  _loc4_ = ButtonContainers(_loc3_);
                  if(!ButtonContainers(_loc3_).isLocked)
                  {
                     _radialGroup.add(_loc4_.currentButtonContainer.button as UIToggleButton);
                  }
               }
            }
         }
      }
      
      private function getObjectsOnPage(index:int) : *
      {
         var _loc3_:int = index * objectsPerPage;
         var _loc2_:int = Number(slotObjects.length) - _loc3_;
         var _loc4_:int = _loc3_ + (_loc2_ < objectsPerPage ? _loc2_ : objectsPerPage);
         return slotObjects.slice(_loc3_,_loc4_);
      }
      
      private function removeSlotObjects() : void
      {
         if(radial)
         {
            _radialGroup.dispose();
         }
         for each(var object in containerForObjects)
         {
            if(object != null && object.hasOwnProperty("dispose"))
            {
               if(!(object.hasOwnProperty("disposed") && object.disposed))
               {
                  object.dispose();
                  object = null;
               }
            }
         }
         containerForObjects.splice(0,containerForObjects.length);
      }
      
      private function scrollRightButtonHandler(event:MouseEvent) : void
      {
         if(_curPage + 1 < numPages)
         {
            if(_transitionBefore == null || _transitionAfter == null || !_transitionBefore.isTransitioning() && !_transitionAfter.isTransitioning())
            {
               _curPage++;
               if(_transitionNameRight)
               {
                  transitionBeforeEnded(null);
                  _transitionBefore = TuxUiUtils.createTransition(_transitionBefore,container,_transitionNameRight + "_close",transitionBeforeEnded);
               }
               showPage(_curPage);
               if(_transitionNameRight)
               {
                  transitionAfterEnded(null);
                  _transitionAfter = TuxUiUtils.createTransition(_transitionAfter,container,_transitionNameRight + "_open",transitionAfterEnded);
               }
               if(_curPage == numPages - 1)
               {
                  scrollRightButton.setEnabled(false);
               }
               if(!scrollLeftButton.getEnabled())
               {
                  scrollLeftButton.setEnabled(true);
               }
            }
         }
      }
      
      private function scrollLeftButtonHandler(event:MouseEvent) : void
      {
         if(_curPage - 1 >= 0)
         {
            if(_transitionBefore == null || _transitionAfter == null || !_transitionBefore.isTransitioning() && !_transitionAfter.isTransitioning())
            {
               _curPage--;
               if(_transitionNameLeft)
               {
                  transitionBeforeEnded(null);
                  _transitionBefore = TuxUiUtils.createTransition(_transitionBefore,container,_transitionNameLeft + "_close",transitionBeforeEnded);
               }
               showPage(_curPage);
               if(_transitionNameLeft)
               {
                  transitionAfterEnded(null);
                  _transitionAfter = TuxUiUtils.createTransition(_transitionAfter,container,_transitionNameLeft + "_open",transitionAfterEnded);
               }
               if(_curPage == 0)
               {
                  scrollLeftButton.setEnabled(false);
               }
               if(!scrollRightButton.getEnabled())
               {
                  scrollRightButton.setEnabled(true);
               }
            }
         }
      }
      
      private function transitionBeforeEnded(event:Event) : void
      {
         if(_transitionBefore)
         {
            _transitionBefore.dispose(true);
            _transitionBefore = null;
         }
         container.removeEventListener("transition_end",transitionBeforeEnded);
      }
      
      private function transitionAfterEnded(event:Event) : void
      {
         if(_transitionAfter)
         {
            _transitionAfter.dispose(true);
            _transitionAfter = null;
         }
         container.removeEventListener("transition_end",transitionAfterEnded);
      }
      
      public function get curPage() : int
      {
         return _curPage;
      }
   }
}
