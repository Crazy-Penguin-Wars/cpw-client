package no.olog
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   internal class ODisplayListCrawler
   {
      
      private static const TAB:String = " . ";
      
      private static var _numInstances:uint;
       
      
      public function ODisplayListCrawler()
      {
         super();
      }
      
      internal static function getTree(root:DisplayObjectContainer, currentDepth:uint = 0, maxDepth:uint = 10, property:String = null, rootsChildIndex:int = -1) : String
      {
         var child:* = null;
         var j:int = 0;
         var rootsChildIndexString:* = null;
         var i:int = 0;
         var tabs:String = "";
         var tree:String = "";
         var numChildren:int = root.numChildren;
         if(currentDepth == 0)
         {
            _numInstances = 1;
         }
         for(j = currentDepth; j > 0; )
         {
            tabs += " . ";
            j--;
         }
         if(rootsChildIndex != -1)
         {
            rootsChildIndexString = rootsChildIndex + ".";
         }
         else if(root.parent)
         {
            rootsChildIndexString = root.parent.getChildIndex(root) + ".";
         }
         else
         {
            rootsChildIndexString = "X.";
         }
         tree += "\n" + tabs + rootsChildIndexString + root.toString().match(/(?<=\s|\.)\w+(?=\]|$)/)[0] + _getPropertyValue(root,property);
         tabs += " . ";
         for(i = numChildren - 1; i > -1; )
         {
            _numInstances++;
            child = root.getChildAt(i);
            if(child is DisplayObjectContainer && currentDepth < maxDepth - 1)
            {
               tree += getTree(child as DisplayObjectContainer,currentDepth + 1,maxDepth,property,i);
            }
            else
            {
               tree += "\n" + tabs + i + "." + child.toString().match(/(?<=\s|\.)\w+(?=\]|$)/)[0] + _getPropertyValue(child,property);
            }
            i--;
         }
         return tree;
      }
      
      private static function _getPropertyValue(child:DisplayObject, property:String = null) : String
      {
         if(!property)
         {
            return "";
         }
         var result:String = "";
         var isFunction:Boolean = false;
         if(property.indexOf("(") != -1)
         {
            property = property.substr(0,property.indexOf("("));
            isFunction = true;
         }
         if(property && child.hasOwnProperty(property))
         {
            if(!isFunction)
            {
               result = "." + property + " = " + child[property];
            }
            else
            {
               try
               {
                  result = "." + property + "() returned " + String(child[property]());
               }
               catch(e:Error)
               {
                  result = " ERROR " + property + "() expects arguments";
               }
            }
         }
         return result;
      }
      
      public static function get numInstances() : uint
      {
         return _numInstances;
      }
   }
}
