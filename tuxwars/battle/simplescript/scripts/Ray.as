package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.geom.Ray;
   import nape.geom.RayResult;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.missiles.*;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   import tuxwars.battle.world.PhysicsWorld;
   
   public class Ray implements SimpleScriptCore
   {
      private static var tuxGame:TuxWarsGame;
      
      private static const UNLIMITED_HITS:int = -1;
      
      private const hits:Vector.<Array> = new Vector.<Array>();
      
      private var firingPlayer:PlayerGameObject;
      
      private var missile:Missile;
      
      private var affects:Array;
      
      public function Ray()
      {
         super();
      }
      
      private static function handleSendGame(param1:Message) : void
      {
         tuxGame = param1.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
      
      public function run(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         var _loc3_:Vec2 = null;
         var _loc4_:Vec2 = null;
         var _loc5_:nape.geom.Ray = null;
         var _loc6_:RayResultList = null;
         var _loc7_:Object = null;
         var _loc8_:Vec2 = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:RayResult = null;
         var _loc12_:Vec2 = null;
         var _loc13_:EmissionSpawn = null;
         assert("Must be an Missile",true,param1 is Missile);
         assert("No variables",true,param1.variables != null);
         assert("Not correct amount of variables",true,param1.variables.length >= 3);
         MessageCenter.addListener("SendGame",handleSendGame);
         MessageCenter.sendMessage("GetGame");
         assert("No TuxGame",true,tuxGame != null);
         assert("No TuxWorld",true,tuxGame.tuxWorld != null);
         assert("No PhysicsWorld",true,tuxGame.tuxWorld.physicsWorld != null);
         var _loc14_:PhysicsWorld = tuxGame.tuxWorld.physicsWorld;
         var _loc15_:int = int(param1.variables[1]);
         this.affects = param1.variables[2] is Array ? param1.variables[2] : [param1.variables[2]];
         this.missile = param1 as Missile;
         this.firingPlayer = !!this.missile.tagger ? this.missile.tagger.gameObject as PlayerGameObject : null;
         if(this.firingPlayer)
         {
            _loc3_ = this.missile.location;
            _loc4_ = this.missile.locationOriginal;
            _loc5_ = new nape.geom.Ray(_loc3_,_loc4_.sub(_loc3_));
            _loc6_ = _loc14_.space.rayMultiCast(_loc5_);
            if(_loc15_ == -1 || _loc15_ > _loc6_.length)
            {
               _loc15_ = _loc6_.length;
            }
            _loc7_ = this.missile.getEmissionsParams("Params");
            _loc8_ = _loc7_ != null && _loc7_.dir != null ? _loc7_.dir : null;
            _loc9_ = int(_loc7_ != null && _loc7_.power != null ? _loc7_.power : 0);
            _loc10_ = 0;
            while(_loc10_ < _loc15_)
            {
               _loc11_ = _loc6_.at(_loc10_);
               if(EmitterUtils.affectsObject(this.affects,this.firingPlayer,_loc11_.shape.body.userData.gameObject as PhysicsGameObject))
               {
                  _loc12_ = _loc5_.at(_loc11_.distance);
                  _loc13_ = new EmissionSpawn(this.missile,_loc12_,this.missile.tag.findLatestPlayerTagger());
                  _loc13_.emitLocation = _loc12_.copy();
                  if(_loc8_)
                  {
                     _loc13_.setEmissionsParams("Params",{
                        "dir":_loc8_,
                        "powerBar":_loc9_
                     });
                  }
                  _loc13_.triggerEmission();
               }
               _loc10_++;
            }
         }
         else
         {
            LogUtils.log("No firingPlayer for missile: " + this.missile.shortName,this,2,"SimpleScript",true,true,false);
         }
         tuxGame = null;
         this.firingPlayer = null;
         return null;
      }
   }
}

