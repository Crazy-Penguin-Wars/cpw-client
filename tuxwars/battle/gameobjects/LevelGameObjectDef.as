package tuxwars.battle.gameobjects
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.resources.DCResourceManager;
   import nape.space.Space;
   import tuxwars.battle.world.loader.Element;
   
   public class LevelGameObjectDef extends PhysicsGameObjectDef
   {
       
      
      private var element:Element;
      
      public function LevelGameObjectDef(world:Space, element:Element)
      {
         super(world);
         this.element = element;
         objClass = LevelGameObject;
         name = element.getDynamicElementPhysics().getName();
         id = element.id;
         graphics = new GraphicsReference(null);
         graphics.swf = element.getDynamicElementPhysics().getLevelObjectData().graphics.swf;
         graphics.export = element.getDynamicElementPhysics().getLevelObjectData().graphics.export;
         if(!DCResourceManager.instance.isLoaded(graphics.swf))
         {
            DCResourceManager.instance.load(Config.getDataDir() + graphics.swf,graphics.swf,null,true);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         element.dispose();
         element = null;
      }
      
      public function getElement() : Element
      {
         return element;
      }
   }
}
