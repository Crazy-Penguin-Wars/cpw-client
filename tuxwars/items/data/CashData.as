package tuxwars.items.data
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   
   public class CashData extends ItemData
   {
       
      
      public function CashData()
      {
         var _loc1_:* = ProjectManager.getProjectData().findTable("Item");
         §§push(this);
         if(!_loc1_._cache["BasicNuke"])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id","BasicNuke");
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "BasicNuke" + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache["BasicNuke"] = _loc3_;
         }
         §§pop().super(_loc1_._cache["BasicNuke"]);
      }
      
      override public function get type() : String
      {
         return "Trophy";
      }
      
      override public function get name() : String
      {
         return ProjectManager.getText("CASH_TITLE_DAILY");
      }
      
      override public function get description() : String
      {
         return ProjectManager.getText("CASH_DESCRIPTION_DAILY");
      }
      
      override public function get iconRef() : GraphicsReference
      {
         var _loc1_:* = ProjectManager.getProjectData().findTable("BattleRewardIconDefault");
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache["Cash"])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id","Cash");
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Cash" + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache["Cash"] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache["Cash"]);
      }
      
      override public function get graphics() : GraphicsReference
      {
         return iconRef;
      }
   }
}
