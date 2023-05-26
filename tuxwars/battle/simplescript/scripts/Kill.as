package tuxwars.battle.simplescript.scripts
{
   import tuxwars.battle.gameobjects.Damage;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class Kill implements SimpleScriptCore
   {
       
      
      public function Kill()
      {
         super();
      }
      
      public function run(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var _loc4_:* = null;
         var _loc5_:PhysicsGameObject = params.pgoA;
         var _loc6_:PlayerGameObject = params.pgoB as PlayerGameObject;
         var _loc3_:Array = scriptObject.variables[1] is Array ? scriptObject.variables[1] : [scriptObject.variables[1]];
         if(_loc5_._hasHPs)
         {
            for each(var type in _loc3_)
            {
               if(_loc5_.affectsGameObject(type,_loc6_))
               {
                  _loc4_ = new Damage(scriptObject,"KillScript" + scriptObject.id,scriptObject.uniqueId,_loc5_.stats.getStat("HP").calculateRoundedValue() + 1,_loc5_.bodyLocation.copy(),_loc6_);
                  _loc5_.reduceHitPointsCumulative(_loc4_);
                  break;
               }
            }
         }
         return null;
      }
   }
}
