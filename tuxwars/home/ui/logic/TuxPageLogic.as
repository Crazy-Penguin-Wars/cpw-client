package tuxwars.home.ui.logic
{
   import avmplus.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class TuxPageLogic extends TuxUILogic
   {
      private const DEFAULT_PAGE:String = "DefaultPage";
      
      private const PAGES:String = "Page";
      
      private var currentPage:Row;
      
      public function TuxPageLogic(param1:TuxWarsGame, param2:TuxState)
      {
         var _loc4_:String = null;
         var _loc5_:Field = null;
         var _loc6_:Row = null;
         super(param1,param2);
         var _loc3_:Row = this.getData();
         if(_loc3_)
         {
            _loc4_ = this.DEFAULT_PAGE;
            if(!_loc3_.getCache[_loc4_])
            {
               _loc3_.getCache[_loc4_] = DCUtils.find(_loc3_.getFields(),"name",_loc4_);
            }
            _loc5_ = _loc3_.getCache[_loc4_];
            _loc6_ = !!_loc5_ ? (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) as Row : null;
            if(_loc6_)
            {
               this.setCurrentPage(_loc6_);
            }
         }
      }
      
      public function getData() : Row
      {
         LogUtils.log("Override data:row in " + getQualifiedClassName(this),null,3,"Assets",false,true,true);
         return null;
      }
      
      public function setCurrentPage(param1:Row) : void
      {
         assert("setCurrentPage value is not a row!",true,param1 is Row);
         this.currentPage = param1;
      }
      
      public function getCurrentPage() : Row
      {
         return this.currentPage;
      }
      
      public function getPages() : Array
      {
         var _loc1_:String = "Page";
         var _loc2_:* = this.getData();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         var _loc4_:* = _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         return _loc4_ is Array ? _loc4_ : [_loc4_];
      }
   }
}

