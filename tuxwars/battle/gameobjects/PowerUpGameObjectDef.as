package tuxwars.battle.gameobjects
{
   import com.dchoc.data.*;
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.resources.*;
   import nape.space.Space;
   import tuxwars.battle.world.loader.LevelPowerUp;
   import tuxwars.battle.world.loader.LevelPowerUpResult;
   
   public class PowerUpGameObjectDef extends PhysicsEmissionGameObjectDef
   {
      private var _powerUp:LevelPowerUp;
      
      private var _result:LevelPowerUpResult;
      
      private var _followers:Array;
      
      public function PowerUpGameObjectDef(param1:Space, param2:LevelPowerUp)
      {
         super(param1);
         this._powerUp = param2;
         objClass = PowerUpGameObject;
         name = this._powerUp.getName();
         id = this._powerUp.id;
         graphics = new GraphicsReference(null);
         graphics.swf = this._powerUp.getPowerUpObjectPhysics().graphics.swf;
         graphics.export = this._powerUp.getPowerUpObjectPhysics().graphics.export;
         if(!DCResourceManager.instance.isLoaded(graphics.swf))
         {
            DCResourceManager.instance.load(Config.getDataDir() + graphics.swf,graphics.swf,null,true);
         }
         this._result = this._powerUp.getResult();
         playerAttackValue = new Stat(id,0);
         emissions = this._result.emissions;
         this._followers = this._result.followers;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._powerUp = null;
         this._result = null;
         this._followers = null;
      }
      
      public function get powerUp() : LevelPowerUp
      {
         return this._powerUp;
      }
      
      public function get powerUpResult() : LevelPowerUpResult
      {
         return this._result;
      }
      
      public function get followers() : Array
      {
         return this._followers;
      }
   }
}

