package nape.constraint
{
   import flash.Boot;
   import nape.callbacks.CbTypeList;
   import nape.geom.MatMN;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.phys.Compound;
   import nape.space.Space;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.space.ZPP_Space;
   
   public class Constraint
   {
       
      
      public var zpp_inner:ZPP_Constraint;
      
      public var debugDraw:Boolean;
      
      public function Constraint()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         debugDraw = true;
         zpp_inner.insert_cbtype(ZPP_CbType.ANY_CONSTRAINT.zpp_inner);
         Boot.lastError = new Error();
         throw "Error: Constraint cannot be instantiated derp!";
      }
      
      public function visitBodies(param1:Function) : void
      {
      }
      
      public function toString() : String
      {
         return "{Constraint}";
      }
      
      public function set stiff(param1:Boolean) : Boolean
      {
         if(zpp_inner.stiff != param1)
         {
            zpp_inner.stiff = param1;
            zpp_inner.wake();
         }
         return zpp_inner.stiff;
      }
      
      public function set space(param1:Space) : Space
      {
         var _loc2_:* = null as ConstraintList;
         if(zpp_inner.compound != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set the space of a Constraint belonging to" + " a Compound, only the root Compound space can be set";
         }
         if((zpp_inner.space == null ? null : zpp_inner.space.outer) != param1)
         {
            if(zpp_inner.component != null)
            {
               zpp_inner.component.woken = false;
            }
            zpp_inner.clearcache();
            if(zpp_inner.space != null)
            {
               zpp_inner.space.outer.zpp_inner.wrap_constraints.remove(this);
            }
            if(param1 != null)
            {
               _loc2_ = param1.zpp_inner.wrap_constraints;
               if(_loc2_.zpp_inner.reverse_flag)
               {
                  _loc2_.push(this);
               }
               else
               {
                  _loc2_.unshift(this);
               }
            }
            else
            {
               zpp_inner.space = null;
            }
         }
         return zpp_inner.space == null ? null : zpp_inner.space.outer;
      }
      
      public function set removeOnBreak(param1:Boolean) : Boolean
      {
         zpp_inner.removeOnBreak = param1;
         return zpp_inner.removeOnBreak;
      }
      
      public function set maxForce(param1:Number) : Number
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::maxForce cannot be NaN";
         }
         if(param1 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::maxForce must be >=0";
         }
         if(zpp_inner.maxForce != param1)
         {
            zpp_inner.maxForce = param1;
            zpp_inner.wake();
         }
         return zpp_inner.maxForce;
      }
      
      public function set maxError(param1:Number) : Number
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::maxError cannot be NaN";
         }
         if(param1 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::maxError must be >=0";
         }
         if(zpp_inner.maxError != param1)
         {
            zpp_inner.maxError = param1;
            zpp_inner.wake();
         }
         return zpp_inner.maxError;
      }
      
      public function set ignore(param1:Boolean) : Boolean
      {
         if(zpp_inner.ignore != param1)
         {
            zpp_inner.ignore = param1;
            zpp_inner.wake();
         }
         return zpp_inner.ignore;
      }
      
      public function set frequency(param1:Number) : Number
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::Frequency cannot be NaN";
         }
         if(param1 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::Frequency must be >0";
         }
         if(zpp_inner.frequency != param1)
         {
            zpp_inner.frequency = param1;
            if(!zpp_inner.stiff)
            {
               zpp_inner.wake();
            }
         }
         return zpp_inner.frequency;
      }
      
      public function set damping(param1:Number) : Number
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::Damping cannot be Nan";
         }
         if(param1 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::Damping must be >=0";
         }
         if(zpp_inner.damping != param1)
         {
            zpp_inner.damping = param1;
            if(!zpp_inner.stiff)
            {
               zpp_inner.wake();
            }
         }
         return zpp_inner.damping;
      }
      
      public function set compound(param1:Compound) : Compound
      {
         var _loc2_:* = null as ConstraintList;
         if((zpp_inner.compound == null ? null : zpp_inner.compound.outer) != param1)
         {
            if(param1 != null)
            {
               _loc2_ = param1.zpp_inner.wrap_constraints;
               if(_loc2_.zpp_inner.reverse_flag)
               {
                  _loc2_.push(this);
               }
               else
               {
                  _loc2_.unshift(this);
               }
            }
         }
         return zpp_inner.compound == null ? null : zpp_inner.compound.outer;
      }
      
      public function set breakUnderForce(param1:Boolean) : Boolean
      {
         if(zpp_inner.breakUnderForce != param1)
         {
            zpp_inner.breakUnderForce = param1;
            zpp_inner.wake();
         }
         return zpp_inner.breakUnderForce;
      }
      
      public function set breakUnderError(param1:Boolean) : Boolean
      {
         if(zpp_inner.breakUnderError != param1)
         {
            zpp_inner.breakUnderError = param1;
            zpp_inner.wake();
         }
         return zpp_inner.breakUnderError;
      }
      
      public function set active(param1:Boolean) : Boolean
      {
         if(zpp_inner.active != param1)
         {
            if(zpp_inner.component != null)
            {
               zpp_inner.component.woken = false;
            }
            zpp_inner.clearcache();
            if(param1)
            {
               zpp_inner.active = param1;
               zpp_inner.activate();
               if(zpp_inner.space != null)
               {
                  if(zpp_inner.component != null)
                  {
                     zpp_inner.component.sleeping = true;
                  }
                  zpp_inner.space.wake_constraint(zpp_inner,true);
               }
            }
            else
            {
               if(zpp_inner.space != null)
               {
                  zpp_inner.wake();
                  zpp_inner.space.live_constraints.remove(zpp_inner);
               }
               zpp_inner.active = param1;
               zpp_inner.deactivate();
            }
         }
         return zpp_inner.active;
      }
      
      public function impulse() : MatMN
      {
         return null;
      }
      
      public function get userData() : *
      {
         if(zpp_inner.userData == null)
         {
            zpp_inner.userData = {};
         }
         return zpp_inner.userData;
      }
      
      public function get stiff() : Boolean
      {
         return zpp_inner.stiff;
      }
      
      public function get space() : Space
      {
         return zpp_inner.space == null ? null : zpp_inner.space.outer;
      }
      
      public function get removeOnBreak() : Boolean
      {
         return zpp_inner.removeOnBreak;
      }
      
      public function get maxForce() : Number
      {
         return zpp_inner.maxForce;
      }
      
      public function get maxError() : Number
      {
         return zpp_inner.maxError;
      }
      
      public function get isSleeping() : Boolean
      {
         if(zpp_inner.space == null || !zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: isSleeping only makes sense if constraint is" + " active and inside a space";
         }
         return zpp_inner.component.sleeping;
      }
      
      public function get ignore() : Boolean
      {
         return zpp_inner.ignore;
      }
      
      public function get frequency() : Number
      {
         return zpp_inner.frequency;
      }
      
      public function get damping() : Number
      {
         return zpp_inner.damping;
      }
      
      public function get compound() : Compound
      {
         return zpp_inner.compound == null ? null : zpp_inner.compound.outer;
      }
      
      public function get cbTypes() : CbTypeList
      {
         if(zpp_inner.wrap_cbTypes == null)
         {
            zpp_inner.setupcbTypes();
         }
         return zpp_inner.wrap_cbTypes;
      }
      
      public function get breakUnderForce() : Boolean
      {
         return zpp_inner.breakUnderForce;
      }
      
      public function get breakUnderError() : Boolean
      {
         return zpp_inner.breakUnderError;
      }
      
      public function get active() : Boolean
      {
         return zpp_inner.active;
      }
      
      public function copy() : Constraint
      {
         return zpp_inner.copy();
      }
      
      public function bodyImpulse(param1:Body) : Vec3
      {
         return null;
      }
   }
}
