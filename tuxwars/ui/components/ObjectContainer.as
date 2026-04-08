package tuxwars.ui.components
{
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.groups.*;
   import com.dchoc.ui.transitions.UITransition;
   import flash.display.*;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import no.olog.utilfunctions.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.ui.containers.shopitem.*;
   import tuxwars.utils.*;
   
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
      
      private var slotObjects:*;
      
      private var container:MovieClip;
      
      private var scrollLeftButton:UIButton;
      
      private var scrollRightButton:UIButton;
      
      private var radial:Boolean;
      
      private var _transitionNameLeft:String;
      
      private var _transitionNameRight:String;
      
      private var _transitionBefore:UITransition;
      
      private var _transitionAfter:UITransition;
      
      public function ObjectContainer(param1:MovieClip, param2:TuxWarsGame, param3:Function, param4:String, param5:String, param6:Boolean = true)
      {
         super(param1,param2);
         this._transitionNameLeft = param4;
         this._transitionNameRight = param5;
         this.getSlotContentObject = param3;
         this.radial = param6;
         this.container = getDesignMovieClip().getChildByName("Container_Slots") as MovieClip;
         if(this.container)
         {
            this.objectsPerPage = this.countObjects("Slot_");
            this.containerType = "Slot_";
            if(this.objectsPerPage <= 0)
            {
               this.objectsPerPage = this.countObjects("Container_");
               this.containerType = "Container_";
            }
            if(getDesignMovieClip().Button_Scroll_Left)
            {
               this.scrollLeftButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Scroll_Left",this.scrollLeftButtonHandler);
            }
            if(getDesignMovieClip().Button_Scroll_Right)
            {
               this.scrollRightButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Scroll_Right",this.scrollRightButtonHandler);
            }
         }
      }
      
      private function countObjects(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.container.numChildren)
         {
            _loc3_ = this.container.getChildAt(_loc2_);
            if(_loc3_ != null && _loc3_.name.indexOf(param1) != -1)
            {
               _loc4_++;
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function init(param1:*, param2:Boolean = true, param3:int = -1, param4:int = -1) : void
      {
         assert("Will cause divide / zero",true,this.objectsPerPage > 0);
         var _loc5_:int = int(this.numPages);
         this.numPages = Math.ceil(param1.length / this.objectsPerPage);
         var _loc6_:* = -1;
         if(this.numPages > param4)
         {
            _loc6_ = param4;
         }
         if(param3 != -1)
         {
            _loc6_ = param3 / this.objectsPerPage;
         }
         if(_loc6_ >= 0)
         {
            this._curPage = _loc6_;
         }
         else if(!param2 || _loc5_ > this.numPages)
         {
            this._curPage = 0;
         }
         this.slotObjects = param1;
         this.showPage(this._curPage);
         if(this.scrollRightButton)
         {
            this.scrollRightButton.setEnabled(this._curPage < this.numPages - 1 && this.numPages > 1);
            this.scrollLeftButton.setEnabled(this._curPage > 0);
         }
      }
      
      override public function dispose() : void
      {
         this.removeSlotObjects();
         this.getSlotContentObject = null;
         this.slotObjects = null;
         this.container = null;
         if(this.scrollLeftButton)
         {
            this.scrollLeftButton.dispose();
            this.scrollLeftButton = null;
         }
         if(this.scrollRightButton)
         {
            this.scrollRightButton.dispose();
            this.scrollRightButton = null;
         }
         super.dispose();
      }
      
      public function get objects() : Array
      {
         return this.containerForObjects;
      }
      
      public function get radialGroup() : UIRadialGroup
      {
         return this._radialGroup;
      }
      
      public function isRadial() : Boolean
      {
         return this.radial;
      }
      
      public function getSelectedButton() : UIButton
      {
         if(this.radial)
         {
            return this._radialGroup.getSelectedButton();
         }
         return null;
      }
      
      public function getCurrentIndex() : int
      {
         if(this.radial)
         {
            return this._curPage * this.objectsPerPage + this._radialGroup.getSelectedIndex();
         }
         return 0;
      }
      
      public function getSelectedObject() : *
      {
         return this.getSlotObject(this.getCurrentIndex());
      }
      
      public function getSlotObject(param1:int) : *
      {
         return this.slotObjects[param1];
      }
      
      public function getContainerForObjects() : Array
      {
         return this.containerForObjects;
      }
      
      public function showObjectAtIndex(param1:int) : void
      {
         var _loc2_:int = 0;
         this._curPage = param1 / this.objectsPerPage;
         this.showPage(this._curPage);
         if(this.scrollRightButton)
         {
            this.scrollRightButton.setEnabled(this._curPage < this.numPages - 1 && this.numPages > 1);
         }
         if(this.scrollLeftButton)
         {
            this.scrollLeftButton.setEnabled(this._curPage > 0);
         }
         if(this.radial)
         {
            _loc2_ = param1 - this._curPage * this.objectsPerPage;
            this._radialGroup.setSelectedIndex(_loc2_);
         }
      }
      
      private function hideAllButtons() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= this.objectsPerPage)
         {
            if(this.containerType == "Slot_")
            {
               this.container.getChildByName("Slot_" + this.getIndexString(_loc1_)).visible = false;
            }
            else if(this.containerType == "Container_")
            {
               this.container.getChildByName("Container_" + this.getIndexString(_loc1_)).visible = false;
            }
            _loc1_++;
         }
      }
      
      private function getIndexString(param1:int) : String
      {
         return param1 < 10 ? "0" + param1 : param1.toString();
      }
      
      private function showPage(param1:int) : void
      {
         var _loc4_:* = undefined;
         this.removeSlotObjects();
         this.hideAllButtons();
         var _loc2_:* = this.getObjectsOnPage(param1);
         var _loc3_:int = 0;
         for each(_loc4_ in _loc2_)
         {
            this.addObject(_loc3_,_loc4_);
            _loc3_++;
         }
      }
      
      private function addObject(param1:int, param2:*) : void
      {
         var _loc3_:ButtonContainers = null;
         var _loc4_:* = this.getSlotContentObject(param1,param2,this.container.getChildByName((this.containerType == "Slot_" ? "Slot_" : "Container_") + this.getIndexString(param1 + 1)));
         if(_loc4_ != null)
         {
            _loc4_.setVisible(true);
            this.containerForObjects.push(_loc4_);
            if(this.radial)
            {
               if(_loc4_ is UIToggleButton)
               {
                  this._radialGroup.add(_loc4_);
               }
               if(_loc4_ is ButtonContainers)
               {
                  _loc3_ = ButtonContainers(_loc4_);
                  if(!ButtonContainers(_loc4_).isLocked)
                  {
                     this._radialGroup.add(_loc3_.currentButtonContainer.button as UIToggleButton);
                  }
               }
            }
         }
      }
      
      private function getObjectsOnPage(param1:int) : *
      {
         var _loc2_:int = param1 * this.objectsPerPage;
         var _loc3_:int = this.slotObjects.length - _loc2_;
         var _loc4_:int = _loc2_ + (_loc3_ < this.objectsPerPage ? _loc3_ : this.objectsPerPage);
         return this.slotObjects.slice(_loc2_,_loc4_);
      }
      
      private function removeSlotObjects() : void
      {
         var _loc1_:* = undefined;
         if(this.radial)
         {
            this._radialGroup.dispose();
         }
         for each(_loc1_ in this.containerForObjects)
         {
            if(_loc1_ != null && Boolean(_loc1_.hasOwnProperty("dispose")))
            {
               if(!(Boolean(_loc1_.hasOwnProperty("disposed")) && Boolean(_loc1_.disposed)))
               {
                  _loc1_.dispose();
                  _loc1_ = null;
               }
            }
         }
         this.containerForObjects.splice(0,this.containerForObjects.length);
      }
      
      private function scrollRightButtonHandler(param1:MouseEvent) : void
      {
         if(this._curPage + 1 < this.numPages)
         {
            ++this._curPage;
            this.showPage(this._curPage);
            if(this._curPage == this.numPages - 1)
            {
               this.scrollRightButton.setEnabled(false);
            }
            if(!this.scrollLeftButton.getEnabled())
            {
               this.scrollLeftButton.setEnabled(true);
            }
         }
      }
      
      private function scrollLeftButtonHandler(param1:MouseEvent) : void
      {
         if(this._curPage - 1 >= 0)
         {
            --this._curPage;
            this.showPage(this._curPage);
            if(this._curPage == 0)
            {
               this.scrollLeftButton.setEnabled(false);
            }
            if(!this.scrollRightButton.getEnabled())
            {
               this.scrollRightButton.setEnabled(true);
            }
         }
      }
      
      private function transitionBeforeEnded(param1:Event) : void
      {
         if(this._transitionBefore)
         {
            this._transitionBefore.dispose(true);
            this._transitionBefore = null;
         }
         this.container.removeEventListener("transition_end",this.transitionBeforeEnded);
      }
      
      private function transitionAfterEnded(param1:Event) : void
      {
         if(this._transitionAfter)
         {
            this._transitionAfter.dispose(true);
            this._transitionAfter = null;
         }
         this.container.removeEventListener("transition_end",this.transitionAfterEnded);
      }
      
      public function get curPage() : int
      {
         return this._curPage;
      }
   }
}

