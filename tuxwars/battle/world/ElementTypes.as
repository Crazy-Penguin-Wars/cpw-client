package tuxwars.battle.world
{
   public class ElementTypes
   {
      
      public static const TERRAIN:String = "TerrainBlockEntity";
      
      public static const DYNAMIC_OBJECT:String = "DynamicObject";
       
      
      public function ElementTypes()
      {
         super();
         throw new Error("ElementTypes is a static class!");
      }
   }
}
