package com.dchoc.gameobjects
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.game.DCGame;
   import com.dchoc.resources.*;
   import com.dchoc.states.StateMachine;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.geom.ColorTransform;
   import flash.utils.*;
   import no.olog.utilfunctions.*;
   import org.odefu.flash.display.*;
   import starling.animation.IAnimatable;
   import starling.core.*;
   import starling.display.*;
   import starling.textures.*;
   
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
      
      public function GameObject(param1:GameObjectDef, param2:DCGame)
      {
         super();
         assert("GameObject def",true,param1 != null);
         assert("GameObject game",true,param2 != null);
         this._objClass = param1.objClass;
         this._id = param1.id;
         this._tableName = param1.tableName;
         this._displayObject.gameObject = this;
         this._game = param2;
         this._name = param1.name;
         this._graphics = param1.graphics;
         this._className = getQualifiedClassName(this);
         if(Boolean(this._name) && this._name != "")
         {
            this._displayObject.name = this._name;
         }
      }
      
      final public function get uniqueId() : String
      {
         return this._uniqueId;
      }
      
      public function set uniqueId(param1:String) : void
      {
         this._uniqueId = param1;
         this._shortName = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if((!!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null) is OdefuMovieClip)
         {
            Starling.juggler.remove(!!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null);
         }
         if(this._displayObject.parent)
         {
            this._displayObject.parent.removeChild(this._displayObject);
         }
         this._displayObject.removeChildren(0,-1,true);
         this._displayObject.gameObject = null;
         this._disposed = true;
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(!this._graphicsLoaded && this.graphics && Boolean(DCResourceManager.instance.isLoaded(this.graphics.swf)))
         {
            this.loadGraphics();
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get graphicsLoaded() : Boolean
      {
         return this._graphicsLoaded;
      }
      
      public function set graphicsLoaded(param1:Boolean) : void
      {
         this._graphicsLoaded = param1;
      }
      
      public function get resourceType() : String
      {
         return this._resourceType;
      }
      
      public function set resourceType(param1:String) : void
      {
         this._resourceType = param1;
      }
      
      public function get allowGraphicsFlipping() : Boolean
      {
         return this._allowGraphicsFlipping;
      }
      
      public function set allowGraphicsFlipping(param1:Boolean) : void
      {
         this._allowGraphicsFlipping = param1;
      }
      
      public function worldReady() : void
      {
         this._worldReady = true;
      }
      
      public function isWorldReady() : Boolean
      {
         return this._worldReady;
      }
      
      public function get graphics() : GraphicsReference
      {
         return this._graphics;
      }
      
      final public function get game() : DCGame
      {
         return this._game;
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
      
      public function set direction(param1:int) : void
      {
         if(param1 != this._direction)
         {
            this._direction = param1;
            this.switchDirection();
         }
      }
      
      final public function get markedForRemoval() : Boolean
      {
         return this._markedForRemoval;
      }
      
      public function markForRemoval() : void
      {
         LogUtils.log("Marking " + this + " for removal.",this,1,"GameObjects",false,false,false);
         this._markedForRemoval = true;
      }
      
      final public function get name() : String
      {
         return this._name;
      }
      
      final public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function applyColorTransform(param1:ColorTransform) : void
      {
      }
      
      final public function get displayObject() : *
      {
         return !!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null;
      }
      
      final public function get gameDisplayObject() : GameDisplayObject
      {
         return this._displayObject;
      }
      
      public function getDisplayObjectFromResourceManager() : flash.display.DisplayObject
      {
         var _loc1_:BitmapData = null;
         switch(this._resourceType)
         {
            case "BitmapData":
               _loc1_ = DCResourceManager.instance.getFromSWF(this.graphics.swf,this.graphics.export,"BitmapData");
               return new Bitmap(_loc1_,"auto",true);
            case "MovieClip":
               return DCResourceManager.instance.getFromSWF(this.graphics.swf,this.graphics.export);
            default:
               return null;
         }
      }
      
      override public function toString() : String
      {
         if(this._toString == null)
         {
            this._toString = this._className + ": " + this.shortName;
         }
         return this._toString;
      }
      
      public function get shortName() : String
      {
         if(this._shortName == null)
         {
            this._shortName = this._name + " (id:" + this._id + ")(uid:" + this._uniqueId + ")";
            this._toString = null;
         }
         return this._shortName;
      }
      
      public function get objClass() : Class
      {
         return this._objClass;
      }
      
      final public function get id() : String
      {
         return this._id;
      }
      
      final public function get tableName() : String
      {
         return this._tableName;
      }
      
      public function isEdited() : Boolean
      {
         return this._edited;
      }
      
      public function markEdited() : void
      {
         this._edited = true;
      }
      
      protected function switchDirection() : void
      {
         if(this._allowGraphicsFlipping)
         {
            this._displayObject.scaleX *= -1;
         }
      }
      
      protected function loadGraphics() : void
      {
         var _loc1_:Texture = null;
         var _loc2_:Image = null;
         var _loc3_:OdefuMovieClip = null;
         var _loc4_:flash.display.DisplayObject = this.getDisplayObjectFromResourceManager();
         if(_loc4_ is Bitmap)
         {
            _loc1_ = Texture.fromBitmapData(Bitmap(_loc4_).bitmapData);
            _loc2_ = new Image(_loc1_);
            _loc2_.name = this.graphics.export;
            this._displayObject.addChild(_loc2_);
            Bitmap(_loc4_).bitmapData.dispose();
         }
         else if(_loc4_ is MovieClip && _loc4_.width > 0 && _loc4_.height > 0)
         {
            _loc3_ = OdefuMovieClipFactory.create(_loc4_ as MovieClip,25);
            _loc3_.name = this.graphics.export;
            Starling.juggler.add(_loc3_);
            this._displayObject.addChild(_loc3_);
         }
         this._graphicsLoaded = true;
      }
   }
}

