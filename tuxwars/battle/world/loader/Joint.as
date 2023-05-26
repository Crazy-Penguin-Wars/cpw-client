package tuxwars.battle.world.loader
{
   import flash.geom.Point;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.assert;
   
   public class Joint
   {
      
      public static const TYPE_DISTANCE:String = "Distance";
      
      public static const TYPE_PIVOT:String = "Pivot";
      
      public static const TYPE_WELD:String = "Weld";
       
      
      private var _id:String;
      
      private var _type:String;
      
      private var _ignoreCollision:Boolean;
      
      private var _elastic:Boolean;
      
      private var _elasticFrequency:Number;
      
      private var _elasticDamping:Number;
      
      private var _minDistancePercentage:int;
      
      private var _elementA:Element;
      
      private var _elementB:Element;
      
      private var _anchorA:Vec2;
      
      private var _anchorB:Vec2;
      
      private var _startPoint:Point;
      
      private var _endPoint:Point;
      
      public function Joint(data:Object, level:Level)
      {
         super();
         assert("Data is null.",true,data != null);
         _id = data.id.toString();
         _type = data.joint_type;
         _ignoreCollision = data.ignore_collision;
         _elementA = level.getElement(data.element_a);
         _elementB = level.getElement(data.element_b);
         _anchorA = new Vec2(data.startpoint_local.x,data.startpoint_local.y);
         _anchorB = new Vec2(data.endpoint_local.x,data.endpoint_local.y);
         _elastic = data.elastic;
         _elasticDamping = data.elastic_damping;
         _elasticFrequency = data.elastic_frequency;
         _minDistancePercentage = data.min_distance;
         _startPoint = new Point(data.startpoint.x,data.startpoint.y);
         _endPoint = new Point(data.endpoint.x,data.endpoint.y);
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get ignoreCollision() : Boolean
      {
         return _ignoreCollision;
      }
      
      public function get minDistancePercentage() : int
      {
         return _minDistancePercentage;
      }
      
      public function get elasticDamping() : Number
      {
         return _elasticDamping;
      }
      
      public function get elasticFrequency() : Number
      {
         return _elasticFrequency;
      }
      
      public function get elastic() : Boolean
      {
         return _elastic;
      }
      
      public function dispose() : void
      {
         _elementA = null;
         _elementB = null;
      }
      
      public function get elementA() : Element
      {
         return _elementA;
      }
      
      public function get elementB() : Element
      {
         return _elementB;
      }
      
      public function get anchorA() : Vec2
      {
         return _anchorA;
      }
      
      public function get anchorB() : Vec2
      {
         return _anchorB;
      }
      
      public function get endPoint() : Point
      {
         return _endPoint;
      }
      
      public function get startPoint() : Point
      {
         return _startPoint;
      }
   }
}
