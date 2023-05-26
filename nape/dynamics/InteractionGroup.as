package nape.dynamics
{
   import flash.Boot;
   import nape.phys.InteractorList;
   import zpp_nape.dynamics.ZPP_InteractionGroup;
   import zpp_nape.util.ZPP_InteractionGroupList;
   import zpp_nape.util.ZPP_InteractorList;
   
   public final class InteractionGroup
   {
       
      
      public var zpp_inner:ZPP_InteractionGroup;
      
      public function InteractionGroup(param1:Boolean = false)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         zpp_inner = new ZPP_InteractionGroup();
         zpp_inner.outer = this;
         if(zpp_inner.ignore != param1)
         {
            zpp_inner.invalidate(true);
            zpp_inner.ignore = param1;
         }
         zpp_inner.ignore;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "InteractionGroup";
         if(zpp_inner.ignore)
         {
            _loc1_ += ":ignore";
         }
         return _loc1_;
      }
      
      public function set ignore(param1:Boolean) : Boolean
      {
         if(zpp_inner.ignore != param1)
         {
            zpp_inner.invalidate(true);
            zpp_inner.ignore = param1;
         }
         return zpp_inner.ignore;
      }
      
      public function set group(param1:InteractionGroup) : InteractionGroup
      {
         if(param1 == this)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign InteractionGroup to itself";
         }
         zpp_inner.setGroup(param1 == null ? null : param1.zpp_inner);
         return zpp_inner.group == null ? null : zpp_inner.group.outer;
      }
      
      public function get interactors() : InteractorList
      {
         if(zpp_inner.wrap_interactors == null)
         {
            zpp_inner.wrap_interactors = ZPP_InteractorList.get(zpp_inner.interactors,true);
         }
         return zpp_inner.wrap_interactors;
      }
      
      public function get ignore() : Boolean
      {
         return zpp_inner.ignore;
      }
      
      public function get groups() : InteractionGroupList
      {
         if(zpp_inner.wrap_groups == null)
         {
            zpp_inner.wrap_groups = ZPP_InteractionGroupList.get(zpp_inner.groups,true);
         }
         return zpp_inner.wrap_groups;
      }
      
      public function get group() : InteractionGroup
      {
         return zpp_inner.group == null ? null : zpp_inner.group.outer;
      }
   }
}
