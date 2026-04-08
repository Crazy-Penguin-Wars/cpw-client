package tuxwars.battle.missiles
{
   import com.dchoc.gameobjects.stats.Stat;
   import nape.geom.Vec2;
   import tuxwars.battle.data.missiles.*;
   import tuxwars.battle.world.PhysicsWorld;
   
   public class MissileManager
   {
      public function MissileManager()
      {
         super();
      }
      
      public static function createMissile(param1:String, param2:Vec2, param3:PhysicsWorld, param4:Stat) : Missile
      {
         return param3.createGameObject(createMissileDef(param1,param2,param3,param4));
      }
      
      public static function createMissileDef(param1:String, param2:Vec2, param3:PhysicsWorld, param4:Stat) : MissileDef
      {
         return createMissileDefFromData(Missiles.getMissileData(param1),param2,param3,param4);
      }
      
      public static function createMissileDefFromData(param1:MissileData, param2:Vec2, param3:PhysicsWorld, param4:Stat) : MissileDef
      {
         var _loc5_:MissileDef = new MissileDef(param3.space);
         _loc5_.loadDataConf(param1);
         _loc5_.position = param2.copy();
         _loc5_.playerAttackValue = param4;
         return _loc5_;
      }
   }
}

