package tuxwars.battle.data.parallaxes
{
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.battle.world.loader.Level;
   
   public class ParallaxLayer
   {
      private static const COORD_X:String = "x";
      
      private static const COORD_Y:String = "y";
      
      private static const SWF_GRAPHIC:String = "graphics_swf";
      
      private static const EXPORT_GRAPHIC:String = "graphics_export";
      
      private static const CAMERA_X_PAN:String = "camera_x_pan";
      
      private static const CAMERA_Y_PAN:String = "camera_y_pan";
      
      private static const TILE_HORIZONTALLY:String = "tile_horizontally";
      
      private static const GAP:String = "gap";
      
      private var _originalX:int;
      
      private var _originalY:int;
      
      private var _cameraXPan:int;
      
      private var _cameraYPan:int;
      
      private var _tile_horizontally:Boolean;
      
      private var _gap:int;
      
      private var _graphics:Vector.<BitmapData>;
      
      private var _layerClip:Sprite;
      
      private var _level:Level;
      
      public function ParallaxLayer(param1:Object, param2:Level)
      {
         var _loc3_:int = 0;
         super();
         this._originalX = param1["x"];
         this._originalY = param1["y"];
         this._cameraXPan = param1["camera_x_pan"];
         this._cameraYPan = param1["camera_y_pan"];
         this._tile_horizontally = param1["tile_horizontally"];
         this._gap = param1["gap"];
         this._level = param2;
         this._graphics = new Vector.<BitmapData>();
         _loc3_ = 0;
         while(_loc3_ < param1["graphics_export"].length)
         {
            this._graphics.push(DCResourceManager.instance.getFromSWF(param1["graphics_swf"],param1["graphics_export"][_loc3_],"BitmapData"));
            _loc3_++;
         }
         this.createMovieClip();
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         if(this._graphics)
         {
            for each(_loc1_ in this._graphics)
            {
               if(_loc1_)
               {
                  _loc1_.dispose();
               }
            }
            this._graphics.splice(0,this._graphics.length);
         }
         if(this._layerClip)
         {
            DCUtils.disposeAllBitmapData(this._layerClip);
         }
         this._layerClip = null;
         this._level = null;
      }
      
      public function get originalX() : int
      {
         return this._originalX;
      }
      
      public function changeClipX(param1:int) : void
      {
         if(this._layerClip)
         {
            this._layerClip.x = this._originalX + param1;
         }
      }
      
      public function get originalY() : int
      {
         return this._originalY;
      }
      
      public function changeClipY(param1:int) : void
      {
         if(this._layerClip)
         {
            this._layerClip.y = this._originalY + param1;
         }
      }
      
      public function get cameraXPan() : int
      {
         return this._cameraXPan;
      }
      
      public function get cameraYPan() : int
      {
         return this._cameraYPan;
      }
      
      public function get tileHorizontally() : Boolean
      {
         return this._tile_horizontally;
      }
      
      public function get gap() : int
      {
         return this._gap;
      }
      
      private function get graphics() : Vector.<BitmapData>
      {
         return this._graphics;
      }
      
      private function createMovieClip() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc1_:ParallaxSprite = null;
         for each(_loc2_ in this.graphics)
         {
            if(!_loc2_)
            {
               return;
            }
         }
         this._layerClip = new Sprite();
         this._layerClip.x = this.originalX;
         this._layerClip.y = this.originalY;
         _loc3_ = 0;
         _loc4_ = 1;
         if(this.tileHorizontally)
         {
            _loc4_ = this._level.width + this.cameraXPan;
         }
         while(_loc3_ < _loc4_)
         {
            for each(_loc2_ in this.graphics)
            {
               _loc1_ = new ParallaxSprite();
               _loc1_.setRegistration(_loc2_.width >> 1,_loc2_.height);
               _loc1_.graphics.beginBitmapFill(_loc2_,null,true,true);
               _loc1_.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
               _loc1_.graphics.endFill();
               _loc1_.setX(_loc3_);
               _loc1_.setY(0);
               _loc3_ += this.gap;
               this._layerClip.addChild(_loc1_);
            }
            if(this.gap == 0)
            {
               _loc3_ = _loc4_;
            }
         }
      }
      
      public function get layerClip() : Sprite
      {
         if(!this._layerClip)
         {
            this.createMovieClip();
         }
         return this._layerClip;
      }
   }
}

