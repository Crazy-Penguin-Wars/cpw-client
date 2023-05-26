package tuxwars.battle.net.responses
{
   import flash.geom.Point;
   import nape.geom.Vec2;
   
   public class SimpleScriptResponse extends ActionResponse
   {
       
      
      public function SimpleScriptResponse(data:Object)
      {
         super(data);
      }
      
      public function get scriptId() : String
      {
         return data.sid;
      }
      
      public function get scriptObjectLocationOriginal() : Point
      {
         if((data as Object).hasOwnProperty("sx") && (data as Object).hasOwnProperty("sy"))
         {
            return new Point(data.sx,data.sy);
         }
         return null;
      }
      
      public function get pgoALocationV2() : Vec2
      {
         if((data as Object).hasOwnProperty("ax") && (data as Object).hasOwnProperty("ay"))
         {
            return new Vec2(data.ax,data.ay);
         }
         return null;
      }
      
      public function get pgoBLocationV2() : Vec2
      {
         if((data as Object).hasOwnProperty("bx") && (data as Object).hasOwnProperty("by"))
         {
            return new Vec2(data.bx,data.by);
         }
         return null;
      }
      
      public function get emissionLocationOriginal() : Point
      {
         if((data as Object).hasOwnProperty("ex") && (data as Object).hasOwnProperty("ey"))
         {
            return new Point(data.ex,data.ey);
         }
         return null;
      }
   }
}
