package tuxwars.battle.world
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MathUtils;
   import flash.xml.XMLDocument;
   import mx.rpc.xml.SimpleXMLDecoder;
   import mx.utils.StringUtil;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyType;
   import nape.phys.Material;
   import nape.shape.Circle;
   import nape.shape.Polygon;
   import nape.shape.Shape;
   import nape.space.Space;
   
   public class DynamicBodyManager
   {
      
      private static const SHAPE_CIRCLE:String = "CIRCLE";
      
      private static const SHAPE_POLYGON:String = "POLYGON";
       
      
      private var _id:String;
      
      private var file:String;
      
      private var materialCache:Object;
      
      private var resourceToFileLinking:Object;
      
      public function DynamicBodyManager(id:String, file:String)
      {
         var _loc3_:* = null;
         super();
         _id = id;
         this.file = file;
         materialCache = {};
         resourceToFileLinking = {};
         var _loc6_:SimpleXMLDecoder = new SimpleXMLDecoder();
         var fileContent:String = DCResourceManager.instance.get(file);
         var xmlObj:Object = _loc6_.decodeXML(new XMLDocument(fileContent));
         if(xmlObj == null)
         {
            LogUtils.log("XML object is null in file: " + file,this,3);
            return;
         }
         if(xmlObj.bodydef == null)
         {
            LogUtils.log("bodydef parameter in xml is null in file: " + file,this,3);
            return;
         }
         if(xmlObj.bodydef.bodies == null)
         {
            LogUtils.log("bodies parameter in xml is null in file: " + file,this,3);
            return;
         }
         if(xmlObj.bodydef.bodies.body == null)
         {
            LogUtils.log("bodyArray parameter in xml is null in file: " + file,this,3);
            return;
         }
         var _loc7_:Array = xmlObj.bodydef.bodies.body is Array ? xmlObj.bodydef.bodies.body : [xmlObj.bodydef.bodies.body];
         for each(var fixtureDefArray in _loc7_)
         {
            if(fixtureDefArray == null)
            {
               LogUtils.log("singleBody parameter in xml is null in file: " + file,this,3);
               return;
            }
            if(fixtureDefArray.name == null)
            {
               LogUtils.log("name parameter in xml is null in file: " + file,this,3);
               return;
            }
            if(resourceToFileLinking[fixtureDefArray.name] == null)
            {
               resourceToFileLinking[fixtureDefArray.name] = file;
               getShapes(fixtureDefArray.name);
            }
            else
            {
               _loc3_ = "Duplicate recource name: " + fixtureDefArray.name + " in <file1: " + file + "> and <file2: " + resourceToFileLinking[fixtureDefArray.name] + ">";
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
         for(var str in materialCache)
         {
            materialCache[str].destroy();
         }
         DCUtils.deleteProperties(materialCache);
         DCUtils.deleteProperties(resourceToFileLinking);
      }
      
      public function createBody(resourceName:String, space:Space, position:Vec2, userData:*, angle:Number = 0, fixedRotation:Boolean = false) : Body
      {
         var _loc7_:Body = new Body(BodyType.DYNAMIC);
         var _loc9_:Array = getShapes(resourceName);
         for each(var shape in _loc9_)
         {
            _loc7_.shapes.add(shape.copy());
         }
         _loc7_.rotation = MathUtils.degreesToRadians(angle);
         _loc7_.allowRotation = !fixedRotation;
         _loc7_.position = position.copy(true);
         _loc7_.userData.gameObject = userData;
         _loc7_.space = space;
         return _loc7_;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function getFile() : String
      {
         return file;
      }
      
      public function getMaterial(resourceName:String) : Material
      {
         if(materialCache[resourceName] == null)
         {
            return null;
         }
         var _loc2_:Material = materialCache[resourceName][0];
         return _loc2_.copy();
      }
      
      public function getShapes(resourceName:String) : Array
      {
         var message:* = null;
         var containedShapeInfo:* = null;
         var shapes:* = null;
         var _loc11_:* = null;
         var _loc8_:* = null;
         var polygons:* = null;
         var _loc2_:* = undefined;
         var a:* = null;
         var index:int = 0;
         var _loc14_:* = null;
         var _loc18_:* = null;
         if(materialCache[resourceName] != null)
         {
            return materialCache[resourceName];
         }
         var fileName:String = resourceToFileLinking[resourceName];
         if(fileName == null)
         {
            var _loc30_:Object = resourceToFileLinking;
            var _loc20_:LogUtils = LogUtils;
            var _loc29_:String = "";
            var _loc22_:int = 0;
            var _loc21_:* = _loc30_;
            §§push("File name containing resource Id: " + resourceName + " not found, list of linkings found in manager: ");
            for(var _loc31_ in _loc21_)
            {
               if(avmplus.getQualifiedClassName(_loc30_[_loc31_]) == avmplus.getQualifiedClassName(Object))
               {
                  _loc29_ += "<" + _loc31_ + ": " + com.dchoc.utils.LogUtils.getObjectContent(_loc30_[_loc31_]) + ">";
               }
               else if(_loc30_[_loc31_] is String)
               {
                  _loc29_ += "<" + _loc31_ + ": " + _loc30_[_loc31_].toString() + ">";
               }
               else
               {
                  _loc29_ += "<" + _loc31_ + ": " + avmplus.getQualifiedClassName(_loc30_[_loc31_]) + ">";
               }
            }
            message = §§pop() + _loc29_;
            LogUtils.log(message,this,3,"All",true,true);
            if(Config.debugMode)
            {
               throw new Error(message);
            }
            return null;
         }
         var fileContent:String = DCResourceManager.instance.get(fileName);
         var xmlObj:Object = new SimpleXMLDecoder().decodeXML(new XMLDocument(fileContent));
         if(fileName == null)
         {
            message = "xml object corrupt or null for Id: " + resourceName + " in file: " + fileName;
            LogUtils.log(message,this,3,"All",true,true);
            if(Config.debugMode)
            {
               throw new Error(message);
            }
            return null;
         }
         var containedBodies:Array = xmlObj.bodydef.bodies.body is Array ? xmlObj.bodydef.bodies.body : [xmlObj.bodydef.bodies.body];
         for each(var singleBody in containedBodies)
         {
            if(singleBody.name == resourceName)
            {
               if(singleBody.fixtures == null)
               {
                  LogUtils.log("fixtures parameter is null for resource Id: " + resourceName + " in file: " + fileName,this,3);
                  return null;
               }
               if(singleBody.fixtures.fixture == null)
               {
                  LogUtils.log("fixtureArray parameter is null for resource Id: " + resourceName + " in file: " + fileName,this,3);
                  return null;
               }
               containedShapeInfo = singleBody.fixtures.fixture is Array ? singleBody.fixtures.fixture : [singleBody.fixtures.fixture];
               shapes = [];
               for each(var singleFixture in containedShapeInfo)
               {
                  if(singleFixture == null)
                  {
                     LogUtils.log("singleFixture parameter is null for resource Id: " + resourceName + " in file: " + fileName,this,3);
                     return null;
                  }
                  if(singleFixture.density == null)
                  {
                     LogUtils.log("density parameter is null for resource Id: " + resourceName + " in file: " + fileName,this,3);
                     return null;
                  }
                  if(singleFixture.friction == null)
                  {
                     LogUtils.log("friction parameter is null for resource Id: " + resourceName + " in file: " + fileName,this,3);
                     return null;
                  }
                  if(singleFixture.restitution == null)
                  {
                     LogUtils.log("restitution parameter is null for resource Id: " + resourceName + " in file: " + fileName,this,3);
                     return null;
                  }
                  if(singleFixture.fixture_type == null)
                  {
                     LogUtils.log("fixture_type parameter is null for resource Id: " + resourceName + " in file: " + fileName,this,3);
                     return null;
                  }
                  _loc11_ = new Material();
                  _loc11_.density = singleFixture.density;
                  _loc11_.dynamicFriction = singleFixture.friction;
                  _loc11_.elasticity = singleFixture.restitution;
                  switch(singleFixture.fixture_type as String)
                  {
                     case "CIRCLE":
                        _loc8_ = new Circle(singleFixture.circle.r);
                        _loc8_.material = _loc11_.copy();
                        shapes = [_loc8_];
                        break;
                     case "POLYGON":
                        if(singleFixture.polygons == null)
                        {
                           LogUtils.log("polygons parameter is null for resource Id: " + resourceName + " in file: " + fileName,this,3);
                           return null;
                        }
                        if(singleFixture.polygons.polygon == null)
                        {
                           LogUtils.log("polygonArray parameter is null for resource Id: " + resourceName + " in file: " + fileName,this,3);
                           return null;
                        }
                        polygons = singleFixture.polygons.polygon is Array ? singleFixture.polygons.polygon : [singleFixture.polygons.polygon];
                        for each(var shapeData in polygons)
                        {
                           _loc2_ = new Vector.<Vec2>();
                           a = shapeData.split(",");
                           for(index = 0; index < a.length; )
                           {
                              _loc14_ = new Vec2(new Number(StringUtil.trim(a[index])),new Number(StringUtil.trim(a[index + 1])));
                              _loc2_.push(_loc14_);
                              index += 2;
                           }
                           _loc18_ = new Polygon(_loc2_);
                           _loc18_.material = _loc11_.copy();
                           shapes.push(_loc18_);
                        }
                        break;
                     default:
                        throw new Error("No shape defined for fixture for resource Id: " + resourceName + " in file: " + fileName);
                  }
               }
               materialCache[resourceName] = shapes;
               return materialCache[resourceName];
            }
         }
         message = "resource Id: " + resourceName + " not found in loaded resources for manager";
         LogUtils.log(message,this,3,"All",true,true);
         if(Config.debugMode)
         {
            throw new Error(message);
         }
         return null;
      }
   }
}
