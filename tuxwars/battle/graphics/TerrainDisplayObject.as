package tuxwars.battle.graphics
{
   import flash.display.*;
   import flash.geom.*;
   import nape.geom.*;
   import tuxwars.battle.data.MaterialTheme;
   import tuxwars.battle.utils.*;
   import tuxwars.battle.world.loader.TerrainModel;
   
   public class TerrainDisplayObject
   {
      public static const PADDING:int = 50;
      
      public static const HALF_PADDING:Number = 25;
      
      private static const HALF_PADDING_POINT:Vec2 = new Vec2(25,25);
      
      private const _terrainBitmap:Bitmap = new Bitmap(null,"auto",true);
      
      private const canvas:Sprite = new Sprite();
      
      private var theme:MaterialTheme;
      
      private var grassTheme:MaterialTheme;
      
      private var disableBorders:Boolean;
      
      private var texture:Vector.<String>;
      
      public function TerrainDisplayObject(param1:TerrainDisplayObjectDef)
      {
         super();
         var _loc2_:TerrainModel = param1.getTerrainModel();
         this.theme = param1.getTheme();
         this.grassTheme = param1.getGrassTheme();
         this.disableBorders = param1.isBorderDisabled;
         var _loc3_:Boolean = Boolean(param1.getTerrainTexture()) && Boolean(param1.getTerrainTexture().getTextureBitmapData());
         if(_loc3_)
         {
            this.draw(this.canvas,this.createTextureFill(param1.getTerrainTexture().getTextureBitmapData(),param1.getTerrainTextureRotation()),this.createFillPath(_loc2_.points),new GraphicsEndFill());
         }
         else
         {
            this.draw(this.canvas,this.createTextureFill(this.theme.getLandmassTexture(),0),this.createFillPath(_loc2_.points),new GraphicsEndFill());
         }
         if(this.grassTheme)
         {
            this.drawPlainBorders(this.canvas,_loc2_);
            this.drawTopTiles(this.canvas,_loc2_);
         }
         else
         {
            this.drawPlainBorders(this.canvas,_loc2_);
         }
         var _loc4_:Matrix = new Matrix();
         _loc4_.translate(25,25);
         var _loc5_:BitmapData = new BitmapData(this.canvas.width,this.canvas.height,true,0);
         _loc5_.draw(this.canvas,_loc4_,null,null,null,true);
         this._terrainBitmap.bitmapData = _loc5_;
         var _loc6_:ColorTransform = this._terrainBitmap.transform.colorTransform;
         var _loc7_:uint = _loc6_.color;
         _loc6_.redOffset = ((_loc7_ & 0xFF0000) >>> 16) + param1.getRed() + (param1.getTint() - param1.getShade());
         _loc6_.greenOffset = ((_loc7_ & 0xFF00) >>> 8) + param1.getGreen() + (param1.getTint() - param1.getShade());
         _loc6_.blueOffset = (_loc7_ & 0xFF) + param1.getBlue() + (param1.getTint() - param1.getShade());
         this._terrainBitmap.transform.colorTransform = _loc6_;
      }
      
      public function dispose() : void
      {
         this._terrainBitmap.bitmapData.dispose();
         this.theme = null;
         this.grassTheme = null;
      }
      
      public function get terrainBitmap() : Bitmap
      {
         return this._terrainBitmap;
      }
      
      public function drawExplosion(param1:Vector.<Vec2>, param2:Vector.<TerrainModel>) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         GeomUtils.translatePolygon(param1,HALF_PADDING_POINT);
         this.canvas.graphics.clear();
         this.draw(this.canvas,new GraphicsSolidFill(),this.createFillPath(param1),new GraphicsEndFill());
         this._terrainBitmap.bitmapData.draw(this.canvas,null,null,"erase");
         for each(_loc6_ in param2)
         {
            _loc3_ = new Vector.<Vector.<Vec2>>();
            _loc4_ = _loc6_.calculateIntersectionPoints();
            for each(_loc7_ in _loc4_)
            {
               if(_loc7_.length > 1)
               {
                  _loc5_ = GeomUtils.duplicatePointPolygon(_loc7_);
                  GeomUtils.translatePolygon(_loc5_,HALF_PADDING_POINT);
                  _loc3_.push(GeomUtils.toVecVector(_loc5_));
               }
            }
            this.canvas.graphics.clear();
            this.drawLines(_loc3_,this.theme.getExplosionBorderColor(),this.canvas);
            this._terrainBitmap.bitmapData.draw(this.canvas,null,null,null,null,true);
         }
      }
      
      private function draw(param1:Sprite, ... rest) : void
      {
         var _loc4_:* = undefined;
         var _loc3_:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
         for each(_loc4_ in rest)
         {
            _loc3_.push(_loc4_);
         }
         param1.graphics.drawGraphicsData(_loc3_);
      }
      
      private function drawLines(param1:Vector.<Vector.<Vec2>>, param2:uint, param3:Sprite) : void
      {
         var _loc4_:* = undefined;
         for each(_loc4_ in param1)
         {
            this.drawLine(_loc4_,param2,param3);
         }
         param3.graphics.lineStyle(NaN,0);
      }
      
      private function drawLine(param1:Vector.<Vec2>, param2:uint, param3:Sprite) : void
      {
         if(this.disableBorders)
         {
            return;
         }
         var _loc4_:GraphicsPath = this.createFillPath(param1);
         var _loc5_:GraphicsStroke = new GraphicsStroke(5,true,"normal","square","miter");
         _loc5_.fill = new GraphicsSolidFill(param2);
         this.draw(param3,_loc5_,_loc4_);
      }
      
      private function drawTopTiles(param1:Sprite, param2:TerrainModel) : void
      {
         var _loc36_:* = undefined;
         var _loc37_:Matrix = null;
         var _loc3_:* = null;
         var _loc4_:* = NaN;
         var _loc5_:Vec2 = null;
         var _loc6_:int = 0;
         var _loc7_:Vec2 = null;
         var _loc8_:Vec2 = null;
         var _loc9_:Number = Number(NaN);
         var _loc10_:int = 0;
         var _loc11_:Number = Number(NaN);
         var _loc12_:Vec2 = null;
         var _loc13_:Boolean = false;
         var _loc14_:int = 0;
         var _loc15_:* = false;
         var _loc16_:int = 0;
         var _loc17_:* = null;
         var _loc18_:Point = null;
         var _loc19_:Vec2 = null;
         var _loc20_:Vec2 = null;
         var _loc21_:Number = Number(NaN);
         var _loc22_:Vec2 = null;
         var _loc23_:Vec2 = null;
         var _loc24_:Vector.<Vec2> = GeomUtils.duplicatePolygon(param2.points);
         var _loc25_:flash.geom.Rectangle = GeomUtils.createBoundingBox(_loc24_);
         var _loc26_:BitmapData = new BitmapData(_loc25_.width + 50,_loc25_.height + 50,true,0);
         var _loc27_:Bitmap = new Bitmap(this.grassTheme.getLandmassTile());
         _loc27_.smoothing = true;
         var _loc28_:Bitmap = new Bitmap(this.grassTheme.getLandmassLeftTile());
         _loc28_.smoothing = true;
         var _loc29_:Bitmap = new Bitmap(this.grassTheme.getLandmassRightTile());
         _loc29_.smoothing = true;
         var _loc30_:Bitmap = new Bitmap(this.grassTheme.getLandmassFillerTile());
         _loc30_.smoothing = true;
         var _loc31_:Vec2 = new Vec2(_loc27_.width * 0.5,_loc27_.height * 0.5);
         var _loc32_:Vec2 = new Vec2(_loc28_.width * 0.5,_loc28_.height * 0.5);
         var _loc33_:Vec2 = new Vec2(_loc29_.width * 0.5,_loc29_.height * 0.5);
         var _loc34_:Vec2 = new Vec2(_loc30_.width * 0.5,_loc30_.height * 0.5);
         var _loc35_:Vector.<Vector.<Vec2>> = GeomUtils.findLineSegments(_loc24_,this.grassTheme.getAngle(),"AngleLess");
         for each(_loc36_ in _loc35_)
         {
            _loc5_ = _loc36_[0];
            _loc6_ = 0;
            while(_loc6_ < _loc36_.length - 1)
            {
               _loc7_ = !!_loc5_ ? _loc5_ : _loc36_[_loc6_];
               _loc3_ = _loc8_ = _loc36_[_loc6_ + 1];
               _loc9_ = Number(Vec2.distance(_loc7_,_loc8_));
               _loc10_ = Math.floor(_loc9_ / _loc31_.x);
               _loc11_ = Math.atan2(_loc8_.y - _loc7_.y,_loc8_.x - _loc7_.x);
               _loc14_ = 0;
               while(_loc14_ < _loc10_)
               {
                  _loc15_ = _loc13_;
                  _loc13_ = _loc10_ - _loc14_ > 2 && (_loc10_ - _loc14_) % 2 == 0 && Math.random() < 0.5;
                  _loc16_ = _loc13_ ? 2 : 1;
                  _loc17_ = _loc5_;
                  _loc5_ = Vec2.fromPolar(_loc31_.x * (_loc13_ ? 1.75 : (!!_loc15_ ? 1.75 : 1)),_loc11_);
                  _loc5_.addeq(_loc17_);
                  if(_loc6_ > 0 && !_loc12_ && _loc36_[_loc6_].y <= _loc8_.y)
                  {
                     _loc18_ = Point.interpolate(_loc5_.toPoint(),_loc17_.toPoint(),0.5);
                     _loc12_ = new Vec2(_loc18_.x,_loc18_.y);
                  }
                  if(_loc6_ == _loc36_.length - 2 && Vec2.distance(_loc5_,_loc8_) < _loc31_.x * _loc16_)
                  {
                     _loc3_ = _loc5_;
                     break;
                  }
                  _loc19_ = new Vec2(_loc5_.x + 25 - _loc31_.x * _loc16_,_loc5_.y + 25 - _loc31_.y);
                  this.drawTile(_loc26_,_loc27_,_loc11_,_loc19_,_loc16_);
                  if(_loc13_)
                  {
                     _loc14_++;
                  }
                  _loc14_++;
               }
               _loc4_ = _loc11_;
               if(_loc6_ > 0 && _loc36_[_loc6_].y <= _loc8_.y && Boolean(_loc12_))
               {
                  _loc20_ = new Vec2(_loc12_.x + 25 - _loc34_.x,_loc12_.y + 25 - _loc34_.y);
                  this.drawTile(_loc26_,_loc30_,_loc11_,_loc20_);
                  _loc12_ = null;
               }
               _loc6_++;
            }
            _loc21_ = Math.atan2(_loc36_[1].y - _loc36_[0].y,_loc36_[1].x - _loc36_[0].x);
            _loc22_ = new Vec2(_loc36_[0].x - _loc32_.x + 25,_loc36_[0].y - _loc32_.y + 25);
            this.drawTile(_loc26_,_loc28_,_loc21_,_loc22_);
            _loc23_ = new Vec2(_loc3_.x - _loc33_.x + 25,_loc3_.y - _loc33_.y + 25);
            this.drawTile(_loc26_,_loc29_,_loc4_,_loc23_);
         }
         _loc37_ = new Matrix();
         _loc37_.translate(-25,-25);
         param1.graphics.beginBitmapFill(_loc26_,_loc37_,true,true);
         param1.graphics.drawRect(-25,-25,_loc26_.width,_loc26_.height);
         param1.graphics.endFill();
      }
      
      private function drawPlainBorders(param1:Sprite, param2:TerrainModel) : void
      {
         var _loc3_:flash.geom.Rectangle = GeomUtils.createBoundingBox(param2.points);
         var _loc4_:BitmapData = new BitmapData(_loc3_.width + 50,_loc3_.height + 50,true,0);
         var _loc5_:Matrix = new Matrix();
         _loc5_.translate(-25,-25);
         param1.graphics.beginBitmapFill(_loc4_,_loc5_,true,true);
         param1.graphics.drawRect(-25,-25,_loc4_.width,_loc4_.height);
         param1.graphics.endFill();
         var _loc6_:Vector.<Vec2> = GeomUtils.duplicatePolygon(param2.points);
         _loc6_.push(param2.points[0]);
         this.drawLine(_loc6_,this.theme.getBorderColor(),param1);
         param1.graphics.lineStyle(NaN,0);
      }
      
      private function drawTile(param1:BitmapData, param2:Bitmap, param3:Number, param4:Vec2, param5:Number = 1, param6:Number = 1) : void
      {
         param2.scaleX = param5;
         var _loc7_:Matrix = new Matrix();
         _loc7_.scale(param5,param6);
         _loc7_.translate(int(-param2.width * 0.5),int(-param2.height * 0.5));
         _loc7_.rotate(param3);
         _loc7_.translate(int(param2.width * 0.5),int(param2.height * 0.5));
         _loc7_.translate(int(param4.x),int(param4.y));
         param1.draw(param2,_loc7_,null,null,null,true);
      }
      
      private function createTextureFill(param1:BitmapData, param2:int) : GraphicsBitmapFill
      {
         var _loc3_:GraphicsBitmapFill = new GraphicsBitmapFill(param1);
         _loc3_.smooth = true;
         _loc3_.matrix = new Matrix();
         _loc3_.matrix.rotate(param2 * 3.141592653589793 / 180);
         return _loc3_;
      }
      
      private function createFillPath(param1:Vector.<Vec2>) : GraphicsPath
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<int> = new Vector.<int>();
         var _loc4_:Vector.<Number> = new Vector.<Number>();
         _loc4_.push(int(param1[0].x),int(param1[0].y));
         _loc3_.push(1);
         _loc2_ = 1;
         while(_loc2_ < param1.length)
         {
            _loc4_.push(int(param1[_loc2_].x),int(param1[_loc2_].y));
            _loc3_.push(2);
            _loc2_++;
         }
         return new GraphicsPath(_loc3_,_loc4_);
      }
   }
}

