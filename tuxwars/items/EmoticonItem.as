package tuxwars.items
{
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.items.definitions.EmoticonDef;
   import tuxwars.items.definitions.EquippableDef;
   
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
      
      override public function load(data:EquippableDef) : void
      {
         super.load(data);
         assert("data is not EmoticonDef",true,data is EmoticonDef);
         var _loc2_:EmoticonDef = data as EmoticonDef;
         _duration = _loc2_.duration;
      }
      
      public function getEmoticonItemGraphicMovieClip() : MovieClip
      {
         if(emoticonItemGraphic == null)
         {
            emoticonItemGraphic = new EmoticonItemGraphic(DCResourceManager.instance.getFromSWF(graphics.swf,graphics.export,"MovieClip"));
         }
         return emoticonItemGraphic.getDesignMovieClip();
      }
      
      public function animIn() : void
      {
         _emoticonMovieClip = getEmoticonItemGraphicMovieClip();
         _emoticonMovieClip.addFrameScript(_emoticonMovieClip.totalFrames - 1,function():void
         {
            _emoticonMovieClip.stop();
         });
         emoticonItemGraphic.setVisible(true);
      }
      
      public function reduceDuration(amount:int) : void
      {
         if(!emoticonItemGraphic.getUiTransiotion())
         {
            _duration -= amount;
            if(_duration <= 0)
            {
               emoticonItemGraphic.setVisible(false);
            }
         }
      }
      
      public function set tagger(tagger:Tagger) : void
      {
         _tagger = tagger;
      }
      
      public function get tagger() : Tagger
      {
         return _tagger;
      }
      
      public function isFinished() : Boolean
      {
         return _duration <= 0 && !emoticonItemGraphic.getUiTransiotion();
      }
      
      public function set location(location:Point) : void
      {
         _location = location;
      }
      
      public function get location() : Point
      {
         return _location;
      }
      
      public function set groupIndex(value:int) : void
      {
      }
      
      public function set groupIndexToFilter(value:int) : void
      {
      }
      
      public function get groupIndex() : int
      {
         return 0;
      }
      
      override public function dispose() : void
      {
         if(emoticonItemGraphic)
         {
            emoticonItemGraphic.dispose();
            emoticonItemGraphic = null;
         }
         super.dispose();
      }
   }
}
