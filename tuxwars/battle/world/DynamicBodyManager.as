package tuxwars.battle.world
{
   import avmplus.getQualifiedClassName;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.xml.*;
   import mx.rpc.xml.*;
   import mx.utils.*;
   import nape.geom.*;
   import nape.phys.*;
   import nape.shape.*;
   import nape.space.Space;
   
   public class DynamicBodyManager
   {
      private static const SHAPE_CIRCLE:String = "CIRCLE";
      
      private static const SHAPE_POLYGON:String = "POLYGON";
      
      private var _id:String;
      
      private var file:String;
      
      private var materialCache:Object;
      
      private var resourceToFileLinking:Object;
      
      public function DynamicBodyManager(param1:String, param2:String)
      {
         var _loc8_:* = undefined;
         var _loc3_:* = null;
         super();
         this._id = param1;
         this.file = param2;
         this.materialCache = {};
         this.resourceToFileLinking = {};
         var _loc4_:SimpleXMLDecoder = new SimpleXMLDecoder();
         var _loc5_:String = DCResourceManager.instance.get(param2);
         var _loc6_:Object = _loc4_.decodeXML(new XMLDocument(_loc5_));
         if(_loc6_ == null)
         {
            LogUtils.log("XML object is null in file: " + param2,this,3);
            return;
         }
         if(_loc6_.bodydef == null)
         {
            LogUtils.log("bodydef parameter in xml is null in file: " + param2,this,3);
            return;
         }
         if(_loc6_.bodydef.bodies == null)
         {
            LogUtils.log("bodies parameter in xml is null in file: " + param2,this,3);
            return;
         }
         if(_loc6_.bodydef.bodies.body == null)
         {
            LogUtils.log("bodyArray parameter in xml is null in file: " + param2,this,3);
            return;
         }
         var _loc7_:Array = _loc6_.bodydef.bodies.body is Array ? _loc6_.bodydef.bodies.body : [_loc6_.bodydef.bodies.body];
         for each(_loc8_ in _loc7_)
         {
            if(_loc8_ == null)
            {
               LogUtils.log("singleBody parameter in xml is null in file: " + param2,this,3);
               return;
            }
            if(_loc8_.name == null)
            {
               LogUtils.log("name parameter in xml is null in file: " + param2,this,3);
               return;
            }
            if(this.resourceToFileLinking[_loc8_.name] == null)
            {
               this.resourceToFileLinking[_loc8_.name] = param2;
               this.getShapes(_loc8_.name);
            }
            else
            {
               _loc3_ = "Duplicate recource name: " + _loc8_.name + " in <file1: " + param2 + "> and <file2: " + this.resourceToFileLinking[_loc8_.name] + ">";
               LogUtils.log(_loc3_,this,3,"All",true,true);
               if(Config.debugMode)
               {
                  throw new Error(_loc3_);
               }
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.materialCache)
         {
            this.materialCache[_loc1_].destroy();
         }
         DCUtils.deleteProperties(this.materialCache);
         DCUtils.deleteProperties(this.resourceToFileLinking);
      }
      
      public function createBody(param1:String, param2:Space, param3:Vec2, param4:*, param5:Number = 0, param6:Boolean = false) : Body
      {
         var _loc9_:* = undefined;
         var _loc7_:Body = new Body(BodyType.DYNAMIC);
         var _loc8_:Array = this.getShapes(param1);
         for each(_loc9_ in _loc8_)
         {
            _loc7_.shapes.add(_loc9_.copy());
         }
         _loc7_.rotation = MathUtils.degreesToRadians(param5);
         _loc7_.allowRotation = !param6;
         _loc7_.position = param3.copy(true);
         _loc7_.userData.gameObject = param4;
         _loc7_.space = param2;
         return _loc7_;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function getFile() : String
      {
         return this.file;
      }
      
      public function getMaterial(param1:String) : Material
      {
         if(this.materialCache[param1] == null)
         {
            return null;
         }
         var _loc2_:Material = this.materialCache[param1][0];
         return _loc2_.copy();
      }
      
      public function getShapes(param1:String) : Array
      {
         var _loc17_:* = undefined;
         var _loc18_:* = null;
         var _loc19_:String = null;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         var _loc2_:* = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Material = null;
         var _loc6_:Circle = null;
         var _loc7_:Array = null;
         var _loc8_:* = undefined;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:Vec2 = null;
         var _loc12_:Polygon = null;
         if(this.materialCache[param1] != null)
         {
            return this.materialCache[param1];
         }
         var _loc13_:String = this.resourceToFileLinking[param1];
         if(_loc13_ == null)
         {
            _loc2_ = "xml object corrupt or null for Id: " + param1 + " in file: " + _loc13_;
            LogUtils.log(_loc2_,this,3,"All",true,true);
            if(Config.debugMode)
            {
               throw new Error(_loc2_);
            }
            return null;
         }
         var _loc14_:String = DCResourceManager.instance.get(_loc13_);
         var _loc15_:Object = new SimpleXMLDecoder().decodeXML(new XMLDocument(_loc14_));
         if(_loc13_ == null)
         {
            _loc18_ = "File name containing resource Id: " + param1 + " not found, list of linkings found in manager: ";
            for(_loc19_ in this.resourceToFileLinking)
            {
               _loc20_ = this.resourceToFileLinking[_loc19_];
               if(getQualifiedClassName(_loc20_) == getQualifiedClassName(Object))
               {
                  _loc18_ += "<" + _loc19_ + ": " + LogUtils.getObjectContent(_loc20_) + ">";
               }
               else if(_loc20_ is String)
               {
                  _loc18_ += "<" + _loc19_ + ": " + _loc20_.toString() + ">";
               }
               else
               {
                  _loc18_ += "<" + _loc19_ + ": " + getQualifiedClassName(_loc20_) + ">";
               }
            }
            LogUtils.log(_loc18_,this,3,"All",true,true);
            if(Config.debugMode)
            {
               throw new Error(_loc18_);
            }
            return null;
         }
         var _loc16_:Array = _loc15_.bodydef.bodies.body is Array ? _loc15_.bodydef.bodies.body : [_loc15_.bodydef.bodies.body];
         for each(_loc17_ in _loc16_)
         {
            if(_loc17_.name == param1)
            {
               if(_loc17_.fixtures == null)
               {
                  LogUtils.log("fixtures parameter is null for resource Id: " + param1 + " in file: " + _loc13_,this,3);
                  return null;
               }
               if(_loc17_.fixtures.fixture == null)
               {
                  LogUtils.log("fixtureArray parameter is null for resource Id: " + param1 + " in file: " + _loc13_,this,3);
                  return null;
               }
               _loc3_ = _loc17_.fixtures.fixture is Array ? _loc17_.fixtures.fixture : [_loc17_.fixtures.fixture];
               _loc4_ = [];
               for each(_loc21_ in _loc3_)
               {
                  if(_loc21_ == null)
                  {
                     LogUtils.log("singleFixture parameter is null for resource Id: " + param1 + " in file: " + _loc13_,this,3);
                     return null;
                  }
                  if(_loc21_.density == null)
                  {
                     LogUtils.log("density parameter is null for resource Id: " + param1 + " in file: " + _loc13_,this,3);
                     return null;
                  }
                  if(_loc21_.friction == null)
                  {
                     LogUtils.log("friction parameter is null for resource Id: " + param1 + " in file: " + _loc13_,this,3);
                     return null;
                  }
                  if(_loc21_.restitution == null)
                  {
                     LogUtils.log("restitution parameter is null for resource Id: " + param1 + " in file: " + _loc13_,this,3);
                     return null;
                  }
                  if(_loc21_.fixture_type == null)
                  {
                     LogUtils.log("fixture_type parameter is null for resource Id: " + param1 + " in file: " + _loc13_,this,3);
                     return null;
                  }
                  _loc5_ = new Material();
                  _loc5_.density = _loc21_.density;
                  _loc5_.dynamicFriction = _loc21_.friction;
                  _loc5_.elasticity = _loc21_.restitution;
                  switch(_loc21_.fixture_type as String)
                  {
                     case "CIRCLE":
                        _loc6_ = new Circle(_loc21_.circle.r);
                        _loc6_.material = _loc5_.copy();
                        _loc4_ = [_loc6_];
                        break;
                     case "POLYGON":
                        if(_loc21_.polygons == null)
                        {
                           LogUtils.log("polygons parameter is null for resource Id: " + param1 + " in file: " + _loc13_,this,3);
                           return null;
                        }
                        if(_loc21_.polygons.polygon == null)
                        {
                           LogUtils.log("polygonArray parameter is null for resource Id: " + param1 + " in file: " + _loc13_,this,3);
                           return null;
                        }
                        _loc7_ = _loc21_.polygons.polygon is Array ? _loc21_.polygons.polygon : [_loc21_.polygons.polygon];
                        for each(_loc22_ in _loc7_)
                        {
                           _loc8_ = new Vector.<Vec2>();
                           _loc9_ = _loc22_.split(",");
                           _loc10_ = 0;
                           while(_loc10_ < _loc9_.length)
                           {
                              _loc11_ = new Vec2(new Number(StringUtil.trim(_loc9_[_loc10_])),new Number(StringUtil.trim(_loc9_[_loc10_ + 1])));
                              _loc8_.push(_loc11_);
                              _loc10_ += 2;
                           }
                           _loc12_ = new Polygon(_loc8_);
                           _loc12_.material = _loc5_.copy();
                           _loc4_.push(_loc12_);
                        }
                        break;
                     default:
                        throw new Error("No shape defined for fixture for resource Id: " + param1 + " in file: " + _loc13_);
                  }
               }
               this.materialCache[param1] = _loc4_;
               return this.materialCache[param1];
            }
         }
         _loc2_ = "resource Id: " + param1 + " not found in loaded resources for manager";
         LogUtils.log(_loc2_,this,3,"All",true,true);
         if(Config.debugMode)
         {
            throw new Error(_loc2_);
         }
         return null;
      }
   }
}

