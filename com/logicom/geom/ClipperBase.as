package com.logicom.geom
{
   public class ClipperBase
   {
      
      internal static const horizontal:Number = -3.4e+38;
      
      internal static const loRange:int = 1073741823;
      
      internal static const hiRange:int = 1073741823;
       
      
      internal var m_MinimaList:LocalMinima;
      
      internal var m_CurrentLM:LocalMinima;
      
      internal var m_edges:Vector.<Vector.<TEdge>>;
      
      internal var m_UseFullRange:Boolean;
      
      public function ClipperBase()
      {
         m_edges = new Vector.<Vector.<TEdge>>();
         super();
         m_MinimaList = null;
         m_CurrentLM = null;
         m_UseFullRange = false;
      }
      
      public static function abs(i:int) : int
      {
         return i < 0 ? -i : i;
      }
      
      public static function xor(lhs:Boolean, rhs:Boolean) : Boolean
      {
         return !(lhs && rhs) && (lhs || rhs);
      }
      
      protected static function pointsEqual(pt1:IntPoint, pt2:IntPoint) : Boolean
      {
         return pt1.equals(pt2);
      }
      
      internal function pointIsVertex(pt:IntPoint, pp:OutPt) : Boolean
      {
         var pp2:* = pp;
         while(!pointsEqual(pp2.pt,pt))
         {
            pp2 = pp2.next;
            if(pp2 == pp)
            {
               return false;
            }
         }
         return true;
      }
      
      internal function pointInPolygon(pt:IntPoint, pp:OutPt, useFulllongRange:Boolean) : Boolean
      {
         var pp2:* = pp;
         var result:Boolean = false;
         do
         {
            if((pp2.pt.Y <= pt.Y && pt.Y < pp2.prev.pt.Y || pp2.prev.pt.Y <= pt.Y && pt.Y < pp2.pt.Y) && pt.X - pp2.pt.X < (pp2.prev.pt.X - pp2.pt.X) * (pt.Y - pp2.pt.Y) / (pp2.prev.pt.Y - pp2.pt.Y))
            {
               result = !result;
            }
            pp2 = pp2.next;
         }
         while(pp2 != pp);
         
         return result;
      }
      
      internal function slopesEqual(e1:TEdge, e2:TEdge, useFullRange:Boolean) : Boolean
      {
         return (e1.ytop - e1.ybot) * (e2.xtop - e2.xbot) - (e1.xtop - e1.xbot) * (e2.ytop - e2.ybot) == 0;
      }
      
      protected function slopesEqual3(pt1:IntPoint, pt2:IntPoint, pt3:IntPoint, useFullRange:Boolean) : Boolean
      {
         return (pt1.Y - pt2.Y) * (pt2.X - pt3.X) - (pt1.X - pt2.X) * (pt2.Y - pt3.Y) == 0;
      }
      
      protected function slopesEqual4(pt1:IntPoint, pt2:IntPoint, pt3:IntPoint, pt4:IntPoint, useFullRange:Boolean) : Boolean
      {
         return (pt1.Y - pt2.Y) * (pt3.X - pt4.X) - (pt1.X - pt2.X) * (pt3.Y - pt4.Y) == 0;
      }
      
      public function clear() : void
      {
         var i:int = 0;
         var j:int = 0;
         disposeLocalMinimaList();
         for(i = 0; i < m_edges.length; )
         {
            for(j = 0; j < m_edges[i].length; m_edges[i][j] = null,j++)
            {
            }
            m_edges[i].length = 0;
            i++;
         }
         m_edges.length = 0;
         m_UseFullRange = false;
      }
      
      private function disposeLocalMinimaList() : void
      {
         var tmpLm:* = null;
         while(m_MinimaList != null)
         {
            tmpLm = m_MinimaList.next;
            m_MinimaList = null;
            m_MinimaList = tmpLm;
         }
         m_CurrentLM = null;
      }
      
      public function addPolygons(ppg:Polygons, polyType:int) : Boolean
      {
         var result:Boolean = false;
         for each(var polygon in ppg.getPolygons())
         {
            if(addPolygon(polygon,polyType))
            {
               result = true;
            }
         }
         return result;
      }
      
      public function addPolygon(polygon:Polygon, polyType:int) : Boolean
      {
         var i:int = 0;
         var maxVal:int = 0;
         var pg:Vector.<IntPoint> = polygon.getPoints();
         var len:int = pg.length;
         if(len < 3)
         {
            return false;
         }
         var newPoly:Polygon = new Polygon();
         var p:Vector.<IntPoint> = newPoly.getPoints();
         p.push(pg[0]);
         var j:int = 0;
         for(i = 1; i < len; )
         {
            if(m_UseFullRange)
            {
               maxVal = 1073741823;
            }
            else
            {
               maxVal = 1073741823;
            }
            if(abs(pg[i].X) > maxVal || abs(pg[i].Y) > maxVal)
            {
               if(abs(pg[i].X) > 1073741823 || abs(pg[i].Y) > 1073741823)
               {
                  throw new ClipperException("Coordinate exceeds range bounds");
               }
               maxVal = 1073741823;
               m_UseFullRange = true;
            }
            if(!pointsEqual(p[j],pg[i]))
            {
               if(j > 0 && slopesEqual3(p[j - 1],p[j],pg[i],m_UseFullRange))
               {
                  if(pointsEqual(p[j - 1],pg[i]))
                  {
                     j--;
                  }
               }
               else
               {
                  j++;
               }
               if(j < p.length)
               {
                  p[j] = pg[i];
               }
               else
               {
                  p.push(pg[i]);
               }
            }
            i++;
         }
         if(j < 2)
         {
            return false;
         }
         len = j + 1;
         while(len > 2)
         {
            if(pointsEqual(p[j],p[0]))
            {
               j--;
            }
            else if(pointsEqual(p[0],p[1]) || slopesEqual3(p[j],p[0],p[1],m_UseFullRange))
            {
               p[0] = p[j--];
            }
            else if(slopesEqual3(p[j - 1],p[j],p[0],m_UseFullRange))
            {
               j--;
            }
            else
            {
               if(!slopesEqual3(p[0],p[1],p[2],m_UseFullRange))
               {
                  break;
               }
               for(i = 2; i <= j; p[i - 1] = p[i],i++)
               {
               }
               j--;
            }
            len--;
         }
         if(len < 3)
         {
            return false;
         }
         var edges:Vector.<TEdge> = new Vector.<TEdge>(len);
         for(i = 0; i < len; edges[i] = new TEdge(),i++)
         {
         }
         m_edges.push(edges);
         edges[0].xcurr = p[0].X;
         edges[0].ycurr = p[0].Y;
         initEdge(edges[len - 1],edges[0],edges[len - 2],p[len - 1],polyType);
         for(i = len - 2; i > 0; )
         {
            initEdge(edges[i],edges[i + 1],edges[i - 1],p[i],polyType);
            i--;
         }
         initEdge(edges[0],edges[1],edges[len - 1],p[0],polyType);
         var e:* = edges[0];
         var eHighest:* = e;
         do
         {
            e.xcurr = e.xbot;
            e.ycurr = e.ybot;
            if(e.ytop < eHighest.ytop)
            {
               eHighest = e;
            }
            e = e.next;
         }
         while(e != edges[0]);
         
         if(eHighest.windDelta > 0)
         {
            eHighest = eHighest.next;
         }
         if(eHighest.dx == -3.4e+38)
         {
            eHighest = eHighest.next;
         }
         e = eHighest;
         do
         {
            e = addBoundsToLML(e);
         }
         while(e != eHighest);
         
         return true;
      }
      
      private function initEdge(e:TEdge, eNext:TEdge, ePrev:TEdge, pt:IntPoint, polyType:int) : void
      {
         e.next = eNext;
         e.prev = ePrev;
         e.xcurr = pt.X;
         e.ycurr = pt.Y;
         if(e.ycurr >= e.next.ycurr)
         {
            e.xbot = e.xcurr;
            e.ybot = e.ycurr;
            e.xtop = e.next.xcurr;
            e.ytop = e.next.ycurr;
            e.windDelta = 1;
         }
         else
         {
            e.xtop = e.xcurr;
            e.ytop = e.ycurr;
            e.xbot = e.next.xcurr;
            e.ybot = e.next.ycurr;
            e.windDelta = -1;
         }
         setDx(e);
         e.polyType = polyType;
         e.outIdx = -1;
      }
      
      private function setDx(e:TEdge) : void
      {
         if(e.ybot == e.ytop)
         {
            e.dx = -3.4e+38;
         }
         else
         {
            e.dx = (e.xtop - e.xbot) / (e.ytop - e.ybot);
         }
      }
      
      private function addBoundsToLML(e:TEdge) : TEdge
      {
         e.nextInLML = null;
         e = e.next;
         while(true)
         {
            if(e.dx == -3.4e+38)
            {
               if(e.next.ytop < e.ytop && e.next.xbot > e.prev.xbot)
               {
                  §§goto(addr80);
               }
               if(e.xtop != e.prev.xbot)
               {
                  swapX(e);
               }
               e.nextInLML = e.prev;
            }
            else
            {
               if(e.ycurr == e.prev.ycurr)
               {
                  break;
               }
               e.nextInLML = e.prev;
            }
            e = e.next;
         }
         addr80:
         var newLm:LocalMinima = new LocalMinima();
         newLm.next = null;
         newLm.Y = e.prev.ybot;
         if(e.dx == -3.4e+38)
         {
            if(e.xbot != e.prev.xbot)
            {
               swapX(e);
            }
            newLm.leftBound = e.prev;
            newLm.rightBound = e;
         }
         else if(e.dx < e.prev.dx)
         {
            newLm.leftBound = e.prev;
            newLm.rightBound = e;
         }
         else
         {
            newLm.leftBound = e;
            newLm.rightBound = e.prev;
         }
         newLm.leftBound.side = 1;
         newLm.rightBound.side = 2;
         insertLocalMinima(newLm);
         while(!(e.next.ytop == e.ytop && e.next.dx != -3.4e+38))
         {
            e.nextInLML = e.next;
            e = e.next;
            if(e.dx == -3.4e+38 && e.xbot != e.prev.xtop)
            {
               swapX(e);
            }
         }
         return e.next;
      }
      
      private function insertLocalMinima(newLm:LocalMinima) : void
      {
         var tmpLm:* = null;
         if(m_MinimaList == null)
         {
            m_MinimaList = newLm;
         }
         else if(newLm.Y >= m_MinimaList.Y)
         {
            newLm.next = m_MinimaList;
            m_MinimaList = newLm;
         }
         else
         {
            tmpLm = m_MinimaList;
            while(tmpLm.next != null && newLm.Y < tmpLm.next.Y)
            {
               tmpLm = tmpLm.next;
            }
            newLm.next = tmpLm.next;
            tmpLm.next = newLm;
         }
      }
      
      protected function popLocalMinima() : void
      {
         if(m_CurrentLM == null)
         {
            return;
         }
         m_CurrentLM = m_CurrentLM.next;
      }
      
      private function swapX(e:TEdge) : void
      {
         e.xcurr = e.xtop;
         e.xtop = e.xbot;
         e.xbot = e.xcurr;
      }
      
      protected function reset() : void
      {
         var e:* = null;
         m_CurrentLM = m_MinimaList;
         var lm:LocalMinima = m_MinimaList;
         while(lm != null)
         {
            e = lm.leftBound;
            while(e != null)
            {
               e.xcurr = e.xbot;
               e.ycurr = e.ybot;
               e.side = 1;
               e.outIdx = -1;
               e = e.nextInLML;
            }
            e = lm.rightBound;
            while(e != null)
            {
               e.xcurr = e.xbot;
               e.ycurr = e.ybot;
               e.side = 2;
               e.outIdx = -1;
               e = e.nextInLML;
            }
            lm = lm.next;
         }
      }
      
      public function getBounds() : IntRect
      {
         var e:* = null;
         var bottomE:* = null;
         var result:IntRect = new IntRect(0,0,0,0);
         var lm:LocalMinima = m_MinimaList;
         if(lm == null)
         {
            return result;
         }
         result.left = lm.leftBound.xbot;
         result.top = lm.leftBound.ybot;
         result.right = lm.leftBound.xbot;
         result.bottom = lm.leftBound.ybot;
         while(lm != null)
         {
            if(lm.leftBound.ybot > result.bottom)
            {
               result.bottom = lm.leftBound.ybot;
            }
            e = lm.leftBound;
            while(true)
            {
               bottomE = e;
               while(e.nextInLML != null)
               {
                  if(e.xbot < result.left)
                  {
                     result.left = e.xbot;
                  }
                  if(e.xbot > result.right)
                  {
                     result.right = e.xbot;
                  }
                  e = e.nextInLML;
               }
               if(e.xbot < result.left)
               {
                  result.left = e.xbot;
               }
               if(e.xbot > result.right)
               {
                  result.right = e.xbot;
               }
               if(e.xtop < result.left)
               {
                  result.left = e.xtop;
               }
               if(e.xtop > result.right)
               {
                  result.right = e.xtop;
               }
               if(e.ytop < result.top)
               {
                  result.top = e.ytop;
               }
               if(bottomE != lm.leftBound)
               {
                  break;
               }
               e = lm.rightBound;
            }
            lm = lm.next;
         }
         return result;
      }
   }
}
