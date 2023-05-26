package tuxwars.battle.gameobjects
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.resources.DCResourceManager;
   import nape.space.Space;
   import tuxwars.battle.world.loader.LevelPowerUp;
   import tuxwars.battle.world.loader.LevelPowerUpResult;
   
   public class PowerUpGameObjectDef extends PhysicsEmissionGameObjectDef
   {
       
      
      private var _powerUp:LevelPowerUp;
      
      private var _result:LevelPowerUpResult;
      
      private var _followers:Array;
      
      public function PowerUpGameObjectDef(space:Space, pu:LevelPowerUp)
      {
         super(space);
         _powerUp = pu;
         objClass = PowerUpGameObject;
         name = _powerUp.getName();
         id = _powerUp.id;
         graphics = new GraphicsReference(null);
         graphics.swf = _powerUp.getPowerUpObjectPhysics().graphics.swf;
         graphics.export = _powerUp.getPowerUpObjectPhysics().graphics.export;
         if(!DCResourceManager.instance.isLoaded(graphics.swf))
         {
            DCResourceManager.instance.load(Config.getDataDir() + graphics.swf,graphics.swf,null,true);
         }
         _result = _powerUp.getResult();
         playerAttackValue = new Stat(id,0);
         emissions = _result.emissions;
         _followers = _result.followers;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _powerUp = null;
         _result = null;
         _followers = null;
      }
      
      public function get powerUp() : LevelPowerUp
      {
         return _powerUp;
      }
      
      public function get powerUpResult() : LevelPowerUpResult
      {
         return _result;
      }
      
      public function get followers() : Array
      {
         return _followers;
      }
   }
}
