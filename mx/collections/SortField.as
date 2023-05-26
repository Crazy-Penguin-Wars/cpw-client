package mx.collections
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mx.collections.errors.SortError;
   import mx.core.mx_internal;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.utils.ObjectUtil;
   
   public class SortField extends EventDispatcher implements ISortField
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
       
      
      private var resourceManager:IResourceManager;
      
      private var _caseInsensitive:Boolean;
      
      private var _compareFunction:Function;
      
      private var _descending:Boolean;
      
      private var _name:String;
      
      private var _numeric:Object;
      
      private var _usingCustomCompareFunction:Boolean;
      
      public function SortField(name:String = null, caseInsensitive:Boolean = false, descending:Boolean = false, numeric:Object = null)
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         this._name = name;
         this._caseInsensitive = caseInsensitive;
         this._descending = descending;
         this._numeric = numeric;
         this._compareFunction = this.stringCompare;
      }
      
      public function get arraySortOnOptions() : int
      {
         if(this.usingCustomCompareFunction || this.name == null || this._compareFunction == this.xmlCompare || this._compareFunction == this.dateCompare)
         {
            return -1;
         }
         var options:int = 0;
         if(this.caseInsensitive)
         {
            options |= Array.CASEINSENSITIVE;
         }
         if(this.descending)
         {
            options |= Array.DESCENDING;
         }
         if(this.numeric == true || this._compareFunction == this.numericCompare)
         {
            options |= Array.NUMERIC;
         }
         return options;
      }
      
      [Bindable("caseInsensitiveChanged")]
      public function get caseInsensitive() : Boolean
      {
         return this._caseInsensitive;
      }
      
      public function set caseInsensitive(value:Boolean) : void
      {
         if(value != this._caseInsensitive)
         {
            this._caseInsensitive = value;
            dispatchEvent(new Event("caseInsensitiveChanged"));
         }
      }
      
      public function get compareFunction() : Function
      {
         return this._compareFunction;
      }
      
      public function set compareFunction(c:Function) : void
      {
         this._compareFunction = c;
         this._usingCustomCompareFunction = c != null;
      }
      
      [Bindable("descendingChanged")]
      public function get descending() : Boolean
      {
         return this._descending;
      }
      
      public function set descending(value:Boolean) : void
      {
         if(this._descending != value)
         {
            this._descending = value;
            dispatchEvent(new Event("descendingChanged"));
         }
      }
      
      [Bindable("nameChanged")]
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(n:String) : void
      {
         this._name = n;
         dispatchEvent(new Event("nameChanged"));
      }
      
      [Bindable("numericChanged")]
      public function get numeric() : Object
      {
         return this._numeric;
      }
      
      public function set numeric(value:Object) : void
      {
         if(this._numeric != value)
         {
            this._numeric = value;
            dispatchEvent(new Event("numericChanged"));
         }
      }
      
      public function get usingCustomCompareFunction() : Boolean
      {
         return this._usingCustomCompareFunction;
      }
      
      override public function toString() : String
      {
         return ObjectUtil.toString(this);
      }
      
      public function initializeDefaultCompareFunction(obj:Object) : void
      {
         var value:Object = null;
         var typ:String = null;
         var test:String = null;
         if(!this.usingCustomCompareFunction)
         {
            if(this.numeric == true)
            {
               this._compareFunction = this.numericCompare;
            }
            else if(this.caseInsensitive || this.numeric == false)
            {
               this._compareFunction = this.stringCompare;
            }
            else
            {
               if(Boolean(this._name))
               {
                  try
                  {
                     value = obj[this._name];
                  }
                  catch(error:Error)
                  {
                  }
               }
               if(value == null)
               {
                  value = obj;
               }
               typ = typeof value;
               switch(typ)
               {
                  case "string":
                     this._compareFunction = this.stringCompare;
                     break;
                  case "object":
                     if(value is Date)
                     {
                        this._compareFunction = this.dateCompare;
                     }
                     else
                     {
                        this._compareFunction = this.stringCompare;
                        try
                        {
                           test = value.toString();
                        }
                        catch(error2:Error)
                        {
                        }
                        if(!test || test == "[object Object]")
                        {
                           this._compareFunction = this.nullCompare;
                        }
                     }
                     break;
                  case "xml":
                     this._compareFunction = this.xmlCompare;
                     break;
                  case "boolean":
                  case "number":
                     this._compareFunction = this.numericCompare;
               }
            }
         }
      }
      
      public function reverse() : void
      {
         this.descending = !this.descending;
      }
      
      private function nullCompare(a:Object, b:Object) : int
      {
         var left:Object = null;
         var right:Object = null;
         var message:String = null;
         var found:Boolean = false;
         if(a == null && b == null)
         {
            return 0;
         }
         if(Boolean(this._name))
         {
            try
            {
               left = a[this._name];
            }
            catch(error:Error)
            {
            }
            try
            {
               right = b[this._name];
            }
            catch(error:Error)
            {
            }
         }
         if(left == null && right == null)
         {
            return 0;
         }
         if(left == null && !this._name)
         {
            left = a;
         }
         if(right == null && !this._name)
         {
            right = b;
         }
         var typeLeft:String = typeof left;
         var typeRight:String = typeof right;
         if(typeLeft == "string" || typeRight == "string")
         {
            found = true;
            this._compareFunction = this.stringCompare;
         }
         else if(typeLeft == "object" || typeRight == "object")
         {
            if(left is Date || right is Date)
            {
               found = true;
               this._compareFunction = this.dateCompare;
            }
         }
         else if(typeLeft == "xml" || typeRight == "xml")
         {
            found = true;
            this._compareFunction = this.xmlCompare;
         }
         else if(typeLeft == "number" || typeRight == "number" || typeLeft == "boolean" || typeRight == "boolean")
         {
            found = true;
            this._compareFunction = this.numericCompare;
         }
         if(found)
         {
            return this._compareFunction(left,right);
         }
         message = this.resourceManager.getString("collections","noComparatorSortField",[this.name]);
         throw new SortError(message);
      }
      
      private function numericCompare(a:Object, b:Object) : int
      {
         var fa:Number = NaN;
         var fb:Number = NaN;
         try
         {
            fa = this._name == null ? Number(a) : Number(a[this._name]);
         }
         catch(error:Error)
         {
         }
         try
         {
            fb = this._name == null ? Number(b) : Number(b[this._name]);
         }
         catch(error:Error)
         {
         }
         return ObjectUtil.numericCompare(fa,fb);
      }
      
      private function dateCompare(a:Object, b:Object) : int
      {
         var fa:Date = null;
         var fb:Date = null;
         try
         {
            fa = this._name == null ? a as Date : a[this._name] as Date;
         }
         catch(error:Error)
         {
         }
         try
         {
            fb = this._name == null ? b as Date : b[this._name] as Date;
         }
         catch(error:Error)
         {
         }
         return ObjectUtil.dateCompare(fa,fb);
      }
      
      private function stringCompare(a:Object, b:Object) : int
      {
         var fa:String = null;
         var fb:String = null;
         try
         {
            fa = this._name == null ? String(a) : String(a[this._name]);
         }
         catch(error:Error)
         {
         }
         try
         {
            fb = this._name == null ? String(b) : String(b[this._name]);
         }
         catch(error:Error)
         {
         }
         return ObjectUtil.stringCompare(fa,fb,this._caseInsensitive);
      }
      
      private function xmlCompare(a:Object, b:Object) : int
      {
         var sa:String = null;
         var sb:String = null;
         try
         {
            sa = this._name == null ? a.toString() : a[this._name].toString();
         }
         catch(error:Error)
         {
         }
         try
         {
            sb = this._name == null ? b.toString() : b[this._name].toString();
         }
         catch(error:Error)
         {
         }
         if(this.numeric == true)
         {
            return ObjectUtil.numericCompare(parseFloat(sa),parseFloat(sb));
         }
         return ObjectUtil.stringCompare(sa,sb,this._caseInsensitive);
      }
   }
}
