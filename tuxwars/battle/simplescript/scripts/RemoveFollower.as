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
      
      public function run(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var _loc6_:* = null;
         var _loc4_:PhysicsGameObject = params.pgoA;
         var _loc3_:Array = scriptObject.variables[1] is Array ? scriptObject.variables[1] : [scriptObject.variables[1]];
         for each(var followerId in _loc3_)
         {
            _loc6_ = _loc4_.getFollower(followerId);
            if(_loc6_)
            {
               _loc6_.markForRemoval();
            }
         }
         return null;
      }
   }
}
