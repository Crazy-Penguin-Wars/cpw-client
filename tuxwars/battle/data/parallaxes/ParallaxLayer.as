package tuxwars.battle.data.parallaxes
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
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
      
      public function ParallaxLayer(data:Object, level:Level)
      {
         var i:int = 0;
         super();
         _originalX = data["x"];
         _originalY = data["y"];
         _cameraXPan = data["camera_x_pan"];
         _cameraYPan = data["camera_y_pan"];
         _tile_horizontally = data["tile_horizontally"];
         _gap = data["gap"];
         _level = level;
         _graphics = new Vector.<BitmapData>();
         for(i = 0; i < data["graphics_export"].length; )
         {
            _graphics.push(DCResourceManager.instance.getFromSWF(data["graphics_swf"],data["graphics_export"][i],"BitmapData"));
            i++;
         }
         createMovieClip();
      }
      
      public function dispose() : void
      {
         if(_graphics)
         {
            for each(var data in _graphics)
            {
               if(data)
               {
                  data.dispose();
               }
            }
            _graphics.splice(0,_graphics.length);
         }
         if(_layerClip)
         {
            DCUtils.disposeAllBitmapData(_layerClip);
         }
         _layerClip = null;
         _level = null;
      }
      
      public function get originalX() : int
      {
         return _originalX;
      }
      
      public function changeClipX(changeX:int) : void
      {
         if(_layerClip)
         {
            _layerClip.x = _originalX + changeX;
         }
      }
      
      public function get originalY() : int
      {
         return _originalY;
      }
      
      public function changeClipY(changeY:int) : void
      {
         if(_layerClip)
         {
            _layerClip.y = _originalY + changeY;
         }
      }
      
      public function get cameraXPan() : int
      {
         return _cameraXPan;
      }
      
      public function get cameraYPan() : int
      {
         return _cameraYPan;
      }
      
      public function get tileHorizontally() : Boolean
      {
         return _tile_horizontally;
      }
      
      public function get gap() : int
      {
         return _gap;
      }
      
      private function get graphics() : Vector.<BitmapData>
      {
         return _graphics;
      }
      
      private function createMovieClip() : void
      {
         var clipChild:* = null;
         for each(var childBitmap in graphics)
         {
            if(!childBitmap)
            {
               return;
            }
         }
         _layerClip = new Sprite();
         _layerClip.x = originalX;
         _layerClip.y = originalY;
         var fillX:* = 0;
         var fillWidth:int = 1;
         if(tileHorizontally)
         {
            fillWidth = _level.width + cameraXPan;
         }
         while(fillX < fillWidth)
         {
            for each(childBitmap in graphics)
            {
               clipChild = new ParallaxSprite();
               clipChild.setRegistration(childBitmap.width >> 1,childBitmap.height);
               clipChild.graphics.beginBitmapFill(childBitmap,null,true,true);
               clipChild.graphics.drawRect(0,0,childBitmap.width,childBitmap.height);
               clipChild.graphics.endFill();
               clipChild.setX(fillX);
               clipChild.setY(0);
               fillX += gap;
               _layerClip.addChild(clipChild);
            }
            if(gap == 0)
            {
               fillX = fillWidth;
            }
         }
      }
      
      public function get layerClip() : Sprite
      {
         if(!_layerClip)
         {
            createMovieClip();
         }
         return _layerClip;
      }
   }
}
