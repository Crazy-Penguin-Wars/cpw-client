package com.dchoc.gameobjects
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.game.DCGame;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.states.StateMachine;
   import com.dchoc.utils.LogUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.utils.getQualifiedClassName;
   import no.olog.utilfunctions.assert;
   import org.odefu.flash.display.OdefuMovieClip;
   import org.odefu.flash.display.OdefuMovieClipFactory;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class GameObject extends StateMachine
   {
      
      public static const DIR_LEFT:int = 0;
      
      public static const DIR_RIGHT:int = 1;
       
      
      private const _displayObject:GameDisplayObject = new GameDisplayObject();
      
      private var _resourceType:String = "MovieClip";
      
      private var _graphicsLoaded:Boolean;
      
      private var _allowGraphicsFlipping:Boolean;
      
      private var _graphics:GraphicsReference;
      
      private var _name:String;
      
      private var _markedForRemoval:Boolean;
      
      private var _direction:int = 0;
      
      private var _game:DCGame;
      
      private var _objClass:Class;
      
      private var _id:String;
      
      private var _uniqueId:String;
      
      private var _tableName:String;
      
      private var _edited:Boolean;
      
      private var _worldReady:Boolean;
      
      private var _shortName:String;
      
      private var _className:String;
      
      private var _toString:String;
      
      private var _disposed:Boolean;
      
      public function GameObject(def:GameObjectDef, game:DCGame)
      {
         super();
         assert("GameObject def",true,def != null);
         assert("GameObject game",true,game != null);
         _objClass = def.objClass;
         _id = def.id;
         _tableName = def.tableName;
         _displayObject.gameObject = this;
         _game = game;
         _name = def.name;
         _graphics = def.graphics;
         _className = getQualifiedClassName(this);
         if(_name && _name != "")
         {
            _displayObject.name = _name;
         }
      }
      
      final public function get uniqueId() : String
      {
         return _uniqueId;
      }
      
      public function set uniqueId(value:String) : void
      {
         _uniqueId = value;
         _shortName = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if((!!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null) is OdefuMovieClip)
         {
            Starling.juggler.remove(!!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null);
         }
         if(_displayObject.parent)
         {
            _displayObject.parent.removeChild(_displayObject);
         }
         _displayObject.removeChildren(0,-1,true);
         _displayObject.gameObject = null;
         _disposed = true;
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(!_graphicsLoaded && graphics && DCResourceManager.instance.isLoaded(graphics.swf))
         {
            loadGraphics();
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get graphicsLoaded() : Boolean
      {
         return _graphicsLoaded;
      }
      
      public function set graphicsLoaded(value:Boolean) : void
      {
         _graphicsLoaded = value;
      }
      
      public function get resourceType() : String
      {
         return _resourceType;
      }
      
      public function set resourceType(value:String) : void
      {
         _resourceType = value;
      }
      
      public function get allowGraphicsFlipping() : Boolean
      {
         return _allowGraphicsFlipping;
      }
      
      public function set allowGraphicsFlipping(value:Boolean) : void
      {
         _allowGraphicsFlipping = value;
      }
      
      public function worldReady() : void
      {
         _worldReady = true;
      }
      
      public function isWorldReady() : Boolean
      {
         return _worldReady;
      }
      
      public function get graphics() : GraphicsReference
      {
         return _graphics;
      }
      
      final public function get game() : DCGame
      {
         return _game;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(value:int) : void
      {
         if(value != _direction)
         {
            _direction = value;
            switchDirection();
         }
      }
      
      final public function get markedForRemoval() : Boolean
      {
         return _markedForRemoval;
      }
      
      public function markForRemoval() : void
      {
         LogUtils.log("Marking " + this + " for removal.",this,1,"GameObjects",false,false,false);
         _markedForRemoval = true;
      }
      
      final public function get name() : String
      {
         return _name;
      }
      
      final public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function applyColorTransform(colorTransform:ColorTransform) : void
      {
      }
      
      final public function get displayObject() : *
      {
         return !!graphics ? _displayObject.getChildByName(graphics.export) : null;
      }
      
      final public function get gameDisplayObject() : GameDisplayObject
      {
         return _displayObject;
      }
      
      public function getDisplayObjectFromResourceManager() : DisplayObject
      {
         var _loc1_:* = null;
         switch(_resourceType)
         {
            case "BitmapData":
               _loc1_ = DCResourceManager.instance.getFromSWF(graphics.swf,graphics.export,"BitmapData");
               return new Bitmap(_loc1_,"auto",true);
            case "MovieClip":
               return DCResourceManager.instance.getFromSWF(graphics.swf,graphics.export);
            default:
               return null;
         }
      }
      
      override public function toString() : String
      {
         if(_toString == null)
         {
            _toString = _className + ": " + shortName;
         }
         return _toString;
      }
      
      public function get shortName() : String
      {
         if(_shortName == null)
         {
            _shortName = this._name + " (id:" + this._id + ")(uid:" + this._uniqueId + ")";
            _toString = null;
         }
         return _shortName;
      }
      
      public function get objClass() : Class
      {
         return _objClass;
      }
      
      final public function get id() : String
      {
         return _id;
      }
      
      final public function get tableName() : String
      {
         return _tableName;
      }
      
      public function isEdited() : Boolean
      {
         return _edited;
      }
      
      public function markEdited() : void
      {
         _edited = true;
      }
      
      protected function switchDirection() : void
      {
         if(_allowGraphicsFlipping)
         {
            _displayObject.scaleX *= -1;
         }
      }
      
      protected function loadGraphics() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc1_:DisplayObject = getDisplayObjectFromResourceManager();
         if(_loc1_ is Bitmap)
         {
            _loc3_ = Texture.fromBitmapData(Bitmap(_loc1_).bitmapData);
            _loc4_ = new Image(_loc3_);
            _loc4_.name = graphics.export;
            _displayObject.addChild(_loc4_);
            Bitmap(_loc1_).bitmapData.dispose();
         }
         else if(_loc1_ is MovieClip && _loc1_.width > 0 && _loc1_.height > 0)
         {
            _loc2_ = OdefuMovieClipFactory.create(_loc1_ as MovieClip,25);
            _loc2_.name = graphics.export;
            Starling.juggler.add(_loc2_);
            _displayObject.addChild(_loc2_);
         }
         _graphicsLoaded = true;
      }
   }
}
