package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.LogUtils;
   import flash.geom.Point;
   import nape.constraint.Constraint;
   import nape.constraint.DistanceJoint;
   import nape.constraint.PivotJoint;
   import nape.constraint.WeldJoint;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.TerrainGameObject;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   import tuxwars.battle.world.loader.Joint;
   
   public class AddJoint implements SimpleScriptCore
   {
       
      
      public function AddJoint()
      {
         super();
      }
      
      public function run(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var _loc10_:* = null;
         var _loc8_:* = null;
         var j:* = null;
         var a:* = null;
         var b:* = null;
         var joint:* = null;
         var jointMax:Number = NaN;
         var jointMin:Number = NaN;
         if(scriptObject.variables[1] is PhysicsGameObject && scriptObject.variables[2] is PhysicsGameObject)
         {
            _loc10_ = scriptObject.variables[1];
            _loc8_ = scriptObject.variables[2];
            j = params.data as Joint;
            if(!j)
            {
               return createNewPivotJoint(_loc10_,_loc8_);
            }
            a = _loc10_.body;
            if(_loc10_ is TerrainGameObject)
            {
               a = (_loc10_ as TerrainGameObject).getBodyAt(j.startPoint.x,j.startPoint.y);
            }
            b = _loc8_.body;
            if(_loc8_ is TerrainGameObject)
            {
               b = (_loc8_ as TerrainGameObject).getBodyAt(j.endPoint.x,j.endPoint.y);
            }
            if(!a || !b)
            {
               LogUtils.log("Body not found for the joint:" + j.id,this,1,"GameObjects");
               return;
            }
            switch(j.type)
            {
               case "Distance":
                  jointMax = calculateDistance(j.startPoint,j.endPoint);
                  jointMin = jointMax * j.minDistancePercentage / 100;
                  joint = new DistanceJoint(a,b,a.worldPointToLocal(Vec2.get(j.startPoint.x,j.startPoint.y)),b.worldPointToLocal(Vec2.get(j.endPoint.x,j.endPoint.y)),jointMin,jointMax);
                  break;
               case "Pivot":
                  if(b is TerrainGameObject)
                  {
                     joint = new PivotJoint(a,b,a.worldPointToLocal(Vec2.get(j.endPoint.x,j.endPoint.y),true),b.worldPointToLocal(Vec2.get(j.endPoint.x,j.endPoint.y),true));
                     break;
                  }
                  joint = new PivotJoint(a,b,a.worldPointToLocal(Vec2.get(j.startPoint.x,j.startPoint.y),true),b.worldPointToLocal(Vec2.get(j.startPoint.x,j.startPoint.y),true));
                  break;
               case "Weld":
                  joint = new WeldJoint(a,b,a.worldPointToLocal(Vec2.get(j.startPoint.x,j.startPoint.y),true),b.worldPointToLocal(Vec2.get(j.startPoint.x,j.startPoint.y),true));
                  break;
               default:
                  return null;
            }
            joint.ignore = j.ignoreCollision;
            joint.stiff = !j.elastic;
            joint.frequency = j.elasticFrequency;
            joint.damping = j.elasticDamping;
            return joint;
         }
         return null;
      }
      
      private function createNewPivotJoint(a:PhysicsGameObject, b:PhysicsGameObject, joinData:Joint = null) : PivotJoint
      {
         return new PivotJoint(a.body,b.body,a.body.worldPointToLocal(a.body.position,true),b.body.worldPointToLocal(b.body.position,true));
      }
      
      private function calculateDistance(point1:Point, point2:Point) : Number
      {
         var distanceX:Number = point1.x - point2.x;
         var distanceY:Number = point1.y - point2.y;
         return Math.sqrt(distanceX * distanceX + distanceY * distanceY);
      }
   }
}
