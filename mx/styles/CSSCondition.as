package mx.styles
{
   public class CSSCondition
   {
       
      
      private var _kind:String;
      
      private var _value:String;
      
      public function CSSCondition(kind:String, value:String)
      {
         super();
         this._kind = kind;
         this._value = value;
      }
      
      public function get kind() : String
      {
         return this._kind;
      }
      
      public function get specificity() : int
      {
         if(this.kind == CSSConditionKind.ID)
         {
            return 100;
         }
         if(this.kind == CSSConditionKind.CLASS)
         {
            return 10;
         }
         if(this.kind == CSSConditionKind.PSEUDO)
         {
            return 10;
         }
         return 0;
      }
      
      public function get value() : String
      {
         return this._value;
      }
      
      public function matchesStyleClient(object:IAdvancedStyleClient) : Boolean
      {
         var styleNames:Array = null;
         var i:uint = 0;
         var match:Boolean = false;
         if(this.kind == CSSConditionKind.CLASS)
         {
            if(object.styleName != null && object.styleName is String)
            {
               styleNames = object.styleName.split(/\s+/);
               for(i = 0; i < styleNames.length; i++)
               {
                  if(styleNames[i] == this.value)
                  {
                     match = true;
                     break;
                  }
               }
            }
         }
         else if(this.kind == CSSConditionKind.ID)
         {
            if(object.id == this.value)
            {
               match = true;
            }
         }
         else if(this.kind == CSSConditionKind.PSEUDO)
         {
            if(object.matchesCSSState(this.value))
            {
               match = true;
            }
         }
         return match;
      }
      
      public function toString() : String
      {
         var s:String = null;
         if(this.kind == CSSConditionKind.CLASS)
         {
            s = "." + this.value;
         }
         else if(this.kind == CSSConditionKind.ID)
         {
            s = "#" + this.value;
         }
         else if(this.kind == CSSConditionKind.PSEUDO)
         {
            s = ":" + this.value;
         }
         else
         {
            s = "";
         }
         return s;
      }
   }
}
