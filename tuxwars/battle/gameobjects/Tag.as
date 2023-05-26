package tuxwars.battle.gameobjects
{
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class Tag
   {
       
      
      private const _taggers:Vector.<Tagger> = new Vector.<Tagger>();
      
      private var _physGameObject:PhysicsGameObject;
      
      private var _allowClear:Boolean = true;
      
      public function Tag(physGameObject:PhysicsGameObject)
      {
         super();
         _physGameObject = physGameObject;
         _taggers.push(Tagger.DEFAULT);
      }
      
      public function clear() : void
      {
         if(_allowClear && _taggers.length > 1)
         {
            _taggers.splice(0,_taggers.length);
            _taggers.push(Tagger.DEFAULT);
         }
      }
      
      public function toString() : String
      {
         var s:String = "Tag: " + _physGameObject.shortName + " taggers: ";
         for each(var tagger in taggers)
         {
            s += tagger + ", ";
         }
         return s;
      }
      
      public function set allowClear(value:Boolean) : void
      {
         _allowClear = value;
      }
      
      public function add(gameObject:PhysicsGameObject) : void
      {
         var _loc2_:* = null;
         var _loc3_:Tagger = latestTagger;
         if(!_loc3_ || !_loc3_.gameObject || _loc4_._id != _loc5_._id)
         {
            _loc2_ = findLatestPlayerTagger();
            if(!_loc2_ || _loc6_._id != _loc7_._id)
            {
               _taggers.push(new Tagger(gameObject));
            }
         }
      }
      
      public function update(other:Tag) : void
      {
         if(!other)
         {
            return;
         }
         clear();
         var _loc3_:Vector.<Tagger> = cloneTaggers(other.taggers);
         for each(var tagger in _loc3_)
         {
            if(!(tagger == Tagger.DEFAULT || _physGameObject == tagger.gameObject))
            {
               _taggers.push(tagger);
               if(!tagger.gameObject)
               {
               }
            }
         }
      }
      
      public function get physGameObject() : PhysicsGameObject
      {
         return _physGameObject;
      }
      
      public function get latestTagger() : Tagger
      {
         return _taggers[_taggers.length - 1];
      }
      
      public function get taggers() : Vector.<Tagger>
      {
         return _taggers;
      }
      
      public function isDefaultTagger() : Boolean
      {
         return latestTagger.equals(Tagger.DEFAULT);
      }
      
      public function findLatestPlayerTagger() : Tagger
      {
         var i:int = 0;
         for(i = _taggers.length - 1; i >= 0; )
         {
            if(_taggers[i].gameObject is PlayerGameObject)
            {
               return _taggers[i];
            }
            i--;
         }
         return null;
      }
      
      public function get playerTaggers() : Vector.<Tagger>
      {
         var i:int = 0;
         var _loc1_:Vector.<Tagger> = new Vector.<Tagger>();
         for(i = _taggers.length - 1; i >= 0; )
         {
            if(_taggers[i].gameObject is PlayerGameObject)
            {
               _loc1_.push(_taggers[i]);
            }
            i--;
         }
         return _loc1_;
      }
      
      public function hasPlayerIDInTag(playerID:String, playertagger:Tagger = null) : Boolean
      {
         var indexBeforeTagger:int = 0;
         var i:* = 0;
         if(playertagger != null)
         {
            indexBeforeTagger = _taggers.indexOf(playertagger) - 1;
         }
         else
         {
            indexBeforeTagger = _taggers.length - 1;
         }
         for(i = indexBeforeTagger; i >= 0; )
         {
            if(_taggers[i].gameObject is PlayerGameObject && playerID == _taggers[i].gameObject.id)
            {
               return true;
            }
            i--;
         }
         return false;
      }
      
      private function cloneTaggers(other:Vector.<Tagger>) : Vector.<Tagger>
      {
         var _loc2_:Vector.<Tagger> = new Vector.<Tagger>();
         for each(var tagger in other)
         {
            _loc2_.push(tagger.clone());
         }
         return _loc2_;
      }
   }
}
