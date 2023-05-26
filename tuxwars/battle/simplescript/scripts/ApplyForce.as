package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.assert;
   import org.as3commons.lang.StringUtils;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class ApplyForce implements SimpleScriptCore
   {
       
      
      public function ApplyForce()
      {
         super();
      }
      
      public function run(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var _loc3_:Boolean = false;
         assert("too few variables, needs (name, boolean, boolean, x, y)",true,scriptObject.variables.length >= 5);
         assert("params is not a PhysicsGameObject",true,params.pgoA is PhysicsGameObject);
         var _loc5_:Vec2 = new Vec2(scriptObject.variables[3],scriptObject.variables[4]);
         var _loc4_:PhysicsGameObject = params.pgoA;
         if(_loc4_.body && _loc5_.length > 0)
         {
            _loc3_ = StringUtils.trim((scriptObject.variables[2] as String).toLowerCase()) == "true";
            if(_loc3_)
            {
               if(_loc4_ is PlayerGameObject)
               {
                  if((_loc4_ as PlayerGameObject).moveControls.isFallingDown())
                  {
                     apply(_loc4_,_loc5_);
                  }
               }
               else if(_loc4_.linearVelocity.y > 0.5)
               {
                  apply(_loc4_,_loc5_);
               }
            }
            else
            {
               apply(_loc4_,_loc5_);
            }
         }
         return null;
      }
      
      private function apply(physicsGameObject:PhysicsGameObject, forceVector:Vec2) : void
      {
         var _loc3_:* = physicsGameObject;
         LogUtils.log("Applying Impulse: " + forceVector + " to: " + physicsGameObject.shortName + " bodyloc: " + physicsGameObject.bodyLocation + " world step: " + (_loc3_.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"SimpleScript",false,false,false);
         physicsGameObject.body.applyImpulse(forceVector);
      }
   }
}
