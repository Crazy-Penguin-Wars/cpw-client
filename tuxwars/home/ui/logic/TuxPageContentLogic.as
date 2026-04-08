package tuxwars.home.ui.logic
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class TuxPageContentLogic extends TuxPageLogic
   {
      private static const PAGE_CONTENT:String = "PageContent";
      
      public function TuxPageContentLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public function get pageContent() : String
      {
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc1_:Field = null;
         if(getData())
         {
            _loc2_ = "PageContent";
            _loc3_ = getData();
            if(!_loc3_.getCache[_loc2_])
            {
               _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
            }
            _loc1_ = _loc3_.getCache[_loc2_];
            _loc4_ = _loc1_;
            return !!_loc1_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
         }
         return null;
      }
   }
}

