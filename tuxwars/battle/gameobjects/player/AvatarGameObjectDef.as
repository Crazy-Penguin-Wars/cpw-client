package tuxwars.battle.gameobjects.player
{
   import com.dchoc.data.GameData;
   import nape.space.Space;
   import tuxwars.battle.gameobjects.PhysicsGameObjectDef;
   
   public class AvatarGameObjectDef extends PhysicsGameObjectDef
   {
       
      
      private var _animationAssets:String;
      
      public function AvatarGameObjectDef(world:Space)
      {
         super(world);
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         animationAssets = graphics.swf;
         graphics = null;
      }
      
      public function get animationAssets() : String
      {
         return _animationAssets;
      }
      
      public function set animationAssets(assets:String) : void
      {
         _animationAssets = assets;
      }
   }
}
