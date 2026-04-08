package tuxwars.battle.gameobjects
{
   import tuxwars.battle.gameobjects.player.*;
   
   public class Tag
   {
      private const _taggers:Vector.<Tagger> = new Vector.<Tagger>();
      
      private var _physGameObject:PhysicsGameObject;
      
      private var _allowClear:Boolean = true;
      
      public function Tag(param1:PhysicsGameObject)
      {
         super();
         this._physGameObject = param1;
         this._taggers.push(Tagger.DEFAULT);
      }
      
      public function clear() : void
      {
         if(Boolean(this._allowClear) && this._taggers.length > 1)
         {
            this._taggers.splice(0,this._taggers.length);
            this._taggers.push(Tagger.DEFAULT);
         }
      }
      
      public function toString() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:* = "Tag: " + this._physGameObject.shortName + " taggers: ";
         for each(_loc2_ in this.taggers)
         {
            _loc1_ += _loc2_ + ", ";
         }
         return _loc1_;
      }
      
      public function set allowClear(param1:Boolean) : void
      {
         this._allowClear = param1;
      }
      
      public function add(param1:PhysicsGameObject) : void
      {
         var _loc2_:Tagger = null;
         var _loc3_:Tagger = this.latestTagger;
         if(!_loc3_ || !_loc3_.gameObject || _loc4_._id != _loc5_._id)
         {
            _loc2_ = this.findLatestPlayerTagger();
            if(!_loc2_ || _loc6_._id != _loc7_._id)
            {
               this._taggers.push(new Tagger(param1));
            }
         }
      }
      
      public function update(param1:Tag) : void
      {
         var _loc3_:* = undefined;
         if(!param1)
         {
            return;
         }
         this.clear();
         var _loc2_:Vector.<Tagger> = this.cloneTaggers(param1.taggers);
         for each(_loc3_ in _loc2_)
         {
            if(!(_loc3_ == Tagger.DEFAULT || this._physGameObject == _loc3_.gameObject))
            {
               this._taggers.push(_loc3_);
               if(_loc3_.gameObject)
               {
               }
            }
         }
      }
      
      public function get physGameObject() : PhysicsGameObject
      {
         return this._physGameObject;
      }
      
      public function get latestTagger() : Tagger
      {
         return this._taggers[this._taggers.length - 1];
      }
      
      public function get taggers() : Vector.<Tagger>
      {
         return this._taggers;
      }
      
      public function isDefaultTagger() : Boolean
      {
         return this.latestTagger.equals(Tagger.DEFAULT);
      }
      
      public function findLatestPlayerTagger() : Tagger
      {
         var _loc1_:int = 0;
         _loc1_ = this._taggers.length - 1;
         while(_loc1_ >= 0)
         {
            if(this._taggers[_loc1_].gameObject is PlayerGameObject)
            {
               return this._taggers[_loc1_];
            }
            _loc1_--;
         }
         return null;
      }
      
      public function get playerTaggers() : Vector.<Tagger>
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<Tagger> = new Vector.<Tagger>();
         _loc1_ = this._taggers.length - 1;
         while(_loc1_ >= 0)
         {
            if(this._taggers[_loc1_].gameObject is PlayerGameObject)
            {
               _loc2_.push(this._taggers[_loc1_]);
            }
            _loc1_--;
         }
         return _loc2_;
      }
      
      public function hasPlayerIDInTag(param1:String, param2:Tagger = null) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         if(param2 != null)
         {
            _loc3_ = this._taggers.indexOf(param2) - 1;
         }
         else
         {
            _loc3_ = this._taggers.length - 1;
         }
         _loc4_ = _loc3_;
         while(_loc4_ >= 0)
         {
            if(this._taggers[_loc4_].gameObject is PlayerGameObject && param1 == this._taggers[_loc4_].gameObject.id)
            {
               return true;
            }
            _loc4_--;
         }
         return false;
      }
      
      private function cloneTaggers(param1:Vector.<Tagger>) : Vector.<Tagger>
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<Tagger> = new Vector.<Tagger>();
         for each(_loc3_ in param1)
         {
            _loc2_.push(_loc3_.clone());
         }
         return _loc2_;
      }
   }
}

