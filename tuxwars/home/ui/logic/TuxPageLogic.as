package tuxwars.home.ui.logic
{
   import avmplus.getQualifiedClassName;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class TuxPageLogic extends TuxUILogic
   {
       
      
      private const DEFAULT_PAGE:String = "DefaultPage";
      
      private const PAGES:String = "Page";
      
      private var currentPage:Row;
      
      public function TuxPageLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
         var _loc3_:* = getData();
         §§push(§§findproperty(setCurrentPage));
         if(!_loc3_._cache["DefaultPage"])
         {
            _loc3_._cache["DefaultPage"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","DefaultPage");
         }
         var _loc4_:* = _loc3_._cache["DefaultPage"];
         §§pop().setCurrentPage(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
      }
      
      public function getData() : Row
      {
         LogUtils.log("Override data:row in " + getQualifiedClassName(this),null,3,"Assets",false,true,true);
         return null;
      }
      
      public function setCurrentPage(value:Row) : void
      {
         assert("setCurrentPage value is not a row!",true,value is Row);
         this.currentPage = value;
      }
      
      public function getCurrentPage() : Row
      {
         return currentPage;
      }
      
      public function getPages() : Array
      {
         var _loc2_:* = getData();
         if(!_loc2_._cache["Page"])
         {
            _loc2_._cache["Page"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Page");
         }
         var _loc3_:* = _loc2_._cache["Page"];
         var _loc1_:* = _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         return _loc1_ is Array ? _loc1_ : [_loc1_];
      }
   }
}
