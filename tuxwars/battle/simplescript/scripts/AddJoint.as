package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.*;
   import flash.geom.Point;
   import nape.constraint.*;
   import nape.geom.*;
   import nape.phys.Body;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   import tuxwars.battle.world.loader.*;
   
   public class AddJoint implements SimpleScriptCore
   {
      public function AddJoint()
      {
         super();
      }
      
      public function run(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         var _loc3_:PhysicsGameObject = null;
         var _loc4_:PhysicsGameObject = null;
         var _loc5_:Joint = null;
         var _loc6_:Body = null;
         var _loc7_:Body = null;
         var _loc8_:Constraint = null;
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         if(param1.variables[1] is PhysicsGameObject && param1.variables[2] is PhysicsGameObject)
         {
            _loc3_ = param1.variables[1];
            _loc4_ = param1.variables[2];
            _loc5_ = param2.data as Joint;
            if(!_loc5_)
            {
               return this.createNewPivotJoint(_loc3_,_loc4_);
            }
            _loc6_ = _loc3_.body;
            if(_loc3_ is TerrainGameObject)
            {
               _loc6_ = (_loc3_ as TerrainGameObject).getBodyAt(_loc5_.startPoint.x,_loc5_.startPoint.y);
            }
            _loc7_ = _loc4_.body;
            if(_loc4_ is TerrainGameObject)
            {
               _loc7_ = (_loc4_ as TerrainGameObject).getBodyAt(_loc5_.endPoint.x,_loc5_.endPoint.y);
            }
            if(!_loc6_ || !_loc7_)
            {
               LogUtils.log("Body not found for the joint:" + _loc5_.id,this,1,"GameObjects");
               return;
            }
            switch(_loc5_.type)
            {
               case "Distance":
                  _loc9_ = Number(this.calculateDistance(_loc5_.startPoint,_loc5_.endPoint));
                  _loc10_ = _loc9_ * _loc5_.minDistancePercentage / 100;
                  _loc8_ = new DistanceJoint(_loc6_,_loc7_,_loc6_.worldPointToLocal(Vec2.get(_loc5_.startPoint.x,_loc5_.startPoint.y)),_loc7_.worldPointToLocal(Vec2.get(_loc5_.endPoint.x,_loc5_.endPoint.y)),_loc10_,_loc9_);
                  break;
               case "Pivot":
                  if(_loc7_ is TerrainGameObject)
                  {
                     _loc8_ = new PivotJoint(_loc6_,_loc7_,_loc6_.worldPointToLocal(Vec2.get(_loc5_.endPoint.x,_loc5_.endPoint.y),true),_loc7_.worldPointToLocal(Vec2.get(_loc5_.endPoint.x,_loc5_.endPoint.y),true));
                  }
                  else
                  {
                     _loc8_ = new PivotJoint(_loc6_,_loc7_,_loc6_.worldPointToLocal(Vec2.get(_loc5_.startPoint.x,_loc5_.startPoint.y),true),_loc7_.worldPointToLocal(Vec2.get(_loc5_.startPoint.x,_loc5_.startPoint.y),true));
                  }
                  break;
               case "Weld":
                  _loc8_ = new WeldJoint(_loc6_,_loc7_,_loc6_.worldPointToLocal(Vec2.get(_loc5_.startPoint.x,_loc5_.startPoint.y),true),_loc7_.worldPointToLocal(Vec2.get(_loc5_.startPoint.x,_loc5_.startPoint.y),true));
                  break;
               default:
                  return null;
            }
            _loc8_.ignore = _loc5_.ignoreCollision;
            _loc8_.stiff = !_loc5_.elastic;
            _loc8_.frequency = _loc5_.elasticFrequency;
            _loc8_.damping = _loc5_.elasticDamping;
            return _loc8_;
         }
         return null;
      }
      
      private function createNewPivotJoint(param1:PhysicsGameObject, param2:PhysicsGameObject, param3:Joint = null) : PivotJoint
      {
         return new PivotJoint(param1.body,param2.body,param1.body.worldPointToLocal(param1.body.position,true),param2.body.worldPointToLocal(param2.body.position,true));
      }
      
      private function calculateDistance(param1:Point, param2:Point) : Number
      {
         var _loc3_:Number = param1.x - param2.x;
         var _loc4_:Number = param1.y - param2.y;
         return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
      }
   }
}

