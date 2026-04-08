package tuxwars.battle.net.responses
{
   import flash.geom.*;
   import nape.geom.*;
   
   public class SimpleScriptResponse extends ActionResponse
   {
      public function SimpleScriptResponse(param1:Object)
      {
         super(param1);
      }
      
      public function get scriptId() : String
      {
         return data.sid;
      }
      
      public function get scriptObjectLocationOriginal() : Point
      {
         if(Boolean((data as Object).hasOwnProperty("sx")) && Boolean((data as Object).hasOwnProperty("sy")))
         {
            return new Point(data.sx,data.sy);
         }
         return null;
      }
      
      public function get pgoALocationV2() : Vec2
      {
         if(Boolean((data as Object).hasOwnProperty("ax")) && Boolean((data as Object).hasOwnProperty("ay")))
         {
            return new Vec2(data.ax,data.ay);
         }
         return null;
      }
      
      public function get pgoBLocationV2() : Vec2
      {
         if(Boolean((data as Object).hasOwnProperty("bx")) && Boolean((data as Object).hasOwnProperty("by")))
         {
            return new Vec2(data.bx,data.by);
         }
         return null;
      }
      
      public function get emissionLocationOriginal() : Point
      {
         if(Boolean((data as Object).hasOwnProperty("ex")) && Boolean((data as Object).hasOwnProperty("ey")))
         {
            return new Point(data.ex,data.ey);
         }
         return null;
      }
   }
}

