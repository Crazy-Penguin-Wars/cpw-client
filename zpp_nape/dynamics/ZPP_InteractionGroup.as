package zpp_nape.dynamics
{
   import flash.Boot;
   import nape.dynamics.InteractionGroup;
   import nape.dynamics.InteractionGroupList;
   import nape.phys.InteractorList;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Interactor;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPList_ZPP_InteractionGroup;
   import zpp_nape.util.ZNPList_ZPP_Interactor;
   import zpp_nape.util.ZNPNode_ZPP_InteractionGroup;
   import zpp_nape.util.ZNPNode_ZPP_Interactor;
   
   public class ZPP_InteractionGroup
   {
      
      public static var SHAPE:int = 1;
      
      public static var BODY:int = 2;
       
      
      public var wrap_interactors:InteractorList;
      
      public var wrap_groups:InteractionGroupList;
      
      public var outer:InteractionGroup;
      
      public var interactors:ZNPList_ZPP_Interactor;
      
      public var ignore:Boolean;
      
      public var groups:ZNPList_ZPP_InteractionGroup;
      
      public var group:ZPP_InteractionGroup;
      
      public var depth:int;
      
      public function ZPP_InteractionGroup()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         depth = 0;
         wrap_interactors = null;
         interactors = null;
         wrap_groups = null;
         groups = null;
         group = null;
         ignore = false;
         outer = null;
         depth = 0;
         groups = new ZNPList_ZPP_InteractionGroup();
         interactors = new ZNPList_ZPP_Interactor();
      }
      
      public function setGroup(param1:ZPP_InteractionGroup) : void
      {
         if(group != param1)
         {
            if(group != null)
            {
               group.groups.remove(this);
               depth = 0;
               group.invalidate(true);
            }
            group = param1;
            if(param1 != null)
            {
               param1.groups.add(this);
               depth = param1.depth + 1;
               param1.invalidate(true);
            }
            else
            {
               invalidate(true);
            }
         }
      }
      
      public function remInteractor(param1:ZPP_Interactor, param2:int = -1) : void
      {
         interactors.remove(param1);
      }
      
      public function invalidate(param1:Boolean = false) : void
      {
         var _loc3_:* = null as ZPP_Interactor;
         var _loc5_:* = null as ZPP_InteractionGroup;
         if(!(param1 || ignore))
         {
            return;
         }
         var _loc2_:ZNPNode_ZPP_Interactor = interactors.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            if(_loc3_.ibody != null)
            {
               _loc3_.ibody.wake();
            }
            else if(_loc3_.ishape != null)
            {
               _loc3_.ishape.body.wake();
            }
            else
            {
               _loc3_.icompound.wake();
            }
            _loc2_ = _loc2_.next;
         }
         var _loc4_:ZNPNode_ZPP_InteractionGroup = groups.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc5_.invalidate(param1);
            _loc4_ = _loc4_.next;
         }
      }
   }
}
