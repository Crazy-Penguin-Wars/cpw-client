package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import nape.geom.Ray;
   import nape.geom.RayResult;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.assert;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.emitters.EmitterUtils;
   import tuxwars.battle.gameobjects.EmissionSpawn;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.missiles.Missile;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   import tuxwars.battle.world.PhysicsWorld;
   
   public class Ray implements SimpleScriptCore
   {
      
      private static const UNLIMITED_HITS:int = -1;
      
      private static var tuxGame:TuxWarsGame;
       
      
      private const hits:Vector.<Array> = new Vector.<Array>();
      
      private var firingPlayer:PlayerGameObject;
      
      private var missile:Missile;
      
      private var affects:Array;
      
      public function Ray()
      {
         super();
      }
      
      private static function handleSendGame(msg:Message) : void
      {
         tuxGame = msg.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
      
      public function run(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var _loc6_:* = null;
         var _loc13_:* = null;
         var _loc4_:* = null;
         var _loc11_:* = null;
         var _loc14_:* = null;
         var _loc12_:* = null;
         var _loc15_:int = 0;
         var i:int = 0;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         assert("Must be an Missile",true,scriptObject is Missile);
         assert("No variables",true,scriptObject.variables != null);
         assert("Not correct amount of variables",true,scriptObject.variables.length >= 3);
         MessageCenter.addListener("SendGame",handleSendGame);
         MessageCenter.sendMessage("GetGame");
         assert("No TuxGame",true,tuxGame != null);
         assert("No TuxWorld",true,tuxGame.tuxWorld != null);
         assert("No PhysicsWorld",true,tuxGame.tuxWorld.physicsWorld != null);
         var _loc10_:PhysicsWorld = tuxGame.tuxWorld.physicsWorld;
         var hitsCount:int = int(scriptObject.variables[1]);
         affects = scriptObject.variables[2] is Array ? scriptObject.variables[2] : [scriptObject.variables[2]];
         missile = scriptObject as Missile;
         firingPlayer = !!missile.tagger ? missile.tagger.gameObject as PlayerGameObject : null;
         if(firingPlayer)
         {
            _loc6_ = missile.location;
            _loc13_ = missile.locationOriginal;
            _loc4_ = new nape.geom.Ray(_loc6_,_loc13_.sub(_loc6_));
            _loc11_ = _loc10_.space.rayMultiCast(_loc4_);
            if(hitsCount == -1 || hitsCount > _loc11_.length)
            {
               hitsCount = _loc11_.length;
            }
            _loc14_ = missile.getEmissionsParams("Params");
            _loc12_ = _loc14_ != null && _loc14_.dir != null ? _loc14_.dir : null;
            _loc15_ = int(_loc14_ != null && _loc14_.power != null ? _loc14_.power : 0);
            for(i = 0; i < hitsCount; )
            {
               _loc3_ = _loc11_.at(i);
               if(EmitterUtils.affectsObject(affects,firingPlayer,_loc3_.shape.body.userData.gameObject as PhysicsGameObject))
               {
                  _loc8_ = _loc4_.at(_loc3_.distance);
                  _loc9_ = new EmissionSpawn(missile,_loc8_,missile.tag.findLatestPlayerTagger());
                  _loc9_.emitLocation = _loc8_.copy();
                  if(_loc12_)
                  {
                     _loc9_.setEmissionsParams("Params",{
                        "dir":_loc12_,
                        "powerBar":_loc15_
                     });
                  }
                  _loc9_.triggerEmission();
               }
               i++;
            }
         }
         else
         {
            LogUtils.log("No firingPlayer for missile: " + missile.shortName,this,2,"SimpleScript",true,true,false);
         }
         tuxGame = null;
         firingPlayer = null;
         return null;
      }
   }
}
