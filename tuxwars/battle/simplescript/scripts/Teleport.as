package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class Teleport implements SimpleScriptCore
   {
       
      
      public function Teleport()
      {
         super();
      }
      
      public function run(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(scriptObject is Emission)
         {
            _loc5_ = scriptObject as Emission;
            _loc4_ = _loc5_.location;
            _loc3_ = _loc5_.tagger.gameObject as PlayerGameObject;
            _loc3_.body.position = _loc4_;
         }
         else
         {
            LogUtils.log("Script object must be an emission","Teleport",3,"SimpleScript",false,true,true);
         }
         return null;
      }
   }
}
