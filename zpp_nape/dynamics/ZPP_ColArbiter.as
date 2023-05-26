package zpp_nape.dynamics
{
   import flash.Boot;
   import nape.dynamics.CollisionArbiter;
   import nape.dynamics.Contact;
   import nape.dynamics.ContactList;
   import nape.geom.Vec2;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZPP_ContactList;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_ColArbiter extends ZPP_Arbiter
   {
      
      public static var zpp_pool:ZPP_ColArbiter = null;
       
      
      public var wrap_normal:Vec2;
      
      public var wrap_contacts:ContactList;
      
      public var userdef_stat_fric:Boolean;
      
      public var userdef_rfric:Boolean;
      
      public var userdef_restitution:Boolean;
      
      public var userdef_dyn_fric:Boolean;
      
      public var surfacey:Number;
      
      public var surfacex:Number;
      
      public var stat_fric:Number;
      
      public var stat:Boolean;
      
      public var s2:ZPP_Shape;
      
      public var s1:ZPP_Shape;
      
      public var rt2b:Number;
      
      public var rt2a:Number;
      
      public var rt1b:Number;
      
      public var rt1a:Number;
      
      public var rn2b:Number;
      
      public var rn2a:Number;
      
      public var rn1b:Number;
      
      public var rn1a:Number;
      
      public var rfric:Number;
      
      public var rev:Boolean;
      
      public var restitution:Number;
      
      public var radius:Number;
      
      public var rMass:Number;
      
      public var ptype:int;
      
      public var pre_dt:Number;
      
      public var outer_zn:CollisionArbiter;
      
      public var oc2:ZPP_Contact;
      
      public var oc1:ZPP_Contact;
      
      public var ny:Number;
      
      public var nx:Number;
      
      public var next:ZPP_ColArbiter;
      
      public var mutable:Boolean;
      
      public var lproj:Number;
      
      public var lnormy:Number;
      
      public var lnormx:Number;
      
      public var kMassc:Number;
      
      public var kMassb:Number;
      
      public var kMassa:Number;
      
      public var k2y:Number;
      
      public var k2x:Number;
      
      public var k1y:Number;
      
      public var k1x:Number;
      
      public var jrAcc:Number;
      
      public var innards:ZPP_IContact;
      
      public var hpc2:Boolean;
      
      public var hc2:Boolean;
      
      public var dyn_fric:Number;
      
      public var contacts:ZPP_Contact;
      
      public var c2:ZPP_IContact;
      
      public var c1:ZPP_IContact;
      
      public var biasCoef:Number;
      
      public var __ref_vertex:int;
      
      public var __ref_edge2:ZPP_Edge;
      
      public var __ref_edge1:ZPP_Edge;
      
      public var Kc:Number;
      
      public var Kb:Number;
      
      public var Ka:Number;
      
      public function ZPP_ColArbiter()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         pre_dt = 0;
         mutable = false;
         stat = false;
         next = null;
         hpc2 = false;
         hc2 = false;
         oc2 = null;
         c2 = null;
         oc1 = null;
         c1 = null;
         __ref_vertex = 0;
         __ref_edge2 = null;
         __ref_edge1 = null;
         biasCoef = 0;
         rev = false;
         radius = 0;
         lproj = 0;
         lnormy = 0;
         lnormx = 0;
         surfacey = 0;
         surfacex = 0;
         k2y = 0;
         k2x = 0;
         k1y = 0;
         k1x = 0;
         rt2b = 0;
         rn2b = 0;
         rt2a = 0;
         rn2a = 0;
         rt1b = 0;
         rn1b = 0;
         rt1a = 0;
         rn1a = 0;
         jrAcc = 0;
         rMass = 0;
         Kc = 0;
         Kb = 0;
         Ka = 0;
         kMassc = 0;
         kMassb = 0;
         kMassa = 0;
         wrap_normal = null;
         ny = 0;
         nx = 0;
         innards = null;
         wrap_contacts = null;
         contacts = null;
         s2 = null;
         s1 = null;
         userdef_rfric = false;
         userdef_restitution = false;
         userdef_stat_fric = false;
         userdef_dyn_fric = false;
         rfric = 0;
         restitution = 0;
         stat_fric = 0;
         dyn_fric = 0;
         outer_zn = null;
         super();
         pre_dt = -1;
         contacts = new ZPP_Contact();
         innards = new ZPP_IContact();
         type = ZPP_Arbiter.COL;
         colarb = this;
      }
      
      public function setupcontacts() : void
      {
         wrap_contacts = ZPP_ContactList.get(contacts,true);
         wrap_contacts.zpp_inner.immutable = !mutable;
         wrap_contacts.zpp_inner.adder = contacts_adder;
         wrap_contacts.zpp_inner.dontremove = true;
         wrap_contacts.zpp_inner.subber = contacts_subber;
      }
      
      public function normal_validate() : void
      {
         if(cleared)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         wrap_normal.zpp_inner.x = nx;
         wrap_normal.zpp_inner.y = ny;
      }
      
      public function getnormal() : void
      {
         var _loc2_:* = null as Vec2;
         var _loc3_:Boolean = false;
         var _loc4_:* = null as ZPP_Vec2;
         §§push(§§findproperty(wrap_normal));
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc2_ = new Vec2();
         }
         else
         {
            _loc2_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc2_.zpp_pool;
            _loc2_.zpp_pool = null;
            _loc2_.zpp_disp = false;
            if(_loc2_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc2_.zpp_inner == null)
         {
            _loc3_ = false;
            §§push(_loc2_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc4_ = new ZPP_Vec2();
            }
            else
            {
               _loc4_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc4_.next;
               _loc4_.next = null;
            }
            _loc4_.weak = false;
            _loc4_._immutable = _loc3_;
            _loc4_.x = 0;
            _loc4_.y = 0;
            §§pop().zpp_inner = _loc4_;
            _loc2_.zpp_inner.outer = _loc2_;
         }
         else
         {
            if(_loc2_ != null && _loc2_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = _loc2_.zpp_inner;
            if(_loc4_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc4_._isimmutable != null)
            {
               _loc4_._isimmutable();
            }
            §§push(false);
            if(_loc2_ != null && _loc2_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = _loc2_.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            if(_loc2_.zpp_inner.x == 0)
            {
               §§pop();
               if(_loc2_ != null && _loc2_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc4_ = _loc2_.zpp_inner;
               if(_loc4_._validate != null)
               {
                  _loc4_._validate();
               }
               §§push(_loc2_.zpp_inner.y == 0);
            }
            if(!§§pop())
            {
               _loc2_.zpp_inner.x = 0;
               _loc2_.zpp_inner.y = 0;
               _loc4_ = _loc2_.zpp_inner;
               if(_loc4_._invalidate != null)
               {
                  _loc4_._invalidate(_loc4_);
               }
            }
            _loc2_;
         }
         _loc2_.zpp_inner.weak = false;
         §§pop().wrap_normal = _loc2_;
         wrap_normal.zpp_inner._immutable = true;
         wrap_normal.zpp_inner._inuse = true;
         wrap_normal.zpp_inner._validate = normal_validate;
      }
      
      public function contacts_subber(param1:Contact) : void
      {
         var _loc6_:* = null as ZPP_Contact;
         var _loc7_:* = null as ZPP_Contact;
         var _loc2_:ZPP_Contact = null;
         var _loc3_:ZPP_IContact = null;
         var _loc4_:ZPP_IContact = innards.next;
         var _loc5_:ZPP_Contact = contacts.next;
         while(_loc5_ != null)
         {
            _loc6_ = _loc5_;
            if(_loc6_ == param1.zpp_inner)
            {
               contacts.erase(_loc2_);
               innards.erase(_loc3_);
               _loc7_ = _loc6_;
               _loc7_.arbiter = null;
               _loc7_.next = ZPP_Contact.zpp_pool;
               ZPP_Contact.zpp_pool = _loc7_;
               break;
            }
            _loc2_ = _loc5_;
            _loc3_ = _loc4_;
            _loc4_ = _loc4_.next;
            _loc5_ = _loc5_.next;
         }
      }
      
      public function contacts_adder(param1:Contact) : Boolean
      {
         Boot.lastError = new Error();
         throw "Error: Cannot add new contacts, information required is far too specific and detailed :)";
      }
   }
}
