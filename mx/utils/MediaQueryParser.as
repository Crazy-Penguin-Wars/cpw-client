package mx.utils
{
   import flash.system.Capabilities;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   
   public class MediaQueryParser
   {
      
      public static var platformMap:Object = {
         "AND":"android",
         "IOS":"ios",
         "MAC":"macintosh",
         "WIN":"windows",
         "LNX":"linux",
         "QNX":"qnx"
      };
      
      private static var _instance:MediaQueryParser;
       
      
      mx_internal var goodQueries:Object;
      
      mx_internal var badQueries:Object;
      
      public var type:String = "screen";
      
      public var applicationDpi:Number;
      
      public var osPlatform:String;
      
      public function MediaQueryParser(moduleFactory:IFlexModuleFactory = null)
      {
         this.mx_internal::goodQueries = {};
         this.mx_internal::badQueries = {};
         super();
         this.applicationDpi = DensityUtil.getRuntimeDPI();
         if(Boolean(moduleFactory))
         {
            if(moduleFactory.info()["applicationDPI"] != null)
            {
               this.applicationDpi = moduleFactory.info()["applicationDPI"];
            }
         }
         this.osPlatform = this.getPlatform();
      }
      
      public static function get instance() : MediaQueryParser
      {
         return _instance;
      }
      
      public static function set instance(value:MediaQueryParser) : void
      {
         if(!_instance)
         {
            _instance = value;
         }
      }
      
      public function parse(expression:String) : Boolean
      {
         var result:Boolean = false;
         var mediaQuery:String = null;
         var notFlag:Boolean = false;
         var expressions:Array = null;
         var numExpressions:int = 0;
         expression = StringUtil.trim(expression);
         expression = expression.toLowerCase();
         if(expression == "")
         {
            return true;
         }
         if(expression == "all")
         {
            return true;
         }
         if(Boolean(this.mx_internal::goodQueries[expression]))
         {
            return true;
         }
         if(Boolean(this.mx_internal::badQueries[expression]))
         {
            return false;
         }
         var mediaQueries:Array = expression.split(", ");
         var n:int = mediaQueries.length;
         for(var i:int = 0; i < n; i++)
         {
            mediaQuery = mediaQueries[i];
            notFlag = false;
            if(mediaQuery.indexOf("only ") == 0)
            {
               mediaQuery = mediaQuery.substr(5);
            }
            if(mediaQuery.indexOf("not ") == 0)
            {
               notFlag = true;
               mediaQuery = mediaQuery.substr(4);
            }
            expressions = this.tokenizeMediaQuery(mediaQuery);
            numExpressions = expressions.length;
            if(expressions[0] == "all" || expressions[0] == this.type)
            {
               if(numExpressions == 1 && !notFlag)
               {
                  this.mx_internal::goodQueries[expression] = true;
                  return true;
               }
               if(numExpressions == 2)
               {
                  return false;
               }
               expressions.shift();
               expressions.shift();
               result = this.evalExpressions(expressions);
               if(result && !notFlag || !result && notFlag)
               {
                  this.mx_internal::goodQueries[expression] = true;
                  return true;
               }
            }
            else if(notFlag)
            {
               this.mx_internal::goodQueries[expression] = true;
               return true;
            }
         }
         this.mx_internal::badQueries[expression] = true;
         return false;
      }
      
      private function tokenizeMediaQuery(mediaQuery:String) : Array
      {
         var c:String = null;
         var tokens:Array = [];
         var pos:int = mediaQuery.indexOf("(");
         if(pos == 0)
         {
            tokens.push("all");
            tokens.push("and");
         }
         else if(pos == -1)
         {
            return [mediaQuery];
         }
         var parenLevel:int = 0;
         var inComment:Boolean = false;
         var n:int = mediaQuery.length;
         var expression:Array = [];
         for(var i:int = 0; i < n; i++)
         {
            c = mediaQuery.charAt(i);
            if(!(StringUtil.isWhitespace(c) && expression.length == 0))
            {
               if(c == "/" && i < n - 1 && mediaQuery.charAt(i + 1) == "*")
               {
                  inComment = true;
                  i++;
               }
               else if(inComment)
               {
                  if(c == "*" && i < n - 1 && mediaQuery.charAt(i + 1) == "/")
                  {
                     inComment = false;
                     i++;
                  }
               }
               else
               {
                  if(c == "(")
                  {
                     parenLevel++;
                  }
                  else if(c == ")")
                  {
                     parenLevel--;
                  }
                  else
                  {
                     expression.push(c);
                  }
                  if(parenLevel == 0 && (StringUtil.isWhitespace(c) || c == ")"))
                  {
                     if(c != ")")
                     {
                        --expression.length;
                     }
                     tokens.push(expression.join(""));
                     expression.length = 0;
                  }
               }
            }
         }
         return tokens;
      }
      
      private function evalExpressions(expressions:Array) : Boolean
      {
         var expr:String = null;
         var parts:Array = null;
         var min:Boolean = false;
         var max:Boolean = false;
         var n:int = expressions.length;
         for(var i:int = 0; i < n; i++)
         {
            expr = expressions[i];
            if(expr != "and")
            {
               parts = expr.split(":");
               min = false;
               max = false;
               if(parts[0].indexOf("min-") == 0)
               {
                  min = true;
                  parts[0] = parts[0].substr(4);
               }
               else if(parts[0].indexOf("max-") == 0)
               {
                  max = true;
                  parts[0] = parts[0].substr(4);
               }
               if(parts[0].indexOf("-") > 0)
               {
                  parts[0] = this.deHyphenate(parts[0]);
               }
               if(parts.length == 1)
               {
                  if(!(parts[0] in this))
                  {
                     return false;
                  }
               }
               if(parts.length == 2)
               {
                  if(!(parts[0] in this))
                  {
                     return false;
                  }
                  if(min)
                  {
                     if(this[parts[0]] < this.normalize(parts[1],typeof this[parts[0]]))
                     {
                        return false;
                     }
                  }
                  else if(max)
                  {
                     if(this[parts[0]] > this.normalize(parts[1],typeof this[parts[0]]))
                     {
                        return false;
                     }
                  }
                  else if(this[parts[0]] != this.normalize(parts[1],typeof this[parts[0]]))
                  {
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      private function normalize(s:String, type:String) : Object
      {
         var index:int = 0;
         if(s.charAt(0) == " ")
         {
            s = s.substr(1);
         }
         if(type == "number")
         {
            index = s.indexOf("dpi");
            if(index != -1)
            {
               s = s.substr(0,index);
            }
            return Number(s);
         }
         if(type == "int")
         {
            return int(s);
         }
         if(type == "string")
         {
            if(s.indexOf("\"") == 0)
            {
               if(s.lastIndexOf("\"") == s.length - 1)
               {
                  s = s.substr(1,s.length - 2);
               }
               else
               {
                  s = s.substr(1);
               }
            }
         }
         return s;
      }
      
      private function deHyphenate(s:String) : String
      {
         var part:String = null;
         var c:String = null;
         var i:int = s.indexOf("-");
         while(i > 0)
         {
            part = s.substr(i + 1);
            s = s.substr(0,i);
            c = part.charAt(0);
            c = c.toUpperCase();
            s += c + part.substr(1);
            i = s.indexOf("-");
         }
         return s;
      }
      
      private function getPlatform() : String
      {
         var s:String = Capabilities.version.substr(0,3);
         if(platformMap.hasOwnProperty(s))
         {
            return platformMap[s] as String;
         }
         return s.toLowerCase();
      }
   }
}
