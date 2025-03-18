package tuxwars.home.ui.logic
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class TuxPageContentLogic extends TuxPageLogic
   {
      private static const PAGE_CONTENT:String = "PageContent";
      
      public function TuxPageContentLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function get pageContent() : String
      {
         var _loc1_:Field = null;
         if(getData())
         {
            var _loc4_:String = "PageContent";
            var _loc2_:* = getData();
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            _loc1_ = _loc2_._cache[_loc4_];
            var _loc3_:*;
            return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
         }
         return null;
      }
   }
}

