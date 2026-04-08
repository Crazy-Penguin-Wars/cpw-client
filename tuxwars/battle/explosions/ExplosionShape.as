package tuxwars.battle.explosions
{
   import com.dchoc.utils.*;
   import nape.geom.*;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.*;
   import tuxwars.battle.data.explosions.ExplosionShapeReference;
   
   public class ExplosionShape
   {
      private static const CIRCLE_RAD:Number = 6.283185307179586;
      
      private static const SECRET:Number = Math.random();
      
      private const points:Vector.<Vec2> = new Vector.<Vec2>();
      
      private var radius:int;
      
      public function ExplosionShape(param1:Number)
      {
         super();
         if(SECRET != param1)
         {
            throw new Error("This class isn\'t meant to be instantiated from the outside.");
         }
      }
      
      public static function generate(param1:ExplosionShapeReference) : ExplosionShape
      {
         assert("The maxRadius is bigger than minRadius",true,param1.getMaxRadius() > param1.getMinRadius());
         assert("The angle isn\'t within the circle, 0 <= angle <= 360",true,param1.getAngle() >= 0 && param1.getAngle() <= 360);
         var _loc2_:ExplosionShape = new ExplosionShape(SECRET);
         _loc2_.generatePoints(param1.getMinRadius(),param1.getMaxRadius(),param1.getAngle());
         return _loc2_;
      }
      
      public function getRadius() : int
      {
         return this.radius;
      }
      
      public function getPoints() : Vector.<Vec2>
      {
         return this.points;
      }
      
      private function generatePoints(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = Number(MathUtils.degreesToRadians(param3));
         LogUtils.log("Call to random generatePoints()",this,0,"Random",false,false,false);
         var _loc7_:Random = BattleManager.getRandom();
         while(_loc5_ < 6.283185307179586)
         {
            _loc4_ = _loc7_.integer(param1,param2);
            this.points.push(Vec2.fromPolar(_loc4_,_loc5_));
            _loc5_ += _loc6_;
            if(_loc4_ > this.radius)
            {
               this.radius = _loc4_;
            }
         }
      }
   }
}

