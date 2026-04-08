package tuxwars.items.data
{
   import com.dchoc.data.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class CoinData extends ItemData
   {
      public function CoinData()
      {
         var _loc3_:Row = null;
         var _loc1_:String = "BasicNuke";
         var _loc2_:Table = ProjectManager.getProjectData().findTable("Item");
         if(!_loc2_.getCache[_loc1_])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",_loc1_);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + _loc1_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[_loc1_] = _loc3_;
         }
         super(_loc2_.getCache[_loc1_]);
      }
      
      override public function get type() : String
      {
         return "Trophy";
      }
      
      override public function get name() : String
      {
         return ProjectManager.getText("COINS_TITLE");
      }
      
      override public function get description() : String
      {
         return ProjectManager.getText("COINS_DESCRIPTION");
      }
      
      override public function get iconRef() : GraphicsReference
      {
         var _loc3_:Row = null;
         var _loc1_:String = "Cash";
         var _loc2_:Table = ProjectManager.getProjectData().findTable("BattleRewardIconDefault");
         if(!_loc2_.getCache[_loc1_])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",_loc1_);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + _loc1_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[_loc1_] = _loc3_;
         }
         return new GraphicsReference(_loc2_.getCache[_loc1_]);
      }
      
      override public function get graphics() : GraphicsReference
      {
         return this.iconRef;
      }
   }
}

