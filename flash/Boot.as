package flash
{
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.*;
   import flash.filters.*;
   import flash.text.*;
   import flash.utils.*;
   
   public dynamic class Boot extends MovieClip
   {
      public static var tf:TextField;
      
      public static var lines:Array;
      
      public static var lastError:Error;
      
      public static var skip_constructor:Boolean;
      
      public function Boot()
      {
         super();
         if(Boot.skip_constructor)
         {
            return;
         }
      }
      
      public static function enum_to_string(param1:Object) : String
      {
         var _loc3_:* = undefined;
         if(param1.params == null)
         {
            return param1.tag;
         }
         var _loc2_:Array = [];
         for each(_loc3_ in param1.params)
         {
            _loc2_.push(Boot.__string_rec(_loc3_,""));
         }
         return param1.tag + "(" + _loc2_.join(",") + ")";
      }
      
      public static function __instanceof(param1:*, param2:*) : Boolean
      {
         try
         {
            if(param2 == Dynamic)
            {
               return true;
            }
            return param1 is param2;
         }
         catch(e:*)
         {
            return false;
         }
      }
      
      public static function __clear_trace() : void
      {
         if(Boot.tf == null)
         {
            return;
         }
         Boot.tf.parent.removeChild(Boot.tf);
         Boot.tf = null;
         Boot.lines = null;
      }
      
      public static function __set_trace_color(param1:uint) : void
      {
         var _loc2_:TextField = Boot.getTrace();
         _loc2_.textColor = param1;
         _loc2_.filters = [];
      }
      
      public static function getTrace() : TextField
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TextFormat = null;
         var _loc1_:MovieClip = Lib.current;
         if(Boot.tf == null)
         {
            Boot.tf = new TextField();
            _loc2_ = 16777215;
            _loc3_ = 0;
            if(_loc1_.stage != null)
            {
               _loc3_ = uint(_loc1_.stage.color);
               _loc2_ = uint(16777215 - _loc3_);
            }
            Boot.tf.textColor = _loc2_;
            Boot.tf.filters = [new GlowFilter(_loc3_,1,2,2,20)];
            _loc4_ = Boot.tf.getTextFormat();
            _loc4_.font = "_sans";
            Boot.tf.defaultTextFormat = _loc4_;
            Boot.tf.selectable = false;
            Boot.tf.mouseEnabled = false;
            Boot.tf.autoSize = TextFieldAutoSize.LEFT;
            Boot.tf.width = !!_loc1_.stage ? _loc1_.stage.stageWidth : 800;
         }
         if(_loc1_.stage == null)
         {
            _loc1_.addChild(Boot.tf);
         }
         else
         {
            _loc1_.stage.addChild(Boot.tf);
         }
         return Boot.tf;
      }
      
      public static function __trace(param1:*, param2:Object) : void
      {
         var _loc3_:TextField = Boot.getTrace();
         var _loc4_:String = param2 == null ? "(null)" : param2.fileName + ":" + int(param2.lineNumber);
         if(Boot.lines == null)
         {
            Boot.lines = [];
         }
         Boot.lines = Boot.lines.concat((_loc4_ + ": " + Boot.__string_rec(param1,"")).split("\n"));
         _loc3_.text = Boot.lines.join("\n");
         var _loc5_:Stage = Lib.current.stage;
         if(!_loc5_)
         {
            return;
         }
         while(Boot.lines.length > 1 && _loc3_.height > _loc5_.stageHeight)
         {
            Boot.lines.shift();
            _loc3_.text = Boot.lines.join("\n");
         }
      }
      
      public static function __string_rec(param1:*, param2:String) : String
      {
         var keys:Array = null;
         var k:String = null;
         var s:String = null;
         var first:Boolean = false;
         var arr:Array = null;
         var indent:String = param2;
         var cls:String = getQualifiedClassName(param1);
         if(cls == "Object")
         {
            keys = [];
            for(k in param1)
            {
               keys.push(k);
            }
            s = "{";
            first = true;
            for each(k in keys)
            {
               if(k == "toString")
               {
                  try
                  {
                     return param1.toString();
                  }
                  catch(e:*)
                  {
                  }
               }
               if(!first)
               {
                  s += ",";
               }
               first = false;
               s += " " + k + " : " + __string_rec(param1[k],indent);
            }
            if(!first)
            {
               s += " ";
            }
            return s + "}";
         }
         if(cls == "Array")
         {
            if(param1 === Array)
            {
               return "#Array";
            }
            arr = param1;
            return "[" + arr.map(function(param1:*, ... rest):String
            {
               return __string_rec(param1,indent);
            }).join(",") + "]";
         }
         if(typeof param1 == "function")
         {
            return "<function>";
         }
         return String(param1);
      }
      
      public static function __unprotect__(param1:String) : String
      {
         return param1;
      }
      
      public function start() : void
      {
         var root:MovieClip = null;
         root = Lib.current;
         try
         {
            if(root == this && root.stage && root.stage.align == "")
            {
               root.stage.align = "TOP_LEFT";
            }
         }
         catch(e:*)
         {
            if(!root.stage)
            {
               root.addEventListener(Event.ADDED_TO_STAGE,doInitDelay);
            }
            else if(root.stage.stageWidth == 0 || root.stage.stageHeight == 0)
            {
               setTimeout(start,1);
            }
            else
            {
               init();
            }
         }
      }
      
      public function init() : void
      {
         Boot.lastError = new Error();
         throw "assert";
      }
      
      public function doInitDelay(param1:*) : void
      {
         Lib.current.removeEventListener(Event.ADDED_TO_STAGE,this.doInitDelay);
         this.start();
      }
   }
}

