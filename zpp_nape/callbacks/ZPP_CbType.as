package zpp_nape.callbacks
{
   import flash.Boot;
   import nape.callbacks.CbType;
   import nape.constraint.ConstraintList;
   import nape.phys.InteractorList;
   import zpp_nape.ZPP_ID;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.phys.ZPP_Interactor;
   import zpp_nape.util.ZNPList_ZPP_BodyListener;
   import zpp_nape.util.ZNPList_ZPP_CbSet;
   import zpp_nape.util.ZNPList_ZPP_Constraint;
   import zpp_nape.util.ZNPList_ZPP_ConstraintListener;
   import zpp_nape.util.ZNPList_ZPP_InteractionListener;
   import zpp_nape.util.ZNPList_ZPP_Interactor;
   
   public class ZPP_CbType
   {
      
      public static var ANY_SHAPE:CbType = new CbType();
      
      public static var ANY_BODY:CbType = new CbType();
      
      public static var ANY_COMPOUND:CbType = new CbType();
      
      public static var ANY_CONSTRAINT:CbType = new CbType();
       
      
      public var wrap_interactors:InteractorList;
      
      public var wrap_constraints:ConstraintList;
      
      public var userData;
      
      public var outer:CbType;
      
      public var listeners:ZNPList_ZPP_InteractionListener;
      
      public var interactors:ZNPList_ZPP_Interactor;
      
      public var id:int;
      
      public var constraints:ZNPList_ZPP_Constraint;
      
      public var conlisteners:ZNPList_ZPP_ConstraintListener;
      
      public var cbsets:ZNPList_ZPP_CbSet;
      
      public var bodylisteners:ZNPList_ZPP_BodyListener;
      
      public function ZPP_CbType()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         conlisteners = null;
         bodylisteners = null;
         listeners = null;
         cbsets = null;
         id = 0;
         userData = null;
         outer = null;
         id = ZPP_ID.CbType();
         listeners = new ZNPList_ZPP_InteractionListener();
         bodylisteners = new ZNPList_ZPP_BodyListener();
         conlisteners = new ZNPList_ZPP_ConstraintListener();
         constraints = new ZNPList_ZPP_Constraint();
         interactors = new ZNPList_ZPP_Interactor();
         cbsets = new ZNPList_ZPP_CbSet();
      }
      
      public static function setlt(param1:ZPP_CbType, param2:ZPP_CbType) : Boolean
      {
         return param1.id < param2.id;
      }
      
      public function remInteractor(param1:ZPP_Interactor) : void
      {
         interactors.remove(param1);
      }
      
      public function remConstraint(param1:ZPP_Constraint) : void
      {
         constraints.remove(param1);
      }
      
      public function addInteractor(param1:ZPP_Interactor) : void
      {
         interactors.add(param1);
      }
   }
}
