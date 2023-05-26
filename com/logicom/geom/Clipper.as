package com.logicom.geom
{
   import flash.geom.Point;
   
   public class Clipper extends ClipperBase
   {
       
      
      private var m_PolyOuts:Vector.<OutRec>;
      
      private var m_ClipType:int;
      
      private var m_Scanbeam:Scanbeam;
      
      private var m_ActiveEdges:TEdge;
      
      private var m_SortedEdges:TEdge;
      
      private var m_IntersectNodes:IntersectNode;
      
      private var m_ExecuteLocked:Boolean;
      
      private var m_ClipFillType:int;
      
      private var m_SubjFillType:int;
      
      private var m_Joins:Vector.<JoinRec>;
      
      private var m_HorizJoins:Vector.<HorzJoinRec>;
      
      private var m_ReverseOutput:Boolean;
      
      public function Clipper()
      {
         super();
         m_Scanbeam = null;
         m_ActiveEdges = null;
         m_SortedEdges = null;
         m_IntersectNodes = null;
         m_ExecuteLocked = false;
         m_PolyOuts = new Vector.<OutRec>();
         m_Joins = new Vector.<JoinRec>();
         m_HorizJoins = new Vector.<HorzJoinRec>();
         m_ReverseOutput = false;
      }
      
      public static function clipPolygon(subjectPolygonFloat:Array, clipPolygonFloat:Array, clipType:int) : Array
      {
         var point:* = null;
         var n:int = 0;
         var points:* = null;
         var i:int = 0;
         var p:* = null;
         var subjectPolygon:Polygon = new Polygon();
         var clipPolygon:Polygon = new Polygon();
         for each(point in subjectPolygonFloat)
         {
            subjectPolygon.addPoint(new IntPoint(Math.round(point.x) as int,Math.round(point.y) as int));
         }
         for each(point in clipPolygonFloat)
         {
            clipPolygon.addPoint(new IntPoint(Math.round(point.x) as int,Math.round(point.y) as int));
         }
         var clipper:Clipper = new Clipper();
         clipper.addPolygon(subjectPolygon,0);
         clipper.addPolygon(clipPolygon,1);
         var solution:Polygons = new Polygons();
         clipper.execute(clipType,solution,0,0);
         var ret:Array = [];
         for each(var solutionPoly in solution.getPolygons())
         {
            n = solutionPoly.getSize();
            points = new Array(n);
            for(i = 0; i < n; )
            {
               p = solutionPoly.getPoint(i);
               points[i] = new Point(p.X,p.Y);
               i++;
            }
            ret.push(points);
         }
         return ret;
      }
      
      private static function polySort(or1:OutRec, or2:OutRec) : int
      {
         var i2:int = 0;
         var i1:int = 0;
         if(or1 == or2)
         {
            return 0;
         }
         if(or1.pts == null || or2.pts == null)
         {
            if(or1.pts == null != (or2.pts == null))
            {
               return or1.pts == null ? 1 : -1;
            }
            return 0;
         }
         if(or1.isHole)
         {
            i1 = or1.firstLeft.idx;
         }
         else
         {
            i1 = or1.idx;
         }
         if(or2.isHole)
         {
            i2 = or2.firstLeft.idx;
         }
         else
         {
            i2 = or2.idx;
         }
         var result:int = i1 - i2;
         if(result == 0 && or1.isHole != or2.isHole)
         {
            return or1.isHole ? 1 : -1;
         }
         return result;
      }
      
      private static function swapSides(edge1:TEdge, edge2:TEdge) : void
      {
         var side:int = edge1.side;
         edge1.side = edge2.side;
         edge2.side = side;
      }
      
      private static function swapPolyIndexes(edge1:TEdge, edge2:TEdge) : void
      {
         var outIdx:int = edge1.outIdx;
         edge1.outIdx = edge2.outIdx;
         edge2.outIdx = outIdx;
      }
      
      private static function getNextInAEL(e:TEdge, direction:int) : TEdge
      {
         return direction == 1 ? e.nextInAEL : e.prevInAEL;
      }
      
      private static function isMinima(e:TEdge) : Boolean
      {
         return e != null && e.prev.nextInLML != e && e.next.nextInLML != e;
      }
      
      private static function isMaxima(e:TEdge, Y:Number) : Boolean
      {
         return e != null && e.ytop == Y && e.nextInLML == null;
      }
      
      private static function isIntermediate(e:TEdge, Y:Number) : Boolean
      {
         return e.ytop == Y && e.nextInLML != null;
      }
      
      private static function getMaximaPair(e:TEdge) : TEdge
      {
         if(!isMaxima(e.next,e.ytop) || e.next.xtop != e.xtop)
         {
            return e.prev;
         }
         return e.next;
      }
      
      private static function round(value:Number) : int
      {
         return value < 0 ? value - 0.5 : value + 0.5;
      }
      
      private static function topX(edge:TEdge, currentY:int) : int
      {
         if(currentY == edge.ytop)
         {
            return edge.xtop;
         }
         return edge.xbot + round(edge.dx * (currentY - edge.ybot));
      }
      
      public static function reversePolygons(polys:Polygons) : void
      {
         for each(var poly in polys.getPolygons())
         {
            poly.reverse();
         }
      }
      
      public static function orientation(polygon:Polygon) : Boolean
      {
         var jplus:int = 0;
         var jminus:* = 0;
         var i:int = 0;
         var poly:Vector.<IntPoint> = polygon.getPoints();
         var highI:int = poly.length - 1;
         if(highI < 2)
         {
            return false;
         }
         var j:* = 0;
         for(i = 0; i <= highI; )
         {
            if(poly[i].Y >= poly[j].Y)
            {
               if(poly[i].Y > poly[j].Y || poly[i].X < poly[j].X)
               {
                  j = i;
               }
            }
            i++;
         }
         if(j == highI)
         {
            jplus = 0;
         }
         else
         {
            jplus = j + 1;
         }
         if(j == 0)
         {
            jminus = highI;
         }
         else
         {
            jminus = j - 1;
         }
         var vec1:IntPoint = new IntPoint(poly[j].X - poly[jminus].X,poly[j].Y - poly[jminus].Y);
         var vec2:IntPoint = new IntPoint(poly[jplus].X - poly[j].X,poly[jplus].Y - poly[j].Y);
         if(abs(vec1.X) > 1073741823 || abs(vec1.Y) > 1073741823 || abs(vec2.X) > 1073741823 || abs(vec2.Y) > 1073741823)
         {
            if(abs(vec1.X) > 1073741823 || abs(vec1.Y) > 1073741823 || abs(vec2.X) > 1073741823 || abs(vec2.Y) > 1073741823)
            {
               throw new ClipperException("Coordinate exceeds range bounds.");
            }
            return IntPoint.cross(vec1,vec2) >= 0;
         }
         return IntPoint.cross(vec1,vec2) >= 0;
      }
      
      override public function clear() : void
      {
         if(m_edges.length == 0)
         {
            return;
         }
         disposeAllPolyPts();
         super.clear();
      }
      
      private function disposeScanbeamList() : void
      {
         var sb2:* = null;
         while(m_Scanbeam != null)
         {
            sb2 = m_Scanbeam.next;
            m_Scanbeam = null;
            m_Scanbeam = sb2;
         }
      }
      
      override protected function reset() : void
      {
         super.reset();
         m_Scanbeam = null;
         m_ActiveEdges = null;
         m_SortedEdges = null;
         disposeAllPolyPts();
         var lm:LocalMinima = m_MinimaList;
         while(lm != null)
         {
            insertScanbeam(lm.Y);
            insertScanbeam(lm.leftBound.ytop);
            lm = lm.next;
         }
      }
      
      public function setReverseSolution(reverse:Boolean) : void
      {
         m_ReverseOutput = reverse;
      }
      
      public function getReverseSolution() : Boolean
      {
         return m_ReverseOutput;
      }
      
      private function insertScanbeam(Y:int) : void
      {
         var newSb:* = null;
         var sb2:* = null;
         if(m_Scanbeam == null)
         {
            m_Scanbeam = new Scanbeam();
            m_Scanbeam.next = null;
            m_Scanbeam.Y = Y;
         }
         else if(Y > m_Scanbeam.Y)
         {
            newSb = new Scanbeam();
            newSb.Y = Y;
            newSb.next = m_Scanbeam;
            m_Scanbeam = newSb;
         }
         else
         {
            sb2 = m_Scanbeam;
            while(sb2.next != null && Y <= sb2.next.Y)
            {
               sb2 = sb2.next;
            }
            if(Y == sb2.Y)
            {
               return;
            }
            newSb = new Scanbeam();
            newSb.Y = Y;
            newSb.next = sb2.next;
            sb2.next = newSb;
         }
      }
      
      public function execute(clipType:int, solution:Polygons, subjFillType:int, clipFillType:int) : Boolean
      {
         if(m_ExecuteLocked)
         {
            return false;
         }
         m_ExecuteLocked = true;
         solution.clear();
         m_SubjFillType = subjFillType;
         m_ClipFillType = clipFillType;
         m_ClipType = clipType;
         var succeeded:Boolean = executeInternal(false);
         if(succeeded)
         {
            buildResult(solution);
         }
         m_ExecuteLocked = false;
         return succeeded;
      }
      
      internal function findAppendLinkEnd(outRec:OutRec) : OutRec
      {
         while(outRec.appendLink != null)
         {
            outRec = outRec.appendLink;
         }
         return outRec;
      }
      
      internal function fixHoleLinkage(outRec:OutRec) : void
      {
         var tmp:* = null;
         if(outRec.bottomPt != null)
         {
            tmp = m_PolyOuts[outRec.bottomPt.idx].firstLeft;
         }
         else
         {
            tmp = outRec.firstLeft;
         }
         if(outRec == tmp)
         {
            throw new ClipperException("HoleLinkage error");
         }
         if(tmp != null)
         {
            if(tmp.appendLink != null)
            {
               tmp = findAppendLinkEnd(tmp);
            }
            if(tmp == outRec)
            {
               tmp = null;
            }
            else if(tmp.isHole)
            {
               fixHoleLinkage(tmp);
               tmp = tmp.firstLeft;
            }
         }
         outRec.firstLeft = tmp;
         if(tmp == null)
         {
            outRec.isHole = false;
         }
         outRec.appendLink = null;
      }
      
      private function executeInternal(fixHoleLinkages:Boolean) : Boolean
      {
         var succeeded:Boolean = false;
         var botY:* = 0;
         var topY:int = 0;
         try
         {
            reset();
            if(m_CurrentLM == null)
            {
               return true;
            }
            botY = popScanbeam();
            do
            {
               insertLocalMinimaIntoAEL(botY);
               m_HorizJoins.length = 0;
               processHorizontals();
               topY = popScanbeam();
               succeeded = processIntersections(botY,topY);
               if(!succeeded)
               {
                  break;
               }
               processEdgesAtTopOfScanbeam(topY);
               botY = topY;
            }
            while(m_Scanbeam != null);
            
         }
         catch(e:Error)
         {
            succeeded = false;
         }
         if(succeeded)
         {
            for each(var outRec in m_PolyOuts)
            {
               if(outRec.pts != null)
               {
                  fixupOutPolygon(outRec);
                  if(outRec.pts != null)
                  {
                     if(outRec.isHole && fixHoleLinkages)
                     {
                        fixHoleLinkage(outRec);
                     }
                     if(outRec.bottomPt == outRec.bottomFlag && orientationOutRec(outRec,m_UseFullRange) != areaOutRec(outRec,m_UseFullRange) > 0)
                     {
                        disposeBottomPt(outRec);
                     }
                     if(outRec.isHole == xor(m_ReverseOutput,orientationOutRec(outRec,m_UseFullRange)))
                     {
                        reversePolyPtLinks(outRec.pts);
                     }
                  }
               }
            }
            joinCommonEdges(fixHoleLinkages);
            if(fixHoleLinkages)
            {
               m_PolyOuts.sort(polySort);
            }
         }
         m_Joins.length = 0;
         m_HorizJoins.length = 0;
         return succeeded;
      }
      
      private function popScanbeam() : int
      {
         var Y:int = m_Scanbeam.Y;
         var sb2:Scanbeam = m_Scanbeam;
         m_Scanbeam = m_Scanbeam.next;
         sb2 = null;
         return Y;
      }
      
      private function disposeAllPolyPts() : void
      {
         var i:int = 0;
         for(i = 0; i < m_PolyOuts.length; disposeOutRec(i),i++)
         {
         }
         m_PolyOuts.length = 0;
      }
      
      private function disposeBottomPt(outRec:OutRec) : void
      {
         var next:OutPt = outRec.bottomPt.next;
         var prev:OutPt = outRec.bottomPt.prev;
         if(outRec.pts == outRec.bottomPt)
         {
            outRec.pts = next;
         }
         outRec.bottomPt = null;
         next.prev = prev;
         prev.next = next;
         outRec.bottomPt = next;
         fixupOutPolygon(outRec);
      }
      
      private function disposeOutRec(index:int) : void
      {
         var outRec:OutRec = m_PolyOuts[index];
         if(outRec.pts != null)
         {
            disposeOutPts(outRec.pts);
         }
         outRec = null;
         m_PolyOuts[index] = null;
      }
      
      private function disposeOutPts(pp:OutPt) : void
      {
         if(pp == null)
         {
            return;
         }
         var tmpPp:* = null;
         pp.prev.next = null;
         while(pp != null)
         {
            tmpPp = pp;
            pp = pp.next;
            tmpPp = null;
         }
      }
      
      private function addJoin(e1:TEdge, e2:TEdge, e1OutIdx:int, e2OutIdx:int) : void
      {
         var jr:JoinRec = new JoinRec();
         if(e1OutIdx >= 0)
         {
            jr.poly1Idx = e1OutIdx;
         }
         else
         {
            jr.poly1Idx = e1.outIdx;
         }
         jr.pt1a = new IntPoint(e1.xcurr,e1.ycurr);
         jr.pt1b = new IntPoint(e1.xtop,e1.ytop);
         if(e2OutIdx >= 0)
         {
            jr.poly2Idx = e2OutIdx;
         }
         else
         {
            jr.poly2Idx = e2.outIdx;
         }
         jr.pt2a = new IntPoint(e2.xcurr,e2.ycurr);
         jr.pt2b = new IntPoint(e2.xtop,e2.ytop);
         m_Joins.push(jr);
      }
      
      private function addHorzJoin(e:TEdge, idx:int) : void
      {
         var hj:HorzJoinRec = new HorzJoinRec();
         hj.edge = e;
         hj.savedIdx = idx;
         m_HorizJoins.push(hj);
      }
      
      private function insertLocalMinimaIntoAEL(botY:int) : void
      {
         var lb:* = null;
         var rb:* = null;
         var i:int = 0;
         var hj:* = null;
         var pt1a:* = null;
         var pt1b:* = null;
         var pt2a:* = null;
         var pt2b:* = null;
         var e:* = null;
         var pt:* = null;
         while(m_CurrentLM != null && m_CurrentLM.Y == botY)
         {
            lb = m_CurrentLM.leftBound;
            rb = m_CurrentLM.rightBound;
            insertEdgeIntoAEL(lb);
            insertScanbeam(lb.ytop);
            insertEdgeIntoAEL(rb);
            if(isEvenOddFillType(lb))
            {
               lb.windDelta = 1;
               rb.windDelta = 1;
            }
            else
            {
               rb.windDelta = -lb.windDelta;
            }
            setWindingCount(lb);
            rb.windCnt = lb.windCnt;
            rb.windCnt2 = lb.windCnt2;
            if(rb.dx == -3.4e+38)
            {
               addEdgeToSEL(rb);
               insertScanbeam(rb.nextInLML.ytop);
            }
            else
            {
               insertScanbeam(rb.ytop);
            }
            if(isContributing(lb))
            {
               addLocalMinPoly(lb,rb,new IntPoint(lb.xcurr,m_CurrentLM.Y));
            }
            if(rb.outIdx >= 0)
            {
               if(rb.dx == -3.4e+38)
               {
                  for(i = 0; i < m_HorizJoins.length; )
                  {
                     hj = m_HorizJoins[i];
                     pt1a = new IntPoint(hj.edge.xbot,hj.edge.ybot);
                     pt1b = new IntPoint(hj.edge.xtop,hj.edge.ytop);
                     pt2a = new IntPoint(rb.xbot,rb.ybot);
                     pt2b = new IntPoint(rb.xtop,rb.ytop);
                     if(getOverlapSegment(new Segment(pt1a,pt1b),new Segment(pt2a,pt2b),new Segment(null,null)))
                     {
                        addJoin(hj.edge,rb,hj.savedIdx,-1);
                     }
                     i++;
                  }
               }
            }
            if(lb.nextInAEL != rb)
            {
               if(rb.outIdx >= 0 && rb.prevInAEL.outIdx >= 0 && slopesEqual(rb.prevInAEL,rb,m_UseFullRange))
               {
                  addJoin(rb,rb.prevInAEL,-1,-1);
               }
               e = lb.nextInAEL;
               pt = new IntPoint(lb.xcurr,lb.ycurr);
               while(e != rb)
               {
                  if(e == null)
                  {
                     throw new ClipperException("InsertLocalMinimaIntoAEL: missing rightbound!");
                  }
                  intersectEdges(rb,e,pt,Protects.NONE);
                  e = e.nextInAEL;
               }
            }
            popLocalMinima();
         }
      }
      
      private function insertEdgeIntoAEL(edge:TEdge) : void
      {
         var e:* = null;
         edge.prevInAEL = null;
         edge.nextInAEL = null;
         if(m_ActiveEdges == null)
         {
            m_ActiveEdges = edge;
         }
         else if(E2InsertsBeforeE1(m_ActiveEdges,edge))
         {
            edge.nextInAEL = m_ActiveEdges;
            m_ActiveEdges.prevInAEL = edge;
            m_ActiveEdges = edge;
         }
         else
         {
            e = m_ActiveEdges;
            while(e.nextInAEL != null && !E2InsertsBeforeE1(e.nextInAEL,edge))
            {
               e = e.nextInAEL;
            }
            edge.nextInAEL = e.nextInAEL;
            if(e.nextInAEL != null)
            {
               e.nextInAEL.prevInAEL = edge;
            }
            edge.prevInAEL = e;
            e.nextInAEL = edge;
         }
      }
      
      private function E2InsertsBeforeE1(e1:TEdge, e2:TEdge) : Boolean
      {
         return e2.xcurr == e1.xcurr ? e2.dx > e1.dx : e2.xcurr < e1.xcurr;
      }
      
      private function isEvenOddFillType(edge:TEdge) : Boolean
      {
         if(edge.polyType == 0)
         {
            return m_SubjFillType == 0;
         }
         return m_ClipFillType == 0;
      }
      
      private function isEvenOddAltFillType(edge:TEdge) : Boolean
      {
         if(edge.polyType == 0)
         {
            return m_ClipFillType == 0;
         }
         return m_SubjFillType == 0;
      }
      
      private function isContributing(edge:TEdge) : Boolean
      {
         var pft2:int = 0;
         var pft:int = 0;
         if(edge.polyType == 0)
         {
            pft = m_SubjFillType;
            pft2 = m_ClipFillType;
         }
         else
         {
            pft = m_ClipFillType;
            pft2 = m_SubjFillType;
         }
         switch(pft)
         {
            case 0:
            case 1:
               if(abs(edge.windCnt) != 1)
               {
                  return false;
               }
               break;
            case 2:
               if(edge.windCnt != 1)
               {
                  return false;
               }
               break;
            default:
               if(edge.windCnt != -1)
               {
                  return false;
               }
               break;
         }
         switch(m_ClipType)
         {
            case 0:
               switch(pft2)
               {
                  case 0:
                  case 1:
                     return edge.windCnt2 != 0;
                  case 2:
                     return edge.windCnt2 > 0;
                  default:
                     return edge.windCnt2 < 0;
               }
               break;
            case 1:
               switch(pft2)
               {
                  case 0:
                  case 1:
                     return edge.windCnt2 == 0;
                  case 2:
                     return edge.windCnt2 <= 0;
                  default:
                     return edge.windCnt2 >= 0;
               }
               break;
            case 2:
               if(edge.polyType == 0)
               {
                  switch(pft2)
                  {
                     case 0:
                     case 1:
                        return edge.windCnt2 == 0;
                     case 2:
                        return edge.windCnt2 <= 0;
                     default:
                        return edge.windCnt2 >= 0;
                  }
               }
               else
               {
                  switch(pft2)
                  {
                     case 0:
                     case 1:
                        return edge.windCnt2 != 0;
                     case 2:
                        return edge.windCnt2 > 0;
                     default:
                        return edge.windCnt2 < 0;
                  }
               }
               break;
            default:
               return true;
         }
      }
      
      private function setWindingCount(edge:TEdge) : void
      {
         var e:TEdge = edge.prevInAEL;
         while(e != null && e.polyType != edge.polyType)
         {
            e = e.prevInAEL;
         }
         if(e == null)
         {
            edge.windCnt = edge.windDelta;
            edge.windCnt2 = 0;
            e = m_ActiveEdges;
         }
         else if(isEvenOddFillType(edge))
         {
            edge.windCnt = 1;
            edge.windCnt2 = e.windCnt2;
            e = e.nextInAEL;
         }
         else
         {
            if(e.windCnt * e.windDelta < 0)
            {
               if(abs(e.windCnt) > 1)
               {
                  if(e.windDelta * edge.windDelta < 0)
                  {
                     edge.windCnt = e.windCnt;
                  }
                  else
                  {
                     edge.windCnt = e.windCnt + edge.windDelta;
                  }
               }
               else
               {
                  edge.windCnt = e.windCnt + e.windDelta + edge.windDelta;
               }
            }
            else if(abs(e.windCnt) > 1 && e.windDelta * edge.windDelta < 0)
            {
               edge.windCnt = e.windCnt;
            }
            else if(e.windCnt + edge.windDelta == 0)
            {
               edge.windCnt = e.windCnt;
            }
            else
            {
               edge.windCnt = e.windCnt + edge.windDelta;
            }
            edge.windCnt2 = e.windCnt2;
            e = e.nextInAEL;
         }
         if(isEvenOddAltFillType(edge))
         {
            while(e != edge)
            {
               edge.windCnt2 = edge.windCnt2 == 0 ? 1 : 0;
               e = e.nextInAEL;
            }
         }
         else
         {
            while(e != edge)
            {
               edge.windCnt2 += e.windDelta;
               e = e.nextInAEL;
            }
         }
      }
      
      private function addEdgeToSEL(edge:TEdge) : void
      {
         if(m_SortedEdges == null)
         {
            m_SortedEdges = edge;
            edge.prevInSEL = null;
            edge.nextInSEL = null;
         }
         else
         {
            edge.nextInSEL = m_SortedEdges;
            edge.prevInSEL = null;
            m_SortedEdges.prevInSEL = edge;
            m_SortedEdges = edge;
         }
      }
      
      private function copyAELToSEL() : void
      {
         var e:TEdge = m_ActiveEdges;
         m_SortedEdges = e;
         if(m_ActiveEdges == null)
         {
            return;
         }
         m_SortedEdges.prevInSEL = null;
         e = e.nextInAEL;
         while(e != null)
         {
            e.prevInSEL = e.prevInAEL;
            e.prevInSEL.nextInSEL = e;
            e.nextInSEL = null;
            e = e.nextInAEL;
         }
      }
      
      private function swapPositionsInAEL(edge1:TEdge, edge2:TEdge) : void
      {
         var next:* = null;
         var prev:* = null;
         if(edge1.nextInAEL == null && edge1.prevInAEL == null)
         {
            return;
         }
         if(edge2.nextInAEL == null && edge2.prevInAEL == null)
         {
            return;
         }
         if(edge1.nextInAEL == edge2)
         {
            next = edge2.nextInAEL;
            if(next != null)
            {
               next.prevInAEL = edge1;
            }
            prev = edge1.prevInAEL;
            if(prev != null)
            {
               prev.nextInAEL = edge2;
            }
            edge2.prevInAEL = prev;
            edge2.nextInAEL = edge1;
            edge1.prevInAEL = edge2;
            edge1.nextInAEL = next;
         }
         else if(edge2.nextInAEL == edge1)
         {
            next = edge1.nextInAEL;
            if(next != null)
            {
               next.prevInAEL = edge2;
            }
            prev = edge2.prevInAEL;
            if(prev != null)
            {
               prev.nextInAEL = edge1;
            }
            edge1.prevInAEL = prev;
            edge1.nextInAEL = edge2;
            edge2.prevInAEL = edge1;
            edge2.nextInAEL = next;
         }
         else
         {
            next = edge1.nextInAEL;
            prev = edge1.prevInAEL;
            edge1.nextInAEL = edge2.nextInAEL;
            if(edge1.nextInAEL != null)
            {
               edge1.nextInAEL.prevInAEL = edge1;
            }
            edge1.prevInAEL = edge2.prevInAEL;
            if(edge1.prevInAEL != null)
            {
               edge1.prevInAEL.nextInAEL = edge1;
            }
            edge2.nextInAEL = next;
            if(edge2.nextInAEL != null)
            {
               edge2.nextInAEL.prevInAEL = edge2;
            }
            edge2.prevInAEL = prev;
            if(edge2.prevInAEL != null)
            {
               edge2.prevInAEL.nextInAEL = edge2;
            }
         }
         if(edge1.prevInAEL == null)
         {
            m_ActiveEdges = edge1;
         }
         else if(edge2.prevInAEL == null)
         {
            m_ActiveEdges = edge2;
         }
      }
      
      private function swapPositionsInSEL(edge1:TEdge, edge2:TEdge) : void
      {
         var next:* = null;
         var prev:* = null;
         if(edge1.nextInSEL == null && edge1.prevInSEL == null)
         {
            return;
         }
         if(edge2.nextInSEL == null && edge2.prevInSEL == null)
         {
            return;
         }
         if(edge1.nextInSEL == edge2)
         {
            next = edge2.nextInSEL;
            if(next != null)
            {
               next.prevInSEL = edge1;
            }
            prev = edge1.prevInSEL;
            if(prev != null)
            {
               prev.nextInSEL = edge2;
            }
            edge2.prevInSEL = prev;
            edge2.nextInSEL = edge1;
            edge1.prevInSEL = edge2;
            edge1.nextInSEL = next;
         }
         else if(edge2.nextInSEL == edge1)
         {
            next = edge1.nextInSEL;
            if(next != null)
            {
               next.prevInSEL = edge2;
            }
            prev = edge2.prevInSEL;
            if(prev != null)
            {
               prev.nextInSEL = edge1;
            }
            edge1.prevInSEL = prev;
            edge1.nextInSEL = edge2;
            edge2.prevInSEL = edge1;
            edge2.nextInSEL = next;
         }
         else
         {
            next = edge1.nextInSEL;
            prev = edge1.prevInSEL;
            edge1.nextInSEL = edge2.nextInSEL;
            if(edge1.nextInSEL != null)
            {
               edge1.nextInSEL.prevInSEL = edge1;
            }
            edge1.prevInSEL = edge2.prevInSEL;
            if(edge1.prevInSEL != null)
            {
               edge1.prevInSEL.nextInSEL = edge1;
            }
            edge2.nextInSEL = next;
            if(edge2.nextInSEL != null)
            {
               edge2.nextInSEL.prevInSEL = edge2;
            }
            edge2.prevInSEL = prev;
            if(edge2.prevInSEL != null)
            {
               edge2.prevInSEL.nextInSEL = edge2;
            }
         }
         if(edge1.prevInSEL == null)
         {
            m_SortedEdges = edge1;
         }
         else if(edge2.prevInSEL == null)
         {
            m_SortedEdges = edge2;
         }
      }
      
      private function addLocalMaxPoly(e1:TEdge, e2:TEdge, pt:IntPoint) : void
      {
         addOutPt(e1,pt);
         if(e1.outIdx == e2.outIdx)
         {
            e1.outIdx = -1;
            e2.outIdx = -1;
         }
         else if(e1.outIdx < e2.outIdx)
         {
            appendPolygon(e1,e2);
         }
         else
         {
            appendPolygon(e2,e1);
         }
      }
      
      private function addLocalMinPoly(e1:TEdge, e2:TEdge, pt:IntPoint) : void
      {
         var prevE:* = null;
         var e:* = null;
         if(e2.dx == -3.4e+38 || e1.dx > e2.dx)
         {
            addOutPt(e1,pt);
            e2.outIdx = e1.outIdx;
            e1.side = 1;
            e2.side = 2;
            e = e1;
            if(e.prevInAEL == e2)
            {
               prevE = e2.prevInAEL;
            }
            else
            {
               prevE = e.prevInAEL;
            }
         }
         else
         {
            addOutPt(e2,pt);
            e1.outIdx = e2.outIdx;
            e1.side = 2;
            e2.side = 1;
            e = e2;
            if(e.prevInAEL == e1)
            {
               prevE = e1.prevInAEL;
            }
            else
            {
               prevE = e.prevInAEL;
            }
         }
         if(prevE != null && prevE.outIdx >= 0 && topX(prevE,pt.Y) == topX(e,pt.Y) && slopesEqual(e,prevE,m_UseFullRange))
         {
            addJoin(e,prevE,-1,-1);
         }
      }
      
      private function createOutRec() : OutRec
      {
         var result:OutRec = new OutRec();
         result.idx = -1;
         result.isHole = false;
         result.firstLeft = null;
         result.appendLink = null;
         result.pts = null;
         result.bottomPt = null;
         result.bottomFlag = null;
         result.sides = 0;
         return result;
      }
      
      private function addOutPt(e:TEdge, pt:IntPoint) : void
      {
         var outRec:* = null;
         var op:* = null;
         var opBot:* = null;
         var op2:* = null;
         var toFront:Boolean = e.side == 1;
         if(e.outIdx < 0)
         {
            outRec = createOutRec();
            m_PolyOuts.push(outRec);
            outRec.idx = m_PolyOuts.length - 1;
            e.outIdx = outRec.idx;
            op = new OutPt();
            outRec.pts = op;
            outRec.bottomPt = op;
            op.pt = pt;
            op.idx = outRec.idx;
            op.next = op;
            op.prev = op;
            setHoleState(e,outRec);
         }
         else
         {
            outRec = m_PolyOuts[e.outIdx];
            op = outRec.pts;
            if(toFront && pointsEqual(pt,op.pt) || !toFront && pointsEqual(pt,op.prev.pt))
            {
               return;
            }
            if((e.side | outRec.sides) != outRec.sides)
            {
               if(outRec.sides == 0 && pt.Y == op.pt.Y)
               {
                  if(toFront)
                  {
                     if(pt.X == op.pt.X + 1)
                     {
                        return;
                     }
                  }
                  else if(pt.X == op.pt.X - 1)
                  {
                     return;
                  }
               }
               outRec.sides |= e.side;
               if(outRec.sides == 3)
               {
                  if(toFront)
                  {
                     opBot = outRec.pts;
                     op2 = opBot.next;
                     if(opBot.pt.Y != op2.pt.Y && opBot.pt.Y != pt.Y && (opBot.pt.X - pt.X) / (opBot.pt.Y - pt.Y) < (opBot.pt.X - op2.pt.X) / (opBot.pt.Y - op2.pt.Y))
                     {
                        outRec.bottomFlag = opBot;
                     }
                  }
                  else
                  {
                     opBot = outRec.pts.prev;
                     op2 = opBot.next;
                     if(opBot.pt.Y != op2.pt.Y && opBot.pt.Y != pt.Y && (opBot.pt.X - pt.X) / (opBot.pt.Y - pt.Y) > (opBot.pt.X - op2.pt.X) / (opBot.pt.Y - op2.pt.Y))
                     {
                        outRec.bottomFlag = opBot;
                     }
                  }
               }
            }
            op2 = new OutPt();
            op2.pt = pt;
            op2.idx = outRec.idx;
            if(op2.pt.Y == outRec.bottomPt.pt.Y && op2.pt.X < outRec.bottomPt.pt.X)
            {
               outRec.bottomPt = op2;
            }
            op2.next = op;
            op2.prev = op.prev;
            op2.prev.next = op2;
            op.prev = op2;
            if(toFront)
            {
               outRec.pts = op2;
            }
         }
      }
      
      private function getOverlapSegment(seg1:Segment, seg2:Segment, seg:Segment) : Boolean
      {
         if(seg1.pt1.Y == seg1.pt2.Y || abs((seg1.pt1.X - seg1.pt2.X) / (seg1.pt1.Y - seg1.pt2.Y)) > 1)
         {
            if(seg1.pt1.X > seg1.pt2.X)
            {
               seg1.swapPoints();
            }
            if(seg2.pt1.X > seg2.pt2.X)
            {
               seg2.swapPoints();
            }
            if(seg1.pt1.X > seg2.pt1.X)
            {
               seg.pt1 = seg1.pt1;
            }
            else
            {
               seg.pt1 = seg2.pt1;
            }
            if(seg1.pt2.X < seg2.pt2.X)
            {
               seg.pt2 = seg1.pt2;
            }
            else
            {
               seg.pt2 = seg2.pt2;
            }
            return seg.pt1.X < seg.pt2.X;
         }
         if(seg1.pt1.Y < seg1.pt2.Y)
         {
            seg1.swapPoints();
         }
         if(seg2.pt1.Y < seg2.pt2.Y)
         {
            seg2.swapPoints();
         }
         if(seg1.pt1.Y < seg2.pt1.Y)
         {
            seg.pt1 = seg1.pt1;
         }
         else
         {
            seg.pt1 = seg2.pt1;
         }
         if(seg1.pt2.Y > seg2.pt2.Y)
         {
            seg.pt2 = seg1.pt2;
         }
         else
         {
            seg.pt2 = seg2.pt2;
         }
         return seg.pt1.Y > seg.pt2.Y;
      }
      
      private function findSegment(ppRef:OutPtRef, seg:Segment) : Boolean
      {
         var seg2:* = null;
         var pp:OutPt = ppRef.outPt;
         if(pp == null)
         {
            return false;
         }
         var pp2:* = pp;
         var pt1a:IntPoint = seg.pt1;
         var pt2a:IntPoint = seg.pt2;
         var seg1:Segment = new Segment(pt1a,pt2a);
         while(true)
         {
            seg2 = new Segment(pp.pt,pp.prev.pt);
            if(slopesEqual4(pt1a,pt2a,pp.pt,pp.prev.pt,true) && slopesEqual3(pt1a,pt2a,pp.pt,true) && getOverlapSegment(seg1,seg2,seg))
            {
               break;
            }
            pp = pp.next;
            ppRef.outPt = pp;
            if(pp == pp2)
            {
               return false;
            }
         }
         return true;
      }
      
      internal function pt3IsBetweenPt1AndPt2(pt1:IntPoint, pt2:IntPoint, pt3:IntPoint) : Boolean
      {
         if(pointsEqual(pt1,pt3) || pointsEqual(pt2,pt3))
         {
            return true;
         }
         if(pt1.X != pt2.X)
         {
            return pt1.X < pt3.X == pt3.X < pt2.X;
         }
         return pt1.Y < pt3.Y == pt3.Y < pt2.Y;
      }
      
      private function insertPolyPtBetween(p1:OutPt, p2:OutPt, pt:IntPoint) : OutPt
      {
         var result:OutPt = new OutPt();
         result.pt = pt;
         if(p2 == p1.next)
         {
            p1.next = result;
            p2.prev = result;
            result.next = p2;
            result.prev = p1;
         }
         else
         {
            p2.next = result;
            p1.prev = result;
            result.next = p1;
            result.prev = p2;
         }
         return result;
      }
      
      private function setHoleState(e:TEdge, outRec:OutRec) : void
      {
         var isHole:Boolean = false;
         var e2:TEdge = e.prevInAEL;
         while(e2 != null)
         {
            if(e2.outIdx >= 0)
            {
               isHole = !isHole;
               if(outRec.firstLeft == null)
               {
                  outRec.firstLeft = m_PolyOuts[e2.outIdx];
               }
            }
            e2 = e2.prevInAEL;
         }
         if(isHole)
         {
            outRec.isHole = true;
         }
      }
      
      private function getDx(pt1:IntPoint, pt2:IntPoint) : Number
      {
         if(pt1.Y == pt2.Y)
         {
            return -3.4e+38;
         }
         return (pt2.X - pt1.X) / (pt2.Y - pt1.Y);
      }
      
      private function firstIsBottomPt(btmPt1:OutPt, btmPt2:OutPt) : Boolean
      {
         var p:OutPt = btmPt1.prev;
         while(pointsEqual(p.pt,btmPt1.pt) && p != btmPt1)
         {
            p = p.prev;
         }
         var dx1p:Number = Math.abs(getDx(btmPt1.pt,p.pt));
         p = btmPt1.next;
         while(pointsEqual(p.pt,btmPt1.pt) && p != btmPt1)
         {
            p = p.next;
         }
         var dx1n:Number = Math.abs(getDx(btmPt1.pt,p.pt));
         p = btmPt2.prev;
         while(pointsEqual(p.pt,btmPt2.pt) && p != btmPt2)
         {
            p = p.prev;
         }
         var dx2p:Number = Math.abs(getDx(btmPt2.pt,p.pt));
         p = btmPt2.next;
         while(pointsEqual(p.pt,btmPt2.pt) && p != btmPt2)
         {
            p = p.next;
         }
         var dx2n:Number = Math.abs(getDx(btmPt2.pt,p.pt));
         return dx1p >= dx2p && dx1p >= dx2n || dx1n >= dx2p && dx1n >= dx2n;
      }
      
      private function getBottomPt(pp:OutPt) : OutPt
      {
         var dups:* = null;
         var p:OutPt = pp.next;
         while(p != pp)
         {
            if(p.pt.Y > pp.pt.Y)
            {
               pp = p;
               dups = null;
            }
            else if(p.pt.Y == pp.pt.Y && p.pt.X <= pp.pt.X)
            {
               if(p.pt.X < pp.pt.X)
               {
                  dups = null;
                  pp = p;
               }
               else if(p.next != pp && p.prev != pp)
               {
                  dups = p;
               }
            }
            p = p.next;
         }
         if(dups != null)
         {
            while(dups != p)
            {
               if(!firstIsBottomPt(p,dups))
               {
                  pp = dups;
               }
               dups = dups.next;
               while(!pointsEqual(dups.pt,pp.pt))
               {
                  dups = dups.next;
               }
            }
         }
         return pp;
      }
      
      private function getLowermostRec(outRec1:OutRec, outRec2:OutRec) : OutRec
      {
         var bPt1:OutPt = outRec1.bottomPt;
         var bPt2:OutPt = outRec2.bottomPt;
         if(bPt1.pt.Y > bPt2.pt.Y)
         {
            return outRec1;
         }
         if(bPt1.pt.Y < bPt2.pt.Y)
         {
            return outRec2;
         }
         if(bPt1.pt.X < bPt2.pt.X)
         {
            return outRec1;
         }
         if(bPt1.pt.X > bPt2.pt.X)
         {
            return outRec2;
         }
         if(bPt1.next == bPt1)
         {
            return outRec2;
         }
         if(bPt2.next == bPt2)
         {
            return outRec1;
         }
         if(firstIsBottomPt(bPt1,bPt2))
         {
            return outRec1;
         }
         return outRec2;
      }
      
      private function param1RightOfParam2(outRec1:OutRec, outRec2:OutRec) : Boolean
      {
         while(true)
         {
            outRec1 = outRec1.firstLeft;
            if(outRec1 == outRec2)
            {
               break;
            }
            if(outRec1 == null)
            {
               return false;
            }
         }
         return true;
      }
      
      private function appendPolygon(e1:TEdge, e2:TEdge) : void
      {
         var holeStateRec:* = null;
         var side:int = 0;
         var i:int = 0;
         var outRec1:OutRec = m_PolyOuts[e1.outIdx];
         var outRec2:OutRec = m_PolyOuts[e2.outIdx];
         if(param1RightOfParam2(outRec1,outRec2))
         {
            holeStateRec = outRec2;
         }
         else if(param1RightOfParam2(outRec2,outRec1))
         {
            holeStateRec = outRec1;
         }
         else
         {
            holeStateRec = getLowermostRec(outRec1,outRec2);
         }
         var p1_lft:OutPt = outRec1.pts;
         var p1_rt:OutPt = p1_lft.prev;
         var p2_lft:OutPt = outRec2.pts;
         var p2_rt:OutPt = p2_lft.prev;
         if(e1.side == 1)
         {
            if(e2.side == 1)
            {
               reversePolyPtLinks(p2_lft);
               p2_lft.next = p1_lft;
               p1_lft.prev = p2_lft;
               p1_rt.next = p2_rt;
               p2_rt.prev = p1_rt;
               outRec1.pts = p2_rt;
            }
            else
            {
               p2_rt.next = p1_lft;
               p1_lft.prev = p2_rt;
               p2_lft.prev = p1_rt;
               p1_rt.next = p2_lft;
               outRec1.pts = p2_lft;
            }
            side = 1;
         }
         else
         {
            if(e2.side == 2)
            {
               reversePolyPtLinks(p2_lft);
               p1_rt.next = p2_rt;
               p2_rt.prev = p1_rt;
               p2_lft.next = p1_lft;
               p1_lft.prev = p2_lft;
            }
            else
            {
               p1_rt.next = p2_lft;
               p2_lft.prev = p1_rt;
               p1_lft.prev = p2_rt;
               p2_rt.next = p1_lft;
            }
            side = 2;
         }
         if(holeStateRec == outRec2)
         {
            outRec1.bottomPt = outRec2.bottomPt;
            outRec1.bottomPt.idx = outRec1.idx;
            if(outRec2.firstLeft != outRec1)
            {
               outRec1.firstLeft = outRec2.firstLeft;
            }
            outRec1.isHole = outRec2.isHole;
         }
         outRec2.pts = null;
         outRec2.bottomPt = null;
         outRec2.appendLink = outRec1;
         var oKIdx:int = e1.outIdx;
         var obsoleteIdx:int = e2.outIdx;
         e1.outIdx = -1;
         e2.outIdx = -1;
         var e:TEdge = m_ActiveEdges;
         while(e != null)
         {
            if(e.outIdx == obsoleteIdx)
            {
               e.outIdx = oKIdx;
               e.side = side;
               break;
            }
            e = e.nextInAEL;
         }
         i = 0;
         while(i < m_Joins.length)
         {
            if(m_Joins[i].poly1Idx == obsoleteIdx)
            {
               m_Joins[i].poly1Idx = oKIdx;
            }
            if(m_Joins[i].poly2Idx == obsoleteIdx)
            {
               m_Joins[i].poly2Idx = oKIdx;
            }
            i++;
         }
         for(i = 0; i < m_HorizJoins.length; )
         {
            if(m_HorizJoins[i].savedIdx == obsoleteIdx)
            {
               m_HorizJoins[i].savedIdx = oKIdx;
            }
            i++;
         }
      }
      
      private function reversePolyPtLinks(pp:OutPt) : void
      {
         var pp1:* = null;
         var pp2:* = null;
         pp1 = pp;
         do
         {
            pp2 = pp1.next;
            pp1.next = pp1.prev;
            pp1.prev = pp2;
            pp1 = pp2;
         }
         while(pp1 != pp);
         
      }
      
      private function doEdge1(edge1:TEdge, edge2:TEdge, pt:IntPoint) : void
      {
         addOutPt(edge1,pt);
         swapSides(edge1,edge2);
         swapPolyIndexes(edge1,edge2);
      }
      
      private function doEdge2(edge1:TEdge, edge2:TEdge, pt:IntPoint) : void
      {
         addOutPt(edge2,pt);
         swapSides(edge1,edge2);
         swapPolyIndexes(edge1,edge2);
      }
      
      private function doBothEdges(edge1:TEdge, edge2:TEdge, pt:IntPoint) : void
      {
         addOutPt(edge1,pt);
         addOutPt(edge2,pt);
         swapSides(edge1,edge2);
         swapPolyIndexes(edge1,edge2);
      }
      
      private function intersectEdges(e1:TEdge, e2:TEdge, pt:IntPoint, protects:int) : void
      {
         var oldE1WindCnt:int = 0;
         var e2FillType:int = 0;
         var e1FillType2:int = 0;
         var e2FillType2:int = 0;
         var e1FillType:int = 0;
         var e2Wc:int = 0;
         var e1Wc:int = 0;
         var e2Wc2:int = 0;
         var e1Wc2:int = 0;
         var e1stops:Boolean = (1 & protects) == 0 && e1.nextInLML == null && e1.xtop == pt.X && e1.ytop == pt.Y;
         var e2stops:Boolean = (2 & protects) == 0 && e2.nextInLML == null && e2.xtop == pt.X && e2.ytop == pt.Y;
         var e1Contributing:Boolean = e1.outIdx >= 0;
         var e2contributing:Boolean = e2.outIdx >= 0;
         if(e1.polyType == e2.polyType)
         {
            if(isEvenOddFillType(e1))
            {
               oldE1WindCnt = e1.windCnt;
               e1.windCnt = e2.windCnt;
               e2.windCnt = oldE1WindCnt;
            }
            else
            {
               if(e1.windCnt + e2.windDelta == 0)
               {
                  e1.windCnt = -e1.windCnt;
               }
               else
               {
                  e1.windCnt += e2.windDelta;
               }
               if(e2.windCnt - e1.windDelta == 0)
               {
                  e2.windCnt = -e2.windCnt;
               }
               else
               {
                  e2.windCnt -= e1.windDelta;
               }
            }
         }
         else
         {
            if(!isEvenOddFillType(e2))
            {
               e1.windCnt2 += e2.windDelta;
            }
            else
            {
               e1.windCnt2 = e1.windCnt2 == 0 ? 1 : 0;
            }
            if(!isEvenOddFillType(e1))
            {
               e2.windCnt2 -= e1.windDelta;
            }
            else
            {
               e2.windCnt2 = e2.windCnt2 == 0 ? 1 : 0;
            }
         }
         if(e1.polyType == 0)
         {
            e1FillType = m_SubjFillType;
            e1FillType2 = m_ClipFillType;
         }
         else
         {
            e1FillType = m_ClipFillType;
            e1FillType2 = m_SubjFillType;
         }
         if(e2.polyType == 0)
         {
            e2FillType = m_SubjFillType;
            e2FillType2 = m_ClipFillType;
         }
         else
         {
            e2FillType = m_ClipFillType;
            e2FillType2 = m_SubjFillType;
         }
         switch(e1FillType - 2)
         {
            case 0:
               e1Wc = e1.windCnt;
               break;
            case 1:
               e1Wc = -e1.windCnt;
               break;
            default:
               e1Wc = abs(e1.windCnt);
         }
         switch(e2FillType - 2)
         {
            case 0:
               e2Wc = e2.windCnt;
               break;
            case 1:
               e2Wc = -e2.windCnt;
               break;
            default:
               e2Wc = abs(e2.windCnt);
         }
         if(e1Contributing && e2contributing)
         {
            if(e1stops || e2stops || e1Wc != 0 && e1Wc != 1 || e2Wc != 0 && e2Wc != 1 || e1.polyType != e2.polyType && m_ClipType != 3)
            {
               addLocalMaxPoly(e1,e2,pt);
            }
            else
            {
               doBothEdges(e1,e2,pt);
            }
         }
         else if(e1Contributing)
         {
            if((e2Wc == 0 || e2Wc == 1) && (m_ClipType != 0 || e2.polyType == 0 || e2.windCnt2 != 0))
            {
               doEdge1(e1,e2,pt);
            }
         }
         else if(e2contributing)
         {
            if((e1Wc == 0 || e1Wc == 1) && (m_ClipType != 0 || e1.polyType == 0 || e1.windCnt2 != 0))
            {
               doEdge2(e1,e2,pt);
            }
         }
         else if((e1Wc == 0 || e1Wc == 1) && (e2Wc == 0 || e2Wc == 1) && !e1stops && !e2stops)
         {
            switch(e1FillType2 - 2)
            {
               case 0:
                  e1Wc2 = e1.windCnt2;
                  break;
               case 1:
                  e1Wc2 = -e1.windCnt2;
                  break;
               default:
                  e1Wc2 = abs(e1.windCnt2);
            }
            switch(e2FillType2 - 2)
            {
               case 0:
                  e2Wc2 = e2.windCnt2;
                  break;
               case 1:
                  e2Wc2 = -e2.windCnt2;
                  break;
               default:
                  e2Wc2 = abs(e2.windCnt2);
            }
            if(e1.polyType != e2.polyType)
            {
               addLocalMinPoly(e1,e2,pt);
            }
            else if(e1Wc == 1 && e2Wc == 1)
            {
               switch(m_ClipType)
               {
                  case 0:
                     if(e1Wc2 > 0 && e2Wc2 > 0)
                     {
                        addLocalMinPoly(e1,e2,pt);
                        break;
                     }
                     break;
                  case 1:
                     if(e1Wc2 <= 0 && e2Wc2 <= 0)
                     {
                        addLocalMinPoly(e1,e2,pt);
                        break;
                     }
                     break;
                  case 2:
                     if(e1.polyType == 1 && e1Wc2 > 0 && e2Wc2 > 0 || e1.polyType == 0 && e1Wc2 <= 0 && e2Wc2 <= 0)
                     {
                        addLocalMinPoly(e1,e2,pt);
                        break;
                     }
                     break;
                  case 3:
                     addLocalMinPoly(e1,e2,pt);
               }
            }
            else
            {
               swapSides(e1,e2);
            }
         }
         if(e1stops != e2stops && (e1stops && e1.outIdx >= 0 || e2stops && e2.outIdx >= 0))
         {
            swapSides(e1,e2);
            swapPolyIndexes(e1,e2);
         }
         if(e1stops)
         {
            deleteFromAEL(e1);
         }
         if(e2stops)
         {
            deleteFromAEL(e2);
         }
      }
      
      private function deleteFromAEL(e:TEdge) : void
      {
         var AelPrev:TEdge = e.prevInAEL;
         var AelNext:TEdge = e.nextInAEL;
         if(AelPrev == null && AelNext == null && e != m_ActiveEdges)
         {
            return;
         }
         if(AelPrev != null)
         {
            AelPrev.nextInAEL = AelNext;
         }
         else
         {
            m_ActiveEdges = AelNext;
         }
         if(AelNext != null)
         {
            AelNext.prevInAEL = AelPrev;
         }
         e.nextInAEL = null;
         e.prevInAEL = null;
      }
      
      private function deleteFromSEL(e:TEdge) : void
      {
         var SelPrev:TEdge = e.prevInSEL;
         var SelNext:TEdge = e.nextInSEL;
         if(SelPrev == null && SelNext == null && e != m_SortedEdges)
         {
            return;
         }
         if(SelPrev != null)
         {
            SelPrev.nextInSEL = SelNext;
         }
         else
         {
            m_SortedEdges = SelNext;
         }
         if(SelNext != null)
         {
            SelNext.prevInSEL = SelPrev;
         }
         e.nextInSEL = null;
         e.prevInSEL = null;
      }
      
      private function updateEdgeIntoAEL(e:TEdge) : TEdge
      {
         if(e.nextInLML == null)
         {
            throw new ClipperException("UpdateEdgeIntoAEL: invalid call");
         }
         var AelPrev:TEdge = e.prevInAEL;
         var AelNext:TEdge = e.nextInAEL;
         e.nextInLML.outIdx = e.outIdx;
         if(AelPrev != null)
         {
            AelPrev.nextInAEL = e.nextInLML;
         }
         else
         {
            m_ActiveEdges = e.nextInLML;
         }
         if(AelNext != null)
         {
            AelNext.prevInAEL = e.nextInLML;
         }
         e.nextInLML.side = e.side;
         e.nextInLML.windDelta = e.windDelta;
         e.nextInLML.windCnt = e.windCnt;
         e.nextInLML.windCnt2 = e.windCnt2;
         e = e.nextInLML;
         e.prevInAEL = AelPrev;
         e.nextInAEL = AelNext;
         if(e.dx != -3.4e+38)
         {
            insertScanbeam(e.ytop);
         }
         return e;
      }
      
      private function processHorizontals() : void
      {
         var horzEdge:TEdge = m_SortedEdges;
         while(horzEdge != null)
         {
            deleteFromSEL(horzEdge);
            processHorizontal(horzEdge);
            horzEdge = m_SortedEdges;
         }
      }
      
      private function processHorizontal(horzEdge:TEdge) : void
      {
         var direction:int = 0;
         var horzRight:int = 0;
         var horzLeft:int = 0;
         var eMaxPair:* = null;
         var eNext:* = null;
         if(horzEdge.xcurr < horzEdge.xtop)
         {
            horzLeft = horzEdge.xcurr;
            horzRight = horzEdge.xtop;
            direction = 1;
         }
         else
         {
            horzLeft = horzEdge.xtop;
            horzRight = horzEdge.xcurr;
            direction = Direction.RIGHT_TO_LEFT;
         }
         if(horzEdge.nextInLML != null)
         {
            eMaxPair = null;
         }
         else
         {
            eMaxPair = getMaximaPair(horzEdge);
         }
         var e:* = getNextInAEL(horzEdge,direction);
         while(e != null)
         {
            eNext = getNextInAEL(e,direction);
            if(eMaxPair != null || direction == 1 && e.xcurr <= horzRight || direction == Direction.RIGHT_TO_LEFT && e.xcurr >= horzLeft)
            {
               if(e.xcurr == horzEdge.xtop && eMaxPair == null)
               {
                  if(slopesEqual(e,horzEdge.nextInLML,m_UseFullRange))
                  {
                     if(horzEdge.outIdx >= 0 && e.outIdx >= 0)
                     {
                        addJoin(horzEdge.nextInLML,e,horzEdge.outIdx,-1);
                        break;
                     }
                     break;
                  }
                  if(e.dx < horzEdge.nextInLML.dx)
                  {
                     break;
                  }
               }
               if(e == eMaxPair)
               {
                  if(direction == 1)
                  {
                     intersectEdges(horzEdge,e,new IntPoint(e.xcurr,horzEdge.ycurr),0);
                  }
                  else
                  {
                     intersectEdges(e,horzEdge,new IntPoint(e.xcurr,horzEdge.ycurr),0);
                  }
                  if(eMaxPair.outIdx >= 0)
                  {
                     throw new ClipperException("ProcessHorizontal error");
                  }
                  return;
               }
               if(e.dx == -3.4e+38 && !isMinima(e) && e.xcurr <= e.xtop)
               {
                  if(direction == 1)
                  {
                     intersectEdges(horzEdge,e,new IntPoint(e.xcurr,horzEdge.ycurr),isTopHorz(horzEdge,e.xcurr) ? 1 : 3);
                  }
                  else
                  {
                     intersectEdges(e,horzEdge,new IntPoint(e.xcurr,horzEdge.ycurr),isTopHorz(horzEdge,e.xcurr) ? 2 : 3);
                  }
               }
               else if(direction == 1)
               {
                  intersectEdges(horzEdge,e,new IntPoint(e.xcurr,horzEdge.ycurr),isTopHorz(horzEdge,e.xcurr) ? 1 : 3);
               }
               else
               {
                  intersectEdges(e,horzEdge,new IntPoint(e.xcurr,horzEdge.ycurr),isTopHorz(horzEdge,e.xcurr) ? 2 : 3);
               }
               swapPositionsInAEL(horzEdge,e);
            }
            else if(direction == 1 && e.xcurr > horzRight && horzEdge.nextInSEL == null || direction == Direction.RIGHT_TO_LEFT && e.xcurr < horzLeft && horzEdge.nextInSEL == null)
            {
               break;
            }
            e = eNext;
         }
         if(horzEdge.nextInLML != null)
         {
            if(horzEdge.outIdx >= 0)
            {
               addOutPt(horzEdge,new IntPoint(horzEdge.xtop,horzEdge.ytop));
            }
            horzEdge = updateEdgeIntoAEL(horzEdge);
         }
         else
         {
            if(horzEdge.outIdx >= 0)
            {
               intersectEdges(horzEdge,eMaxPair,new IntPoint(horzEdge.xtop,horzEdge.ycurr),3);
            }
            deleteFromAEL(eMaxPair);
            deleteFromAEL(horzEdge);
         }
      }
      
      private function isTopHorz(horzEdge:TEdge, XPos:Number) : Boolean
      {
         var e:TEdge = m_SortedEdges;
         while(e != null)
         {
            if(XPos >= Math.min(e.xcurr,e.xtop) && XPos <= Math.max(e.xcurr,e.xtop))
            {
               return false;
            }
            e = e.nextInSEL;
         }
         return true;
      }
      
      private function processIntersections(botY:int, topY:int) : Boolean
      {
         if(m_ActiveEdges == null)
         {
            return true;
         }
         try
         {
            buildIntersectList(botY,topY);
            if(m_IntersectNodes == null)
            {
               return true;
            }
            if(!fixupIntersections())
            {
               return false;
            }
            processIntersectList();
         }
         catch(e:Error)
         {
            m_SortedEdges = null;
            disposeIntersectNodes();
            throw new ClipperException("ProcessIntersections error");
         }
         return true;
      }
      
      private function buildIntersectList(botY:int, topY:int) : void
      {
         var eNext:* = null;
         var pt:* = null;
         if(m_ActiveEdges == null)
         {
            return;
         }
         var e:* = m_ActiveEdges;
         e.tmpX = topX(e,topY);
         m_SortedEdges = e;
         m_SortedEdges.prevInSEL = null;
         e = e.nextInAEL;
         while(e != null)
         {
            e.prevInSEL = e.prevInAEL;
            e.prevInSEL.nextInSEL = e;
            e.nextInSEL = null;
            e.tmpX = topX(e,topY);
            e = e.nextInAEL;
         }
         var isModified:Boolean = true;
         while(isModified && m_SortedEdges != null)
         {
            isModified = false;
            e = m_SortedEdges;
            while(e.nextInSEL != null)
            {
               eNext = e.nextInSEL;
               pt = new IntPoint();
               if(e.tmpX > eNext.tmpX && intersectPoint(e,eNext,pt))
               {
                  if(pt.Y > botY)
                  {
                     pt.Y = botY;
                     pt.X = topX(e,pt.Y);
                  }
                  addIntersectNode(e,eNext,pt);
                  swapPositionsInSEL(e,eNext);
                  isModified = true;
               }
               else
               {
                  e = eNext;
               }
            }
            if(e.prevInSEL == null)
            {
               break;
            }
            e.prevInSEL.nextInSEL = null;
         }
         m_SortedEdges = null;
      }
      
      private function fixupIntersections() : Boolean
      {
         var e1:* = null;
         var e2:* = null;
         if(m_IntersectNodes.next == null)
         {
            return true;
         }
         copyAELToSEL();
         var int1:IntersectNode = m_IntersectNodes;
         var int2:IntersectNode = m_IntersectNodes.next;
         while(true)
         {
            if(int2 == null)
            {
               m_SortedEdges = null;
               return int1.edge1.prevInSEL == int1.edge2 || int1.edge1.nextInSEL == int1.edge2;
            }
            e1 = int1.edge1;
            if(e1.prevInSEL == int1.edge2)
            {
               e2 = e1.prevInSEL;
            }
            else if(e1.nextInSEL == int1.edge2)
            {
               e2 = e1.nextInSEL;
            }
            else
            {
               while(int2 != null)
               {
                  if(int2.edge1.nextInSEL == int2.edge2 || int2.edge1.prevInSEL == int2.edge2)
                  {
                     break;
                  }
                  int2 = int2.next;
               }
               if(int2 == null)
               {
                  break;
               }
               swapIntersectNodes(int1,int2);
               e1 = int1.edge1;
               e2 = int1.edge2;
            }
            swapPositionsInSEL(e1,e2);
            int1 = int1.next;
            int2 = int1.next;
         }
         return false;
      }
      
      private function processIntersectList() : void
      {
         var iNode:* = null;
         while(m_IntersectNodes != null)
         {
            iNode = m_IntersectNodes.next;
            intersectEdges(m_IntersectNodes.edge1,m_IntersectNodes.edge2,m_IntersectNodes.pt,3);
            swapPositionsInAEL(m_IntersectNodes.edge1,m_IntersectNodes.edge2);
            m_IntersectNodes = null;
            m_IntersectNodes = iNode;
         }
      }
      
      private function addIntersectNode(e1:TEdge, e2:TEdge, pt:IntPoint) : void
      {
         var iNode:* = null;
         var newNode:IntersectNode = new IntersectNode();
         newNode.edge1 = e1;
         newNode.edge2 = e2;
         newNode.pt = pt;
         newNode.next = null;
         if(m_IntersectNodes == null)
         {
            m_IntersectNodes = newNode;
         }
         else if(processParam1BeforeParam2(newNode,m_IntersectNodes))
         {
            newNode.next = m_IntersectNodes;
            m_IntersectNodes = newNode;
         }
         else
         {
            iNode = m_IntersectNodes;
            while(iNode.next != null && processParam1BeforeParam2(iNode.next,newNode))
            {
               iNode = iNode.next;
            }
            newNode.next = iNode.next;
            iNode.next = newNode;
         }
      }
      
      private function processParam1BeforeParam2(node1:IntersectNode, node2:IntersectNode) : Boolean
      {
         var result:Boolean = false;
         if(node1.pt.Y == node2.pt.Y)
         {
            if(node1.edge1 == node2.edge1 || node1.edge2 == node2.edge1)
            {
               result = node2.pt.X > node1.pt.X;
               return node2.edge1.dx > 0 ? !result : result;
            }
            if(node1.edge1 == node2.edge2 || node1.edge2 == node2.edge2)
            {
               result = node2.pt.X > node1.pt.X;
               return node2.edge2.dx > 0 ? !result : result;
            }
            return node2.pt.X > node1.pt.X;
         }
         return node1.pt.Y > node2.pt.Y;
      }
      
      private function swapIntersectNodes(int1:IntersectNode, int2:IntersectNode) : void
      {
         var e1:TEdge = int1.edge1;
         var e2:TEdge = int1.edge2;
         var p:IntPoint = int1.pt;
         int1.edge1 = int2.edge1;
         int1.edge2 = int2.edge2;
         int1.pt = int2.pt;
         int2.edge1 = e1;
         int2.edge2 = e2;
         int2.pt = p;
      }
      
      private function intersectPoint(edge1:TEdge, edge2:TEdge, ip:IntPoint) : Boolean
      {
         var b2:Number = NaN;
         var b1:Number = NaN;
         if(slopesEqual(edge1,edge2,m_UseFullRange))
         {
            return false;
         }
         if(edge1.dx == 0)
         {
            ip.X = edge1.xbot;
            if(edge2.dx == -3.4e+38)
            {
               ip.Y = edge2.ybot;
            }
            else
            {
               b2 = edge2.ybot - edge2.xbot / edge2.dx;
               ip.Y = round(ip.X / edge2.dx + b2);
            }
         }
         else if(edge2.dx == 0)
         {
            ip.X = edge2.xbot;
            if(edge1.dx == -3.4e+38)
            {
               ip.Y = edge1.ybot;
            }
            else
            {
               b1 = edge1.ybot - edge1.xbot / edge1.dx;
               ip.Y = round(ip.X / edge1.dx + b1);
            }
         }
         else
         {
            b1 = edge1.xbot - edge1.ybot * edge1.dx;
            b2 = edge2.xbot - edge2.ybot * edge2.dx;
            b2 = (b2 - b1) / (edge1.dx - edge2.dx);
            ip.Y = round(b2);
            ip.X = round(edge1.dx * b2 + b1);
         }
         return ip.Y == edge1.ytop && ip.Y >= edge2.ytop && edge1.tmpX > edge2.tmpX || ip.Y == edge2.ytop && ip.Y >= edge1.ytop && edge1.tmpX > edge2.tmpX || ip.Y > edge1.ytop && ip.Y > edge2.ytop;
      }
      
      private function disposeIntersectNodes() : void
      {
         var iNode:* = null;
         while(m_IntersectNodes != null)
         {
            iNode = m_IntersectNodes.next;
            m_IntersectNodes = null;
            m_IntersectNodes = iNode;
         }
      }
      
      private function processEdgesAtTopOfScanbeam(topY:int) : void
      {
         var ePrior:* = null;
         var i:int = 0;
         var hj:* = null;
         var pt1a:* = null;
         var pt1b:* = null;
         var pt2a:* = null;
         var pt2b:* = null;
         var e:TEdge = m_ActiveEdges;
         while(e != null)
         {
            if(isMaxima(e,topY) && getMaximaPair(e).dx != -3.4e+38)
            {
               ePrior = e.prevInAEL;
               doMaxima(e,topY);
               if(ePrior == null)
               {
                  e = m_ActiveEdges;
               }
               else
               {
                  e = ePrior.nextInAEL;
               }
            }
            else
            {
               if(isIntermediate(e,topY) && e.nextInLML.dx == -3.4e+38)
               {
                  if(e.outIdx >= 0)
                  {
                     addOutPt(e,new IntPoint(e.xtop,e.ytop));
                     for(i = 0; i < m_HorizJoins.length; )
                     {
                        hj = m_HorizJoins[i];
                        pt1a = new IntPoint(hj.edge.xbot,hj.edge.ybot);
                        pt1b = new IntPoint(hj.edge.xtop,hj.edge.ytop);
                        pt2a = new IntPoint(e.nextInLML.xbot,e.nextInLML.ybot);
                        pt2b = new IntPoint(e.nextInLML.xtop,e.nextInLML.ytop);
                        if(getOverlapSegment(new Segment(pt1a,pt1b),new Segment(pt2a,pt2b),new Segment(null,null)))
                        {
                           addJoin(hj.edge,e.nextInLML,hj.savedIdx,e.outIdx);
                        }
                        i++;
                     }
                     addHorzJoin(e.nextInLML,e.outIdx);
                  }
                  e = updateEdgeIntoAEL(e);
                  addEdgeToSEL(e);
               }
               else
               {
                  e.xcurr = topX(e,topY);
                  e.ycurr = topY;
               }
               e = e.nextInAEL;
            }
         }
         processHorizontals();
         e = m_ActiveEdges;
         while(e != null)
         {
            if(isIntermediate(e,topY))
            {
               if(e.outIdx >= 0)
               {
                  addOutPt(e,new IntPoint(e.xtop,e.ytop));
               }
               e = updateEdgeIntoAEL(e);
               if(e.outIdx >= 0 && e.prevInAEL != null && e.prevInAEL.outIdx >= 0 && e.prevInAEL.xcurr == e.xbot && e.prevInAEL.ycurr == e.ybot && slopesEqual4(new IntPoint(e.xbot,e.ybot),new IntPoint(e.xtop,e.ytop),new IntPoint(e.xbot,e.ybot),new IntPoint(e.prevInAEL.xtop,e.prevInAEL.ytop),m_UseFullRange))
               {
                  addOutPt(e.prevInAEL,new IntPoint(e.xbot,e.ybot));
                  addJoin(e,e.prevInAEL,-1,-1);
               }
               else if(e.outIdx >= 0 && e.nextInAEL != null && e.nextInAEL.outIdx >= 0 && e.nextInAEL.ycurr > e.nextInAEL.ytop && e.nextInAEL.ycurr <= e.nextInAEL.ybot && e.nextInAEL.xcurr == e.xbot && e.nextInAEL.ycurr == e.ybot && slopesEqual4(new IntPoint(e.xbot,e.ybot),new IntPoint(e.xtop,e.ytop),new IntPoint(e.xbot,e.ybot),new IntPoint(e.nextInAEL.xtop,e.nextInAEL.ytop),m_UseFullRange))
               {
                  addOutPt(e.nextInAEL,new IntPoint(e.xbot,e.ybot));
                  addJoin(e,e.nextInAEL,-1,-1);
               }
            }
            e = e.nextInAEL;
         }
      }
      
      private function doMaxima(e:TEdge, topY:int) : void
      {
         var eMaxPair:TEdge = getMaximaPair(e);
         var X:int = e.xtop;
         var eNext:TEdge = e.nextInAEL;
         while(eNext != eMaxPair)
         {
            if(eNext == null)
            {
               throw new ClipperException("DoMaxima error");
            }
            intersectEdges(e,eNext,new IntPoint(X,topY),3);
            eNext = eNext.nextInAEL;
         }
         if(e.outIdx < 0 && eMaxPair.outIdx < 0)
         {
            deleteFromAEL(e);
            deleteFromAEL(eMaxPair);
         }
         else
         {
            if(!(e.outIdx >= 0 && eMaxPair.outIdx >= 0))
            {
               throw new ClipperException("DoMaxima error");
            }
            intersectEdges(e,eMaxPair,new IntPoint(X,topY),Protects.NONE);
         }
      }
      
      private function orientationOutRec(outRec:OutRec, useFull64BitRange:Boolean) : Boolean
      {
         var opBottom:* = outRec.pts;
         var op:* = outRec.pts.next;
         while(op != outRec.pts)
         {
            if(op.pt.Y >= opBottom.pt.Y)
            {
               if(op.pt.Y > opBottom.pt.Y || op.pt.X < opBottom.pt.X)
               {
                  opBottom = op;
               }
            }
            op = op.next;
         }
         outRec.bottomPt = opBottom;
         opBottom.idx = outRec.idx;
         op = opBottom;
         var opPrev:OutPt = op.prev;
         var opNext:OutPt = op.next;
         while(op != opPrev && pointsEqual(op.pt,opPrev.pt))
         {
            opPrev = opPrev.prev;
         }
         while(op != opNext && pointsEqual(op.pt,opNext.pt))
         {
            opNext = opNext.next;
         }
         var vec1:IntPoint = new IntPoint(op.pt.X - opPrev.pt.X,op.pt.Y - opPrev.pt.Y);
         var vec2:IntPoint = new IntPoint(opNext.pt.X - op.pt.X,opNext.pt.Y - op.pt.Y);
         if(useFull64BitRange)
         {
            return IntPoint.cross(vec1,vec2) >= 0;
         }
         return IntPoint.cross(vec1,vec2) >= 0;
      }
      
      private function pointCount(pts:OutPt) : int
      {
         if(pts == null)
         {
            return 0;
         }
         var result:int = 0;
         var p:* = pts;
         do
         {
            result++;
            p = p.next;
         }
         while(p != pts);
         
         return result;
      }
      
      private function buildResult(polyg:Polygons) : void
      {
         var p:* = null;
         var cnt:int = 0;
         var pg:* = null;
         var j:int = 0;
         polyg.clear();
         for each(var outRec in m_PolyOuts)
         {
            if(outRec.pts != null)
            {
               p = outRec.pts;
               cnt = pointCount(p);
               if(cnt >= 3)
               {
                  pg = new Polygon();
                  for(j = 0; j < cnt; )
                  {
                     pg.addPoint(p.pt);
                     p = p.next;
                     j++;
                  }
                  polyg.addPolygon(pg);
               }
            }
         }
      }
      
      private function fixupOutPolygon(outRec:OutRec) : void
      {
         var tmp:* = null;
         var lastOK:* = null;
         outRec.pts = outRec.bottomPt;
         var pp:OutPt = outRec.bottomPt;
         while(!(pp.prev == pp || pp.prev == pp.next))
         {
            if(pointsEqual(pp.pt,pp.next.pt) || slopesEqual3(pp.prev.pt,pp.pt,pp.next.pt,m_UseFullRange))
            {
               lastOK = null;
               tmp = pp;
               if(pp == outRec.bottomPt)
               {
                  outRec.bottomPt = null;
               }
               pp.prev.next = pp.next;
               pp.next.prev = pp.prev;
               pp = pp.prev;
               tmp = null;
            }
            else
            {
               if(pp == lastOK)
               {
                  if(outRec.bottomPt == null)
                  {
                     outRec.bottomPt = getBottomPt(pp);
                     outRec.bottomPt.idx = outRec.idx;
                     outRec.pts = outRec.bottomPt;
                  }
                  return;
               }
               if(lastOK == null)
               {
                  lastOK = pp;
               }
               pp = pp.next;
            }
         }
         disposeOutPts(pp);
         outRec.pts = null;
         outRec.bottomPt = null;
      }
      
      private function checkHoleLinkages1(outRec1:OutRec, outRec2:OutRec) : void
      {
         var i:int = 0;
         for(i = 0; i < m_PolyOuts.length; )
         {
            if(m_PolyOuts[i].isHole && m_PolyOuts[i].bottomPt != null && m_PolyOuts[i].firstLeft == outRec1 && !pointInPolygon(m_PolyOuts[i].bottomPt.pt,outRec1.pts,m_UseFullRange))
            {
               m_PolyOuts[i].firstLeft = outRec2;
            }
            i++;
         }
      }
      
      private function checkHoleLinkages2(outRec1:OutRec, outRec2:OutRec) : void
      {
         var i:int = 0;
         for(i = 0; i < m_PolyOuts.length; )
         {
            if(m_PolyOuts[i].isHole && m_PolyOuts[i].bottomPt != null && m_PolyOuts[i].firstLeft == outRec2)
            {
               m_PolyOuts[i].firstLeft = outRec1;
            }
            i++;
         }
      }
      
      private function joinCommonEdges(fixHoleLinkages:Boolean) : void
      {
         var i:int = 0;
         var j:* = null;
         var outRec1:* = null;
         var pp1aRef:* = null;
         var outRec2:* = null;
         var pp2aRef:* = null;
         var seg1:* = null;
         var seg2:* = null;
         var seg:* = null;
         var pt1:* = null;
         var pt2:* = null;
         var pt3:* = null;
         var pt4:* = null;
         var pp1a:* = null;
         var pp2a:* = null;
         var p2:* = null;
         var p3:* = null;
         var p4:* = null;
         var p1:* = null;
         var prev:* = null;
         var k:int = 0;
         var j2:* = null;
         var OKIdx:int = 0;
         var ObsoleteIdx:int = 0;
         for(i = 0; i < m_Joins.length; i++)
         {
            j = m_Joins[i];
            outRec1 = m_PolyOuts[j.poly1Idx];
            pp1aRef = new OutPtRef(outRec1.pts);
            outRec2 = m_PolyOuts[j.poly2Idx];
            pp2aRef = new OutPtRef(outRec2.pts);
            seg1 = new Segment(j.pt2a,j.pt2b);
            seg2 = new Segment(j.pt1a,j.pt1b);
            if(findSegment(pp1aRef,seg1))
            {
               if(j.poly1Idx == j.poly2Idx)
               {
                  pp2aRef.outPt = pp1aRef.outPt.next;
                  if(!findSegment(pp2aRef,seg2) || pp2aRef.outPt == pp1aRef.outPt)
                  {
                     continue;
                  }
               }
               else if(!findSegment(pp2aRef,seg2))
               {
                  continue;
               }
               seg = new Segment(null,null);
               if(getOverlapSegment(seg1,seg2,seg))
               {
                  pt1 = seg.pt1;
                  pt2 = seg.pt2;
                  pt3 = seg2.pt1;
                  pt4 = seg2.pt2;
                  pp1a = pp1aRef.outPt;
                  pp2a = pp2aRef.outPt;
                  prev = pp1a.prev;
                  if(pointsEqual(pp1a.pt,pt1))
                  {
                     p1 = pp1a;
                  }
                  else if(pointsEqual(prev.pt,pt1))
                  {
                     p1 = prev;
                  }
                  else
                  {
                     p1 = insertPolyPtBetween(pp1a,prev,pt1);
                  }
                  if(pointsEqual(pp1a.pt,pt2))
                  {
                     p2 = pp1a;
                  }
                  else if(pointsEqual(prev.pt,pt2))
                  {
                     p2 = prev;
                  }
                  else if(p1 == pp1a || p1 == prev)
                  {
                     p2 = insertPolyPtBetween(pp1a,prev,pt2);
                  }
                  else if(pt3IsBetweenPt1AndPt2(pp1a.pt,p1.pt,pt2))
                  {
                     p2 = insertPolyPtBetween(pp1a,p1,pt2);
                  }
                  else
                  {
                     p2 = insertPolyPtBetween(p1,prev,pt2);
                  }
                  prev = pp2a.prev;
                  if(pointsEqual(pp2a.pt,pt1))
                  {
                     p3 = pp2a;
                  }
                  else if(pointsEqual(prev.pt,pt1))
                  {
                     p3 = prev;
                  }
                  else
                  {
                     p3 = insertPolyPtBetween(pp2a,prev,pt1);
                  }
                  if(pointsEqual(pp2a.pt,pt2))
                  {
                     p4 = pp2a;
                  }
                  else if(pointsEqual(prev.pt,pt2))
                  {
                     p4 = prev;
                  }
                  else if(p3 == pp2a || p3 == prev)
                  {
                     p4 = insertPolyPtBetween(pp2a,prev,pt2);
                  }
                  else if(pt3IsBetweenPt1AndPt2(pp2a.pt,p3.pt,pt2))
                  {
                     p4 = insertPolyPtBetween(pp2a,p3,pt2);
                  }
                  else
                  {
                     p4 = insertPolyPtBetween(p3,prev,pt2);
                  }
                  if(p1.next == p2 && p3.prev == p4)
                  {
                     p1.next = p3;
                     p3.prev = p1;
                     p2.prev = p4;
                     p4.next = p2;
                  }
                  else
                  {
                     if(!(p1.prev == p2 && p3.next == p4))
                     {
                        continue;
                     }
                     p1.prev = p3;
                     p3.next = p1;
                     p2.next = p4;
                     p4.prev = p2;
                  }
                  if(j.poly2Idx == j.poly1Idx)
                  {
                     outRec1.pts = getBottomPt(p1);
                     outRec1.bottomPt = outRec1.pts;
                     outRec1.bottomPt.idx = outRec1.idx;
                     outRec2 = createOutRec();
                     m_PolyOuts.push(outRec2);
                     outRec2.idx = m_PolyOuts.length - 1;
                     j.poly2Idx = outRec2.idx;
                     outRec2.pts = getBottomPt(p2);
                     outRec2.bottomPt = outRec2.pts;
                     outRec2.bottomPt.idx = outRec2.idx;
                     if(pointInPolygon(outRec2.pts.pt,outRec1.pts,m_UseFullRange))
                     {
                        outRec2.isHole = !outRec1.isHole;
                        outRec2.firstLeft = outRec1;
                        if(outRec2.isHole == xor(m_ReverseOutput,orientationOutRec(outRec2,m_UseFullRange)))
                        {
                           reversePolyPtLinks(outRec2.pts);
                        }
                     }
                     else if(pointInPolygon(outRec1.pts.pt,outRec2.pts,m_UseFullRange))
                     {
                        outRec2.isHole = outRec1.isHole;
                        outRec1.isHole = !outRec2.isHole;
                        outRec2.firstLeft = outRec1.firstLeft;
                        outRec1.firstLeft = outRec2;
                        if(outRec1.isHole == xor(m_ReverseOutput,orientationOutRec(outRec1,m_UseFullRange)))
                        {
                           reversePolyPtLinks(outRec1.pts);
                        }
                        if(fixHoleLinkages)
                        {
                           checkHoleLinkages1(outRec1,outRec2);
                        }
                     }
                     else
                     {
                        outRec2.isHole = outRec1.isHole;
                        outRec2.firstLeft = outRec1.firstLeft;
                        if(fixHoleLinkages)
                        {
                           checkHoleLinkages1(outRec1,outRec2);
                        }
                     }
                     for(k = i + 1; k < m_Joins.length; )
                     {
                        j2 = m_Joins[k];
                        if(j2.poly1Idx == j.poly1Idx && pointIsVertex(j2.pt1a,p2))
                        {
                           j2.poly1Idx = j.poly2Idx;
                        }
                        if(j2.poly2Idx == j.poly1Idx && pointIsVertex(j2.pt2a,p2))
                        {
                           j2.poly2Idx = j.poly2Idx;
                        }
                        k++;
                     }
                     fixupOutPolygon(outRec1);
                     fixupOutPolygon(outRec2);
                     if(orientationOutRec(outRec1,m_UseFullRange) != areaOutRec(outRec1,m_UseFullRange) > 0)
                     {
                        disposeBottomPt(outRec1);
                     }
                     if(orientationOutRec(outRec2,m_UseFullRange) != areaOutRec(outRec2,m_UseFullRange) > 0)
                     {
                        disposeBottomPt(outRec2);
                     }
                  }
                  else
                  {
                     if(fixHoleLinkages)
                     {
                        checkHoleLinkages2(outRec1,outRec2);
                     }
                     fixupOutPolygon(outRec1);
                     if(outRec1.pts != null)
                     {
                        outRec1.isHole = !orientationOutRec(outRec1,m_UseFullRange);
                        if(outRec1.isHole && outRec1.firstLeft == null)
                        {
                           outRec1.firstLeft = outRec2.firstLeft;
                        }
                     }
                     OKIdx = outRec1.idx;
                     ObsoleteIdx = outRec2.idx;
                     outRec2.pts = null;
                     outRec2.bottomPt = null;
                     outRec2.appendLink = outRec1;
                     for(k = i + 1; k < m_Joins.length; )
                     {
                        j2 = m_Joins[k];
                        if(j2.poly1Idx == ObsoleteIdx)
                        {
                           j2.poly1Idx = OKIdx;
                        }
                        if(j2.poly2Idx == ObsoleteIdx)
                        {
                           j2.poly2Idx = OKIdx;
                        }
                        k++;
                     }
                  }
               }
            }
         }
      }
      
      private function areaOutRec(outRec:OutRec, useFull64BitRange:Boolean) : Number
      {
         var op:OutPt = outRec.pts;
         var a:Number = 0;
         do
         {
            a += op.prev.pt.X * op.pt.Y - op.pt.X * op.prev.pt.Y;
            op = op.next;
         }
         while(op != outRec.pts);
         
         return a / 2;
      }
   }
}

final class Protects
{
   
   public static const NONE:int = 0;
   
   public static const LEFT:int = 1;
   
   public static const RIGHT:int = 2;
   
   public static const BOTH:int = 3;
    
   
   public function Protects()
   {
      super();
   }
}

final class Direction
{
   
   public static const RIGHT_TO_LEFT:int = 0;
   
   public static const LEFT_TO_RIGHT:int = 1;
    
   
   public function Direction()
   {
      super();
   }
}

final class Scanbeam
{
    
   
   public var Y:int;
   
   public var next:Scanbeam;
   
   public function Scanbeam()
   {
      super();
   }
}

import com.logicom.geom.IntPoint;

final class JoinRec
{
    
   
   public var pt1a:IntPoint;
   
   public var pt1b:IntPoint;
   
   public var poly1Idx:int;
   
   public var pt2a:IntPoint;
   
   public var pt2b:IntPoint;
   
   public var poly2Idx:int;
   
   public function JoinRec()
   {
      super();
   }
}
