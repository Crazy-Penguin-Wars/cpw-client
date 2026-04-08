package tuxwars.battle.gameobjects
{
   import com.dchoc.data.*;
   import com.dchoc.resources.*;
   import nape.space.Space;
   import tuxwars.battle.world.loader.Element;
   
   public class LevelGameObjectDef extends PhysicsGameObjectDef
   {
      private var element:Element;
      
      public function LevelGameObjectDef(param1:Space, param2:Element)
      {
         super(param1);
         this.element = param2;
         objClass = LevelGameObject;
         name = param2.getDynamicElementPhysics().getName();
         id = param2.id;
         graphics = new GraphicsReference(null);
         graphics.swf = param2.getDynamicElementPhysics().getLevelObjectData().graphics.swf;
         graphics.export = param2.getDynamicElementPhysics().getLevelObjectData().graphics.export;
         if(!DCResourceManager.instance.isLoaded(graphics.swf))
         {
            DCResourceManager.instance.load(Config.getDataDir() + graphics.swf,graphics.swf,null,true);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.element.dispose();
         this.element = null;
      }
      
      public function getElement() : Element
      {
         return this.element;
      }
   }
}

