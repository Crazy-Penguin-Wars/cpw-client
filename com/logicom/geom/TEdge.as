package com.logicom.geom
{
   internal final class TEdge
   {
       
      
      public var xbot:int;
      
      public var ybot:int;
      
      public var xcurr:int;
      
      public var ycurr:int;
      
      public var xtop:int;
      
      public var ytop:int;
      
      public var dx:Number;
      
      public var tmpX:int;
      
      public var polyType:int;
      
      public var side:int;
      
      public var windDelta:int;
      
      public var windCnt:int;
      
      public var windCnt2:int;
      
      public var outIdx:int;
      
      public var next:TEdge;
      
      public var prev:TEdge;
      
      public var nextInLML:TEdge;
      
      public var nextInAEL:TEdge;
      
      public var prevInAEL:TEdge;
      
      public var nextInSEL:TEdge;
      
      public var prevInSEL:TEdge;
      
      public function TEdge()
      {
         super();
      }
   }
}
