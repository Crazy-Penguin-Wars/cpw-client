package tuxwars.battle.simplescript.scripts
{
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class Kill implements SimpleScriptCore
   {
      public function Kill()
      {
         super();
      }
      
      public function run(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         var _loc7_:* = undefined;
         var _loc3_:Damage = null;
         var _loc4_:PhysicsGameObject = param2.pgoA;
         var _loc5_:PlayerGameObject = param2.pgoB as PlayerGameObject;
         var _loc6_:Array = param1.variables[1] is Array ? param1.variables[1] : [param1.variables[1]];
         if(_loc4_._hasHPs)
         {
            for each(_loc7_ in _loc6_)
            {
               if(_loc4_.affectsGameObject(_loc7_,_loc5_))
               {
                  _loc3_ = new Damage(param1,"KillScript" + param1.id,param1.uniqueId,_loc4_.stats.getStat("HP").calculateRoundedValue() + 1,_loc4_.bodyLocation.copy(),_loc5_);
                  _loc4_.reduceHitPointsCumulative(_loc3_);
                  break;
               }
            }
         }
         return null;
      }
   }
}

