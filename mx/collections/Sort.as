package mx.collections
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mx.collections.errors.SortError;
   import mx.core.mx_internal;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.utils.ObjectUtil;
   
   public class Sort extends EventDispatcher implements ISort
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
      
      public static const ANY_INDEX_MODE:String = "any";
      
      public static const FIRST_INDEX_MODE:String = "first";
      
      public static const LAST_INDEX_MODE:String = "last";
       
      
      private var resourceManager:IResourceManager;
      
      private var _compareFunction:Function;
      
      private var usingCustomCompareFunction:Boolean;
      
      private var _fields:Array;
      
      private var fieldList:Array;
      
      private var _unique:Boolean;
      
      private var defaultEmptyField:ISortField;
      
      private var noFieldsDescending:Boolean = false;
      
      public function Sort()
      {
         this.resourceManager = ResourceManager.getInstance();
         this.fieldList = [];
         super();
      }
      
      public function get compareFunction() : Function
      {
         return this.usingCustomCompareFunction ? this._compareFunction : this.internalCompare;
      }
      
      public function set compareFunction(value:Function) : void
      {
         this._compareFunction = value;
         this.usingCustomCompareFunction = this._compareFunction != null;
      }
      
      [Bindable("fieldsChanged")]
      public function get fields() : Array
      {
         return this._fields;
      }
      
      public function set fields(value:Array) : void
      {
         var field:ISortField = null;
         var i:int = 0;
         this._fields = value;
         this.fieldList = [];
         if(Boolean(this._fields))
         {
            for(i = 0; i < this._fields.length; i++)
            {
               field = ISortField(this._fields[i]);
               this.fieldList.push(field.name);
            }
         }
         dispatchEvent(new Event("fieldsChanged"));
      }
      
      public function get unique() : Boolean
      {
         return this._unique;
      }
      
      public function set unique(value:Boolean) : void
      {
         this._unique = value;
      }
      
      override public function toString() : String
      {
         return ObjectUtil.toString(this);
      }
      
      public function findItem(items:Array, values:Object, mode:String, returnInsertionIndex:Boolean = false, compareFunction:Function = null) : int
      {
         var found:Boolean;
         var objFound:Boolean;
         var lowerBound:int;
         var upperBound:int;
         var obj:Object;
         var direction:int;
         var compareForFind:Function = null;
         var fieldsForCompare:Array = null;
         var message:String = null;
         var index:int = 0;
         var fieldName:String = null;
         var hadPreviousFieldName:Boolean = false;
         var i:int = 0;
         var hasFieldName:Boolean = false;
         var objIndex:int = 0;
         var match:Boolean = false;
         var prevCompare:int = 0;
         var nextCompare:int = 0;
         if(!items)
         {
            message = this.resourceManager.getString("collections","noItems");
            throw new SortError(message);
         }
         if(items.length == 0)
         {
            return returnInsertionIndex ? 1 : -1;
         }
         if(compareFunction == null)
         {
            compareForFind = this.compareFunction;
            if(Boolean(values) && this.fieldList.length > 0)
            {
               fieldsForCompare = [];
               hadPreviousFieldName = true;
               i = 0;
               while(true)
               {
                  if(i < this.fieldList.length)
                  {
                     fieldName = this.fieldList[i];
                     if(Boolean(fieldName))
                     {
                        try
                        {
                           hasFieldName = values[fieldName] !== undefined;
                        }
                        catch(e:Error)
                        {
                           hasFieldName = false;
                        }
                        if(hasFieldName)
                        {
                           if(!hadPreviousFieldName)
                           {
                              break;
                           }
                           fieldsForCompare.push(fieldName);
                        }
                        else
                        {
                           hadPreviousFieldName = false;
                        }
                     }
                     else
                     {
                        fieldsForCompare.push(null);
                     }
                     continue;
                  }
                  if(fieldsForCompare.length == 0)
                  {
                     message = this.resourceManager.getString("collections","findRestriction");
                     throw new SortError(message);
                  }
                  try
                  {
                     this.initSortFields(items[0]);
                  }
                  catch(initSortError:SortError)
                  {
                  }
               }
               message = this.resourceManager.getString("collections","findCondition",[fieldName]);
               throw new SortError(message);
            }
         }
         else
         {
            compareForFind = compareFunction;
         }
         found = false;
         objFound = false;
         index = 0;
         lowerBound = 0;
         upperBound = items.length - 1;
         obj = null;
         direction = 1;
         while(!objFound && lowerBound <= upperBound)
         {
            index = Math.round((lowerBound + upperBound) / 2);
            obj = items[index];
            direction = Boolean(fieldsForCompare) ? compareForFind(values,obj,fieldsForCompare) : compareForFind(values,obj);
            switch(direction)
            {
               case -1:
                  upperBound = index - 1;
                  break;
               case 0:
                  objFound = true;
                  switch(mode)
                  {
                     case ANY_INDEX_MODE:
                        found = true;
                        break;
                     case FIRST_INDEX_MODE:
                        found = index == lowerBound;
                        objIndex = index - 1;
                        match = true;
                        while(match && !found && objIndex >= lowerBound)
                        {
                           obj = items[objIndex];
                           prevCompare = Boolean(fieldsForCompare) ? compareForFind(values,obj,fieldsForCompare) : compareForFind(values,obj);
                           match = prevCompare == 0;
                           if(!match || match && objIndex == lowerBound)
                           {
                              found = true;
                              index = objIndex + (match ? 0 : 1);
                           }
                           objIndex--;
                        }
                        break;
                     case LAST_INDEX_MODE:
                        found = index == upperBound;
                        objIndex = index + 1;
                        match = true;
                        while(match && !found && objIndex <= upperBound)
                        {
                           obj = items[objIndex];
                           nextCompare = Boolean(fieldsForCompare) ? compareForFind(values,obj,fieldsForCompare) : compareForFind(values,obj);
                           match = nextCompare == 0;
                           if(!match || match && objIndex == upperBound)
                           {
                              found = true;
                              index = objIndex - (match ? 0 : 1);
                           }
                           objIndex++;
                        }
                        break;
                     default:
                        message = this.resourceManager.getString("collections","unknownMode");
                        throw new SortError(message);
                  }
                  break;
               case 1:
                  lowerBound = index + 1;
                  break;
            }
         }
         if(!found && !returnInsertionIndex)
         {
            return -1;
         }
         return direction > 0 ? index + 1 : index;
      }
      
      public function propertyAffectsSort(property:String) : Boolean
      {
         var field:ISortField = null;
         if(this.usingCustomCompareFunction || !this.fields)
         {
            return true;
         }
         for(var i:int = 0; i < this.fields.length; i++)
         {
            field = this.fields[i];
            if(field.name == property || field.usingCustomCompareFunction)
            {
               return true;
            }
         }
         return false;
      }
      
      public function reverse() : void
      {
         var i:int = 0;
         if(Boolean(this.fields))
         {
            for(i = 0; i < this.fields.length; i++)
            {
               ISortField(this.fields[i]).reverse();
            }
         }
         this.noFieldsDescending = !this.noFieldsDescending;
      }
      
      public function sort(items:Array) : void
      {
         var fixedCompareFunction:Function = null;
         var message:String = null;
         var uniqueRet1:Object = null;
         var fields:Array = null;
         var i:int = 0;
         var sortArgs:Object = null;
         var uniqueRet2:Object = null;
         if(!items || items.length <= 1)
         {
            return;
         }
         if(this.usingCustomCompareFunction)
         {
            fixedCompareFunction = function(a:Object, b:Object):int
            {
               return compareFunction(a,b,_fields);
            };
            if(this.unique)
            {
               uniqueRet1 = items.sort(fixedCompareFunction,Array.UNIQUESORT);
               if(uniqueRet1 == 0)
               {
                  message = this.resourceManager.getString("collections","nonUnique");
                  throw new SortError(message);
               }
            }
            else
            {
               items.sort(fixedCompareFunction);
            }
         }
         else
         {
            fields = this.fields;
            if(Boolean(fields) && fields.length > 0)
            {
               sortArgs = this.initSortFields(items[0],true);
               if(this.unique)
               {
                  if(Boolean(sortArgs) && fields.length == 1)
                  {
                     uniqueRet2 = items.sortOn(sortArgs.fields[0],Number(sortArgs.options[0]) | Array.UNIQUESORT);
                  }
                  else
                  {
                     uniqueRet2 = items.sort(this.internalCompare,Array.UNIQUESORT);
                  }
                  if(uniqueRet2 == 0)
                  {
                     message = this.resourceManager.getString("collections","nonUnique");
                     throw new SortError(message);
                  }
               }
               else if(Boolean(sortArgs))
               {
                  items.sortOn(sortArgs.fields,sortArgs.options);
               }
               else
               {
                  items.sort(this.internalCompare);
               }
            }
            else
            {
               items.sort(this.internalCompare);
            }
         }
      }
      
      private function initSortFields(item:Object, buildArraySortArgs:Boolean = false) : Object
      {
         var i:int = 0;
         var field:ISortField = null;
         var options:int = 0;
         var arraySortArgs:Object = null;
         for(i = 0; i < this.fields.length; i++)
         {
            ISortField(this.fields[i]).initializeDefaultCompareFunction(item);
         }
         if(buildArraySortArgs)
         {
            arraySortArgs = {
               "fields":[],
               "options":[]
            };
            for(i = 0; i < this.fields.length; i++)
            {
               field = this.fields[i];
               options = field.arraySortOnOptions;
               if(options == -1)
               {
                  return null;
               }
               arraySortArgs.fields.push(field.name);
               arraySortArgs.options.push(options);
            }
         }
         return arraySortArgs;
      }
      
      private function internalCompare(a:Object, b:Object, fields:Array = null) : int
      {
         var i:int = 0;
         var len:int = 0;
         var sf:ISortField = null;
         var result:int = 0;
         if(!this._fields)
         {
            result = this.noFieldsCompare(a,b);
         }
         else
         {
            i = 0;
            len = Boolean(fields) ? fields.length : this._fields.length;
            while(result == 0 && i < len)
            {
               sf = ISortField(this._fields[i]);
               result = sf.compareFunction(a,b);
               if(sf.descending)
               {
                  result *= -1;
               }
               i++;
            }
         }
         return result;
      }
      
      private function noFieldsCompare(a:Object, b:Object, fields:Array = null) : int
      {
         var result:int;
         var message:String = null;
         if(!this.defaultEmptyField)
         {
            this.defaultEmptyField = new SortField();
            try
            {
               this.defaultEmptyField.initializeDefaultCompareFunction(a);
            }
            catch(e:SortError)
            {
               message = resourceManager.getString("collections","noComparator",[a]);
               throw new SortError(message);
            }
         }
         result = this.defaultEmptyField.compareFunction(a,b);
         if(this.noFieldsDescending)
         {
            result *= -1;
         }
         return result;
      }
   }
}
