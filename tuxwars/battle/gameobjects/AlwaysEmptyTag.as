package tuxwars.battle.gameobjects
{
   public class AlwaysEmptyTag extends Tag
   {
       
      
      public function AlwaysEmptyTag(physGameObject:PhysicsGameObject)
      {
         super(physGameObject);
      }
      
      override public function add(gameObject:PhysicsGameObject) : void
      {
      }
      
      override public function update(other:Tag) : void
      {
      }
      
      override public function get latestTagger() : Tagger
      {
         return null;
      }
   }
}
