package tuxwars.battle.world.loader
{
   import flash.geom.*;
   import nape.geom.*;
   import no.olog.utilfunctions.*;
   
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
      
      public function Joint(param1:Object, param2:Level)
      {
         super();
         assert("Data is null.",true,param1 != null);
         this._id = param1.id.toString();
         this._type = param1.joint_type;
         this._ignoreCollision = param1.ignore_collision;
         this._elementA = param2.getElement(param1.element_a);
         this._elementB = param2.getElement(param1.element_b);
         this._anchorA = new Vec2(param1.startpoint_local.x,param1.startpoint_local.y);
         this._anchorB = new Vec2(param1.endpoint_local.x,param1.endpoint_local.y);
         this._elastic = param1.elastic;
         this._elasticDamping = param1.elastic_damping;
         this._elasticFrequency = param1.elastic_frequency;
         this._minDistancePercentage = param1.min_distance;
         this._startPoint = new Point(param1.startpoint.x,param1.startpoint.y);
         this._endPoint = new Point(param1.endpoint.x,param1.endpoint.y);
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get ignoreCollision() : Boolean
      {
         return this._ignoreCollision;
      }
      
      public function get minDistancePercentage() : int
      {
         return this._minDistancePercentage;
      }
      
      public function get elasticDamping() : Number
      {
         return this._elasticDamping;
      }
      
      public function get elasticFrequency() : Number
      {
         return this._elasticFrequency;
      }
      
      public function get elastic() : Boolean
      {
         return this._elastic;
      }
      
      public function dispose() : void
      {
         this._elementA = null;
         this._elementB = null;
      }
      
      public function get elementA() : Element
      {
         return this._elementA;
      }
      
      public function get elementB() : Element
      {
         return this._elementB;
      }
      
      public function get anchorA() : Vec2
      {
         return this._anchorA;
      }
      
      public function get anchorB() : Vec2
      {
         return this._anchorB;
      }
      
      public function get endPoint() : Point
      {
         return this._endPoint;
      }
      
      public function get startPoint() : Point
      {
         return this._startPoint;
      }
   }
}

