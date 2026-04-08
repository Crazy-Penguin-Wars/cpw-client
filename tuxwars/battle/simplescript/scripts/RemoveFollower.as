package tuxwars.battle.simplescript.scripts
{
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class RemoveFollower implements SimpleScriptCore
   {
      public function RemoveFollower()
      {
         super();
      }
      
      public function run(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         var _loc6_:* = undefined;
         var _loc3_:Follower = null;
         var _loc4_:PhysicsGameObject = param2.pgoA;
         var _loc5_:Array = param1.variables[1] is Array ? param1.variables[1] : [param1.variables[1]];
         for each(_loc6_ in _loc5_)
         {
            _loc3_ = _loc4_.getFollower(_loc6_);
            if(_loc3_)
            {
               _loc3_.markForRemoval();
            }
         }
         return null;
      }
   }
}

