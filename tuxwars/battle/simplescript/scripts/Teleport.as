package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class Teleport implements SimpleScriptCore
   {
      public function Teleport()
      {
         super();
      }
      
      public function run(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         var _loc3_:Emission = null;
         var _loc4_:Vec2 = null;
         var _loc5_:PlayerGameObject = null;
         if(param1 is Emission)
         {
            _loc3_ = param1 as Emission;
            _loc4_ = _loc3_.location;
            _loc5_ = _loc3_.tagger.gameObject as PlayerGameObject;
            _loc5_.body.position = _loc4_;
         }
         else
         {
            LogUtils.log("Script object must be an emission","Teleport",3,"SimpleScript",false,true,true);
         }
         return null;
      }
   }
}

