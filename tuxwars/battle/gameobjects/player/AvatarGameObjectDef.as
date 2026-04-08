package tuxwars.battle.gameobjects.player
{
   import com.dchoc.data.GameData;
   import nape.space.Space;
   import tuxwars.battle.gameobjects.PhysicsGameObjectDef;
   
   public class AvatarGameObjectDef extends PhysicsGameObjectDef
   {
      private var _animationAssets:String;
      
      public function AvatarGameObjectDef(param1:Space)
      {
         super(param1);
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         this.animationAssets = graphics.swf;
         graphics = null;
      }
      
      public function get animationAssets() : String
      {
         return this._animationAssets;
      }
      
      public function set animationAssets(param1:String) : void
      {
         this._animationAssets = param1;
      }
   }
}

