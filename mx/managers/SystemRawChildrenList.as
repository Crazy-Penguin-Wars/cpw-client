package mx.managers
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import mx.core.IChildList;
   import mx.core.mx_internal;
   
   public class SystemRawChildrenList implements IChildList
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
       
      
      private var owner:SystemManager;
      
      public function SystemRawChildrenList(owner:SystemManager)
      {
         super();
         this.owner = owner;
      }
      
      public function get numChildren() : int
      {
         return this.owner.mx_internal::$numChildren;
      }
      
      public function getChildAt(index:int) : DisplayObject
      {
         return this.owner.mx_internal::rawChildren_getChildAt(index);
      }
      
      public function addChild(child:DisplayObject) : DisplayObject
      {
         return this.owner.mx_internal::rawChildren_addChild(child);
      }
      
      public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         return this.owner.mx_internal::rawChildren_addChildAt(child,index);
      }
      
      public function removeChild(child:DisplayObject) : DisplayObject
      {
         return this.owner.mx_internal::rawChildren_removeChild(child);
      }
      
      public function removeChildAt(index:int) : DisplayObject
      {
         return this.owner.mx_internal::rawChildren_removeChildAt(index);
      }
      
      public function getChildByName(name:String) : DisplayObject
      {
         return this.owner.mx_internal::rawChildren_getChildByName(name);
      }
      
      public function getChildIndex(child:DisplayObject) : int
      {
         return this.owner.mx_internal::rawChildren_getChildIndex(child);
      }
      
      public function setChildIndex(child:DisplayObject, newIndex:int) : void
      {
         this.owner.mx_internal::rawChildren_setChildIndex(child,newIndex);
      }
      
      public function getObjectsUnderPoint(point:Point) : Array
      {
         return this.owner.mx_internal::rawChildren_getObjectsUnderPoint(point);
      }
      
      public function contains(child:DisplayObject) : Boolean
      {
         return this.owner.mx_internal::rawChildren_contains(child);
      }
   }
}
