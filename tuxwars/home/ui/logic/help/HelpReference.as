package tuxwars.home.ui.logic.help
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   
   public class HelpReference
   {
      public static const TABLE:String = "HelpData";
      
      private static const TITLE:String = "Title";
      
      private static const PICTURE:String = "Picture";
      
      private static const DESCRIPTION:String = "Description";
      
      private static const SORT_ORDER:String = "SortOrder";
      
      private var _row:Row;
      
      public function HelpReference(param1:Row)
      {
         super();
         assert("HelpReference is null",true,param1 != null);
         this._row = param1;
      }
      
      public function get id() : String
      {
         return this._row.id;
      }
      
      public function get title() : String
      {
         if(!this._row)
         {
            return null;
         }
         if(!this._row.getCache[TITLE])
         {
            this._row.getCache[TITLE] = DCUtils.find(this._row.getFields(),"name",TITLE);
         }
         var _loc1_:Field = this._row.getCache[TITLE];
         return !!_loc1_ ? ProjectManager.getText(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : null;
      }
      
      public function get picture() : String
      {
         if(!this._row)
         {
            return null;
         }
         if(!this._row.getCache[PICTURE])
         {
            this._row.getCache[PICTURE] = DCUtils.find(this._row.getFields(),"name",PICTURE);
         }
         var _loc1_:Field = this._row.getCache[PICTURE];
         return !!_loc1_ ? Config.getDataDir() + (_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : null;
      }
      
      public function get description() : String
      {
         if(!this._row)
         {
            return null;
         }
         if(!this._row.getCache[DESCRIPTION])
         {
            this._row.getCache[DESCRIPTION] = DCUtils.find(this._row.getFields(),"name",DESCRIPTION);
         }
         var _loc1_:Field = this._row.getCache[DESCRIPTION];
         return !!_loc1_ ? ProjectManager.getText(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : null;
      }
      
      public function get sortOrder() : int
      {
         if(!this._row)
         {
            return 0;
         }
         if(!this._row.getCache[SORT_ORDER])
         {
            this._row.getCache[SORT_ORDER] = DCUtils.find(this._row.getFields(),"name",SORT_ORDER);
         }
         var _loc1_:Field = this._row.getCache[SORT_ORDER];
         return !!_loc1_ ? (_loc1_.overrideValue != null ? _loc1_.overrideValue : int(_loc1_._value)) : 0;
      }
   }
}

