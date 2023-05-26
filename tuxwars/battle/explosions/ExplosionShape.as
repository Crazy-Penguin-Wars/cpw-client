package tuxwars.battle.explosions
{
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MathUtils;
   import com.dchoc.utils.Random;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.data.explosions.ExplosionShapeReference;
   
   public class ExplosionShape
   {
      
      private static const SECRET:Number = Math.random();
      
      private static const CIRCLE_RAD:Number = 6.283185307179586;
       
      
      private const points:Vector.<Vec2> = new Vector.<Vec2>();
      
      private var radius:int;
      
      public function ExplosionShape(pass:Number)
      {
         super();
         if(SECRET != pass)
         {
            throw new Error("This class isn\'t meant to be instantiated from the outside.");
         }
      }
      
      public static function generate(shapeRef:ExplosionShapeReference) : ExplosionShape
      {
         assert("The maxRadius is bigger than minRadius",true,shapeRef.getMaxRadius() > shapeRef.getMinRadius());
         assert("The angle isn\'t within the circle, 0 <= angle <= 360",true,shapeRef.getAngle() >= 0 && shapeRef.getAngle() <= 360);
         var _loc2_:ExplosionShape = new ExplosionShape(SECRET);
         _loc2_.generatePoints(shapeRef.getMinRadius(),shapeRef.getMaxRadius(),shapeRef.getAngle());
         return _loc2_;
      }
      
      public function getRadius() : int
      {
         return radius;
      }
      
      public function getPoints() : Vector.<Vec2>
      {
         return points;
      }
      
      private function generatePoints(minRadius:int, maxRadius:int, angle:int) : void
      {
         var _loc4_:int = 0;
         var curAngleRad:Number = 0;
         var _loc5_:Number = MathUtils.degreesToRadians(angle);
         LogUtils.log("Call to random generatePoints()",this,0,"Random",false,false,false);
         var _loc6_:Random = BattleManager.getRandom();
         while(curAngleRad < 6.283185307179586)
         {
            _loc4_ = _loc6_.integer(minRadius,maxRadius);
            points.push(Vec2.fromPolar(_loc4_,curAngleRad));
            curAngleRad += _loc5_;
            if(_loc4_ > radius)
            {
               radius = _loc4_;
            }
         }
      }
   }
}
