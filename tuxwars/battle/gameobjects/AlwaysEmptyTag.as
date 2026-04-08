package tuxwars.battle.gameobjects
{
   public class AlwaysEmptyTag extends Tag
   {
      public function AlwaysEmptyTag(param1:PhysicsGameObject)
      {
         super(param1);
      }
      
      override public function add(param1:PhysicsGameObject) : void
      {
      }
      
      override public function update(param1:Tag) : void
      {
      }
      
      override public function get latestTagger() : Tagger
      {
         return null;
      }
   }
}

