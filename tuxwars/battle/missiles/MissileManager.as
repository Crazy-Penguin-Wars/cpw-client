package tuxwars.battle.missiles
{
   import com.dchoc.gameobjects.stats.Stat;
   import nape.geom.Vec2;
   import tuxwars.battle.data.missiles.MissileData;
   import tuxwars.battle.data.missiles.Missiles;
   import tuxwars.battle.world.PhysicsWorld;
   
   public class MissileManager
   {
       
      
      public function MissileManager()
      {
         super();
      }
      
      public static function createMissile(type:String, loc:Vec2, world:PhysicsWorld, firingObjectsAttack:Stat) : Missile
      {
         return world.createGameObject(createMissileDef(type,loc,world,firingObjectsAttack));
      }
      
      public static function createMissileDef(type:String, loc:Vec2, world:PhysicsWorld, firingObjectsAttack:Stat) : MissileDef
      {
         return createMissileDefFromData(Missiles.getMissileData(type),loc,world,firingObjectsAttack);
      }
      
      public static function createMissileDefFromData(missileData:MissileData, loc:Vec2, world:PhysicsWorld, firingObjectsAttack:Stat) : MissileDef
      {
         var _loc5_:MissileDef = new MissileDef(world.space);
         _loc5_.loadDataConf(missileData);
         _loc5_.position = loc.copy();
         _loc5_.playerAttackValue = firingObjectsAttack;
         return _loc5_;
      }
   }
}
