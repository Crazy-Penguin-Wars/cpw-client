package tuxwars.battle.graphics
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import flash.display.GraphicsEndFill;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import nape.geom.Vec2;
   import tuxwars.battle.data.MaterialTheme;
   import tuxwars.battle.utils.GeomUtils;
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
      
      public function TerrainDisplayObject(def:TerrainDisplayObjectDef)
      {
         super();
         var _loc4_:TerrainModel = def.getTerrainModel();
         theme = def.getTheme();
         grassTheme = def.getGrassTheme();
         disableBorders = def.isBorderDisabled;
         var _loc2_:Boolean = def.getTerrainTexture() && def.getTerrainTexture().getTextureBitmapData();
         if(_loc2_)
         {
            draw(canvas,createTextureFill(def.getTerrainTexture().getTextureBitmapData(),def.getTerrainTextureRotation()),createFillPath(_loc4_.points),new GraphicsEndFill());
         }
         else
         {
            draw(canvas,createTextureFill(theme.getLandmassTexture(),0),createFillPath(_loc4_.points),new GraphicsEndFill());
         }
         if(grassTheme)
         {
            drawPlainBorders(canvas,_loc4_);
            drawTopTiles(canvas,_loc4_);
         }
         else
         {
            drawPlainBorders(canvas,_loc4_);
         }
         var _loc6_:Matrix = new Matrix();
         _loc6_.translate(25,25);
         var _loc3_:BitmapData = new BitmapData(canvas.width,canvas.height,true,0);
         _loc3_.draw(canvas,_loc6_,null,null,null,true);
         _terrainBitmap.bitmapData = _loc3_;
         var newColorTransform:ColorTransform = _terrainBitmap.transform.colorTransform;
         var _loc5_:uint = newColorTransform.color;
         newColorTransform.redOffset = ((_loc5_ & 16711680) >>> 16) + def.getRed() + (def.getTint() - def.getShade());
         newColorTransform.greenOffset = ((_loc5_ & 65280) >>> 8) + def.getGreen() + (def.getTint() - def.getShade());
         newColorTransform.blueOffset = (_loc5_ & 255) + def.getBlue() + (def.getTint() - def.getShade());
         _terrainBitmap.transform.colorTransform = newColorTransform;
      }
      
      public function dispose() : void
      {
         _terrainBitmap.bitmapData.dispose();
         theme = null;
         grassTheme = null;
      }
      
      public function get terrainBitmap() : Bitmap
      {
         return _terrainBitmap;
      }
      
      public function drawExplosion(polygon:Vector.<Vec2>, terrainModels:Vector.<TerrainModel>) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc3_:* = undefined;
         GeomUtils.translatePolygon(polygon,HALF_PADDING_POINT);
         canvas.graphics.clear();
         draw(canvas,new GraphicsSolidFill(),createFillPath(polygon),new GraphicsEndFill());
         _terrainBitmap.bitmapData.draw(canvas,null,null,"erase");
         for each(var model in terrainModels)
         {
            _loc6_ = new Vector.<Vector.<Vec2>>();
            _loc7_ = model.calculateIntersectionPoints();
            for each(var a in _loc7_)
            {
               if(a.length > 1)
               {
                  _loc3_ = GeomUtils.duplicatePointPolygon(a);
                  GeomUtils.translatePolygon(_loc3_,HALF_PADDING_POINT);
                  _loc6_.push(GeomUtils.toVecVector(_loc3_));
               }
            }
            canvas.graphics.clear();
            drawLines(_loc6_,theme.getExplosionBorderColor(),canvas);
            _terrainBitmap.bitmapData.draw(canvas,null,null,null,null,true);
         }
      }
      
      private function draw(target:Sprite, ... args) : void
      {
         var _loc4_:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
         for each(var arg in args)
         {
            _loc4_.push(arg);
         }
         target.graphics.drawGraphicsData(_loc4_);
      }
      
      private function drawLines(lines:Vector.<Vector.<Vec2>>, color:uint, target:Sprite) : void
      {
         for each(var segment in lines)
         {
            drawLine(segment,color,target);
         }
         target.graphics.lineStyle(NaN,0);
      }
      
      private function drawLine(line:Vector.<Vec2>, color:uint, target:Sprite) : void
      {
         if(disableBorders)
         {
            return;
         }
         var _loc5_:GraphicsPath = createFillPath(line);
         var _loc4_:GraphicsStroke = new GraphicsStroke(5,true,"normal","square","miter");
         _loc4_.fill = new GraphicsSolidFill(color);
         draw(target,_loc4_,_loc5_);
      }
      
      private function drawTopTiles(target:Sprite, terrainModel:TerrainModel) : void
      {
         var endVec2:* = null;
         var endAngleRad:* = NaN;
         var curVec2:* = null;
         var i:int = 0;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc12_:Number = NaN;
         var _loc24_:int = 0;
         var _loc33_:Number = NaN;
         var connectorVec2:* = null;
         var doubleWidth:Boolean = false;
         var j:int = 0;
         var _loc13_:* = false;
         var _loc3_:int = 0;
         var _loc14_:* = null;
         var _loc18_:* = null;
         var _loc34_:* = null;
         var _loc35_:* = null;
         var _loc22_:Number = NaN;
         var _loc30_:* = null;
         var _loc28_:* = null;
         var _loc15_:Vector.<Vec2> = GeomUtils.duplicatePolygon(terrainModel.points);
         var _loc11_:Rectangle = GeomUtils.createBoundingBox(_loc15_);
         var _loc9_:BitmapData = new BitmapData(_loc11_.width + 50,_loc11_.height + 50,true,0);
         var _loc36_:Bitmap = new Bitmap(grassTheme.getLandmassTile());
         _loc36_.smoothing = true;
         var _loc32_:Bitmap = new Bitmap(grassTheme.getLandmassLeftTile());
         _loc32_.smoothing = true;
         var _loc10_:Bitmap = new Bitmap(grassTheme.getLandmassRightTile());
         _loc10_.smoothing = true;
         var _loc21_:Bitmap = new Bitmap(grassTheme.getLandmassFillerTile());
         _loc21_.smoothing = true;
         var _loc20_:Vec2 = new Vec2(_loc36_.width * 0.5,_loc36_.height * 0.5);
         var _loc29_:Vec2 = new Vec2(_loc32_.width * 0.5,_loc32_.height * 0.5);
         var _loc19_:Vec2 = new Vec2(_loc10_.width * 0.5,_loc10_.height * 0.5);
         var _loc5_:Vec2 = new Vec2(_loc21_.width * 0.5,_loc21_.height * 0.5);
         var _loc6_:Vector.<Vector.<Vec2>> = GeomUtils.findLineSegments(_loc15_,grassTheme.getAngle(),"AngleLess");
         for each(var segment in _loc6_)
         {
            curVec2 = segment[0];
            for(i = 0; i < segment.length - 1; )
            {
               _loc4_ = !!curVec2 ? curVec2 : segment[i];
               _loc7_ = segment[i + 1];
               endVec2 = _loc7_;
               _loc12_ = Vec2.distance(_loc4_,_loc7_);
               _loc24_ = Math.floor(_loc12_ / _loc20_.x);
               _loc33_ = Math.atan2(_loc7_.y - _loc4_.y,_loc7_.x - _loc4_.x);
               for(j = 0; j < _loc24_; )
               {
                  _loc13_ = doubleWidth;
                  doubleWidth = _loc24_ - j > 2 && (_loc24_ - j) % 2 == 0 && Math.random() < 0.5;
                  _loc3_ = doubleWidth ? 2 : 1;
                  _loc14_ = curVec2;
                  curVec2 = Vec2.fromPolar(_loc20_.x * (doubleWidth ? 1.75 : (_loc13_ ? 1.75 : 1)),_loc33_);
                  curVec2.addeq(_loc14_);
                  if(i > 0 && !connectorVec2 && segment[i].y <= _loc7_.y)
                  {
                     _loc18_ = Point.interpolate(curVec2.toPoint(),_loc14_.toPoint(),0.5);
                     connectorVec2 = new Vec2(_loc18_.x,_loc18_.y);
                  }
                  if(i == segment.length - 2 && Vec2.distance(curVec2,_loc7_) < _loc20_.x * _loc3_)
                  {
                     endVec2 = curVec2;
                     break;
                  }
                  _loc34_ = new Vec2(curVec2.x + 25 - _loc20_.x * _loc3_,curVec2.y + 25 - _loc20_.y);
                  drawTile(_loc9_,_loc36_,_loc33_,_loc34_,_loc3_);
                  if(doubleWidth)
                  {
                     j++;
                  }
                  j++;
               }
               endAngleRad = _loc33_;
               if(i > 0 && segment[i].y <= _loc7_.y && connectorVec2)
               {
                  _loc35_ = new Vec2(connectorVec2.x + 25 - _loc5_.x,connectorVec2.y + 25 - _loc5_.y);
                  drawTile(_loc9_,_loc21_,_loc33_,_loc35_);
                  connectorVec2 = null;
               }
               i++;
            }
            _loc22_ = Math.atan2(segment[1].y - segment[0].y,segment[1].x - segment[0].x);
            _loc30_ = new Vec2(segment[0].x - _loc29_.x + 25,segment[0].y - _loc29_.y + 25);
            drawTile(_loc9_,_loc32_,_loc22_,_loc30_);
            _loc28_ = new Vec2(endVec2.x - _loc19_.x + 25,endVec2.y - _loc19_.y + 25);
            drawTile(_loc9_,_loc10_,endAngleRad,_loc28_);
         }
         var _loc25_:Matrix = new Matrix();
         _loc25_.translate(-25,-25);
         target.graphics.beginBitmapFill(_loc9_,_loc25_,true,true);
         target.graphics.drawRect(-25,-25,_loc9_.width,_loc9_.height);
         target.graphics.endFill();
      }
      
      private function drawPlainBorders(target:Sprite, terrainModel:TerrainModel) : void
      {
         var _loc3_:Rectangle = GeomUtils.createBoundingBox(terrainModel.points);
         var _loc4_:BitmapData = new BitmapData(_loc3_.width + 50,_loc3_.height + 50,true,0);
         var _loc6_:Matrix = new Matrix();
         _loc6_.translate(-25,-25);
         target.graphics.beginBitmapFill(_loc4_,_loc6_,true,true);
         target.graphics.drawRect(-25,-25,_loc4_.width,_loc4_.height);
         target.graphics.endFill();
         var _loc5_:Vector.<Vec2> = GeomUtils.duplicatePolygon(terrainModel.points);
         _loc5_.push(terrainModel.points[0]);
         drawLine(_loc5_,theme.getBorderColor(),target);
         target.graphics.lineStyle(NaN,0);
      }
      
      private function drawTile(data:BitmapData, bitmap:Bitmap, angle:Number, loc:Vec2, scaleX:Number = 1, scaleY:Number = 1) : void
      {
         bitmap.scaleX = scaleX;
         var _loc7_:Matrix = new Matrix();
         _loc7_.scale(scaleX,scaleY);
         _loc7_.translate(-bitmap.width * 0.5,-bitmap.height * 0.5);
         _loc7_.rotate(angle);
         _loc7_.translate(bitmap.width * 0.5,bitmap.height * 0.5);
         _loc7_.translate(loc.x,loc.y);
         data.draw(bitmap,_loc7_,null,null,null,true);
      }
      
      private function createTextureFill(bitmapData:BitmapData, rotationDegrees:int) : GraphicsBitmapFill
      {
         var _loc3_:GraphicsBitmapFill = new GraphicsBitmapFill(bitmapData);
         _loc3_.smooth = true;
         _loc3_.matrix = new Matrix();
         _loc3_.matrix.rotate(rotationDegrees * 3.141592653589793 / 180);
         return _loc3_;
      }
      
      private function createFillPath(points:Vector.<Vec2>) : GraphicsPath
      {
         var i:int = 0;
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc3_:Vector.<Number> = new Vector.<Number>();
         _loc3_.push(points[0].x,points[0].y);
         _loc2_.push(1);
         for(i = 1; i < points.length; )
         {
            _loc3_.push(points[i].x,points[i].y);
            _loc2_.push(2);
            i++;
         }
         return new GraphicsPath(_loc2_,_loc3_);
      }
   }
}
