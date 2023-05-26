package zpp_nape.phys
{
   import flash.Boot;
   import nape.constraint.Constraint;
   import nape.constraint.ConstraintList;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.phys.Compound;
   import nape.phys.CompoundList;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.constraint.ZPP_CopyHelper;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPList_ZPP_Body;
   import zpp_nape.util.ZNPList_ZPP_Compound;
   import zpp_nape.util.ZNPList_ZPP_Constraint;
   import zpp_nape.util.ZNPNode_ZPP_Body;
   import zpp_nape.util.ZNPNode_ZPP_Compound;
   import zpp_nape.util.ZNPNode_ZPP_Constraint;
   import zpp_nape.util.ZPP_BodyList;
   import zpp_nape.util.ZPP_CompoundList;
   import zpp_nape.util.ZPP_ConstraintList;
   
   public class ZPP_Compound extends ZPP_Interactor
   {
       
      
      public var wrap_constraints:ConstraintList;
      
      public var wrap_compounds:CompoundList;
      
      public var wrap_bodies:BodyList;
      
      public var space:ZPP_Space;
      
      public var outer:Compound;
      
      public var depth:int;
      
      public var constraints:ZNPList_ZPP_Constraint;
      
      public var compounds:ZNPList_ZPP_Compound;
      
      public var compound:ZPP_Compound;
      
      public var bodies:ZNPList_ZPP_Body;
      
      public function ZPP_Compound()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         space = null;
         compound = null;
         depth = 0;
         wrap_compounds = null;
         wrap_constraints = null;
         wrap_bodies = null;
         compounds = null;
         constraints = null;
         bodies = null;
         outer = null;
         super();
         icompound = this;
         depth = 1;
         bodies = new ZNPList_ZPP_Body();
         wrap_bodies = ZPP_BodyList.get(bodies);
         wrap_bodies.zpp_inner.adder = bodies_adder;
         wrap_bodies.zpp_inner.subber = bodies_subber;
         wrap_bodies.zpp_inner._modifiable = bodies_modifiable;
         constraints = new ZNPList_ZPP_Constraint();
         wrap_constraints = ZPP_ConstraintList.get(constraints);
         wrap_constraints.zpp_inner.adder = constraints_adder;
         wrap_constraints.zpp_inner.subber = constraints_subber;
         wrap_constraints.zpp_inner._modifiable = constraints_modifiable;
         compounds = new ZNPList_ZPP_Compound();
         wrap_compounds = ZPP_CompoundList.get(compounds);
         wrap_compounds.zpp_inner.adder = compounds_adder;
         wrap_compounds.zpp_inner.subber = compounds_subber;
         wrap_compounds.zpp_inner._modifiable = compounds_modifiable;
      }
      
      public function removedFromSpace() : void
      {
         __iremovedFromSpace();
      }
      
      public function copy(param1:Array = undefined, param2:Array = undefined) : Compound
      {
         var _loc6_:* = null as ZPP_Compound;
         var _loc7_:* = null as Compound;
         var _loc8_:* = null as CompoundList;
         var _loc10_:* = null as ZPP_Body;
         var _loc11_:* = null as Body;
         var _loc12_:* = null as BodyList;
         var _loc14_:* = null as ZPP_Constraint;
         var _loc15_:* = null as Constraint;
         var _loc16_:* = null as ConstraintList;
         var _loc17_:* = null as ZPP_CopyHelper;
         var _loc18_:int = 0;
         var _loc19_:* = null as ZPP_CopyHelper;
         var _loc3_:Boolean = param1 == null;
         if(param1 == null)
         {
            param1 = [];
         }
         if(param2 == null)
         {
            param2 = [];
         }
         var _loc4_:Compound = new Compound();
         var _loc5_:ZNPNode_ZPP_Compound = compounds.head;
         while(_loc5_ != null)
         {
            _loc6_ = _loc5_.elt;
            _loc7_ = _loc6_.copy(param1,param2);
            _loc7_.zpp_inner.immutable_midstep("Compound::compound");
            if((_loc7_.zpp_inner.compound == null ? null : _loc7_.zpp_inner.compound.outer) != _loc4_)
            {
               if(_loc4_ != null)
               {
                  _loc8_ = _loc4_.zpp_inner.wrap_compounds;
                  if(_loc8_.zpp_inner.reverse_flag)
                  {
                     _loc8_.push(_loc7_);
                  }
                  else
                  {
                     _loc8_.unshift(_loc7_);
                  }
               }
            }
            if(_loc7_.zpp_inner.compound != null)
            {
               _loc7_.zpp_inner.compound.outer;
            }
            _loc5_ = _loc5_.next;
         }
         var _loc9_:ZNPNode_ZPP_Body = bodies.head;
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_.elt;
            _loc11_ = _loc10_.outer.copy();
            param1.push(ZPP_CopyHelper.dict(_loc10_.id,_loc11_));
            if((_loc11_.zpp_inner.compound == null ? null : _loc11_.zpp_inner.compound.outer) != _loc4_)
            {
               if(_loc4_ != null)
               {
                  _loc12_ = _loc4_.zpp_inner.wrap_bodies;
                  if(_loc12_.zpp_inner.reverse_flag)
                  {
                     _loc12_.push(_loc11_);
                  }
                  else
                  {
                     _loc12_.unshift(_loc11_);
                  }
               }
            }
            if(_loc11_.zpp_inner.compound != null)
            {
               _loc11_.zpp_inner.compound.outer;
            }
            _loc9_ = _loc9_.next;
         }
         var _loc13_:ZNPNode_ZPP_Constraint = constraints.head;
         while(_loc13_ != null)
         {
            _loc14_ = _loc13_.elt;
            _loc15_ = _loc14_.copy(param1,param2);
            if((_loc15_.zpp_inner.compound == null ? null : _loc15_.zpp_inner.compound.outer) != _loc4_)
            {
               if(_loc4_ != null)
               {
                  _loc16_ = _loc4_.zpp_inner.wrap_constraints;
                  if(_loc16_.zpp_inner.reverse_flag)
                  {
                     _loc16_.push(_loc15_);
                  }
                  else
                  {
                     _loc16_.unshift(_loc15_);
                  }
               }
            }
            if(_loc15_.zpp_inner.compound != null)
            {
               _loc15_.zpp_inner.compound.outer;
            }
            _loc13_ = _loc13_.next;
         }
         if(_loc3_)
         {
            while(param2.length > 0)
            {
               _loc17_ = param2.pop();
               _loc18_ = 0;
               while(_loc18_ < param1.length)
               {
                  _loc19_ = param1[_loc18_];
                  _loc18_++;
                  if(_loc19_.id == _loc17_.id)
                  {
                     _loc17_.cb(_loc19_.bc);
                     break;
                  }
               }
            }
         }
         copyto(_loc4_);
         return _loc4_;
      }
      
      public function constraints_subber(param1:Constraint) : void
      {
         param1.zpp_inner.compound = null;
         if(space != null)
         {
            space.remConstraint(param1.zpp_inner);
         }
      }
      
      public function constraints_modifiable() : void
      {
         immutable_midstep("Compound::" + "constraints");
      }
      
      public function constraints_adder(param1:Constraint) : Boolean
      {
         if(param1.zpp_inner.compound != this)
         {
            if(param1.zpp_inner.compound != null)
            {
               param1.zpp_inner.compound.wrap_constraints.remove(param1);
            }
            else if(param1.zpp_inner.space != null)
            {
               param1.zpp_inner.space.wrap_constraints.remove(param1);
            }
            param1.zpp_inner.compound = this;
            if(space != null)
            {
               space.addConstraint(param1.zpp_inner);
            }
            return true;
         }
         return false;
      }
      
      public function compounds_subber(param1:Compound) : void
      {
         param1.zpp_inner.compound = null;
         param1.zpp_inner.depth = 1;
         if(space != null)
         {
            space.remCompound(param1.zpp_inner);
         }
      }
      
      public function compounds_modifiable() : void
      {
         immutable_midstep("Compound::" + "compounds");
      }
      
      public function compounds_adder(param1:Compound) : Boolean
      {
         var _loc2_:ZPP_Compound = this;
         while(_loc2_ != null && _loc2_ != param1.zpp_inner)
         {
            _loc2_ = _loc2_.compound;
         }
         if(_loc2_ == param1.zpp_inner)
         {
            Boot.lastError = new Error();
            throw "Error: Assignment would cause a cycle in the Compound tree: assigning " + param1.toString() + ".compound = " + outer.toString();
         }
         if(param1.zpp_inner.compound != this)
         {
            if(param1.zpp_inner.compound != null)
            {
               param1.zpp_inner.compound.wrap_compounds.remove(param1);
            }
            else if(param1.zpp_inner.space != null)
            {
               param1.zpp_inner.space.wrap_compounds.remove(param1);
            }
            param1.zpp_inner.compound = this;
            param1.zpp_inner.depth = depth + 1;
            if(space != null)
            {
               space.addCompound(param1.zpp_inner);
            }
            return true;
         }
         return false;
      }
      
      public function breakApart() : void
      {
         var _loc1_:* = null as ZPP_Body;
         var _loc2_:* = null as ZPP_Compound;
         var _loc3_:* = null as ZPP_Constraint;
         var _loc4_:* = null as ZPP_Compound;
         if(space != null)
         {
            __iremovedFromSpace();
            space.nullInteractorType(this);
         }
         if(compound != null)
         {
            compound.compounds.remove(this);
         }
         else if(space != null)
         {
            space.compounds.remove(this);
         }
         while(bodies.head != null)
         {
            _loc1_ = bodies.pop_unsafe();
            if((_loc1_.compound = compound) != null)
            {
               compound.bodies.add(_loc1_);
            }
            else if(space != null)
            {
               space.bodies.add(_loc1_);
            }
            if(space != null)
            {
               space.freshInteractorType(_loc1_);
            }
         }
         while(constraints.head != null)
         {
            _loc3_ = constraints.pop_unsafe();
            if((_loc3_.compound = compound) != null)
            {
               compound.constraints.add(_loc3_);
            }
            else if(space != null)
            {
               space.constraints.add(_loc3_);
            }
         }
         while(compounds.head != null)
         {
            _loc2_ = compounds.pop_unsafe();
            if((_loc2_.compound = compound) != null)
            {
               compound.compounds.add(_loc2_);
            }
            else if(space != null)
            {
               space.compounds.add(_loc2_);
            }
            if(space != null)
            {
               space.freshInteractorType(_loc2_);
            }
         }
         compound = null;
         space = null;
      }
      
      public function bodies_subber(param1:Body) : void
      {
         param1.zpp_inner.compound = null;
         if(space != null)
         {
            space.remBody(param1.zpp_inner);
         }
      }
      
      public function bodies_modifiable() : void
      {
         immutable_midstep("Compound::" + "bodies");
      }
      
      public function bodies_adder(param1:Body) : Boolean
      {
         if(param1.zpp_inner.compound != this)
         {
            if(param1.zpp_inner.compound != null)
            {
               param1.zpp_inner.compound.wrap_bodies.remove(param1);
            }
            else if(param1.zpp_inner.space != null)
            {
               param1.zpp_inner.space.wrap_bodies.remove(param1);
            }
            param1.zpp_inner.compound = this;
            if(space != null)
            {
               space.addBody(param1.zpp_inner);
            }
            return true;
         }
         return false;
      }
      
      public function addedToSpace() : void
      {
         __iaddedToSpace();
      }
      
      public function __imutable_midstep(param1:String) : void
      {
         if(space != null && space.midstep)
         {
            Boot.lastError = new Error();
            throw "Error: " + param1 + " cannot be set during space step()";
         }
      }
   }
}
