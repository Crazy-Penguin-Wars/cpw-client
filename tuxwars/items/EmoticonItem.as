package tuxwars.items
{
   import com.dchoc.resources.*;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.items.definitions.*;
   
   public class EmoticonItem extends Item
   {
      public static const EMOTICON_OBJECT_PROPERTY_NAME:String = "item";
      
      public static const EMOTICON_OBJECT_PROPERTY_PLAYER_ID:String = "playerId";
      
      private var _duration:int;
      
      private var _location:Point;
      
      private var _tagger:Tagger;
      
      private var _emoticonMovieClip:MovieClip;
      
      private var emoticonItemGraphic:EmoticonItemGraphic;
      
      public function EmoticonItem()
      {
         super();
      }
      
      override public function load(param1:EquippableDef) : void
      {
         super.load(param1);
         assert("data is not EmoticonDef",true,param1 is EmoticonDef);
         var _loc2_:EmoticonDef = param1 as EmoticonDef;
         this._duration = _loc2_.duration;
      }
      
      public function getEmoticonItemGraphicMovieClip() : MovieClip
      {
         if(this.emoticonItemGraphic == null)
         {
            this.emoticonItemGraphic = new EmoticonItemGraphic(DCResourceManager.instance.getFromSWF(graphics.swf,graphics.export,"MovieClip"));
         }
         return this.emoticonItemGraphic.getDesignMovieClip();
      }
      
      public function animIn() : void
      {
         this._emoticonMovieClip = this.getEmoticonItemGraphicMovieClip();
         this._emoticonMovieClip.addFrameScript(this._emoticonMovieClip.totalFrames - 1,function():void
         {
            _emoticonMovieClip.stop();
         });
         this.emoticonItemGraphic.setVisible(true);
      }
      
      public function reduceDuration(param1:int) : void
      {
         if(!this.emoticonItemGraphic.getUiTransiotion())
         {
            this._duration -= param1;
            if(this._duration <= 0)
            {
               this.emoticonItemGraphic.setVisible(false);
            }
         }
      }
      
      public function set tagger(param1:Tagger) : void
      {
         this._tagger = param1;
      }
      
      public function get tagger() : Tagger
      {
         return this._tagger;
      }
      
      public function isFinished() : Boolean
      {
         return this._duration <= 0 && !this.emoticonItemGraphic.getUiTransiotion();
      }
      
      public function set location(param1:Point) : void
      {
         this._location = param1;
      }
      
      public function get location() : Point
      {
         return this._location;
      }
      
      public function set groupIndex(param1:int) : void
      {
      }
      
      public function set groupIndexToFilter(param1:int) : void
      {
      }
      
      public function get groupIndex() : int
      {
         return 0;
      }
      
      override public function dispose() : void
      {
         if(this.emoticonItemGraphic)
         {
            this.emoticonItemGraphic.dispose();
            this.emoticonItemGraphic = null;
         }
         super.dispose();
      }
   }
}

