package tuxwars.home.ui.logic.help
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.help.HelpScreen;
   import tuxwars.states.TuxState;
   
   public class HelpLogic extends TuxUILogic
   {
      private const _helpPages:Array;
      
      private var _currentPageIndex:int;
      
      private var loader:URLResourceLoader;
      
      public function HelpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         this._helpPages = [];
         super(param1,param2);
         var _loc3_:Array = [];
         var _loc4_:String = "HelpData";
         var _loc5_:* = ProjectManager.findTable(_loc4_);
         for each(_loc6_ in _loc5_._rows)
         {
            _loc3_.push(new HelpReference(_loc6_));
         }
         _loc3_.sort(this.sortByPriority);
         for each(_loc7_ in _loc3_)
         {
            this._helpPages.push(_loc7_.id);
            this._helpPages.push(_loc7_);
         }
      }
      
      private function get helpScreen() : HelpScreen
      {
         return screen;
      }
      
      public function getHelpPage(param1:String) : HelpReference
      {
         this._currentPageIndex = this._helpPages.indexOf(param1);
         this.checkCurrentPage();
         return this._helpPages[this._helpPages.indexOf(param1) + 1];
      }
      
      public function setHelpPage(param1:int) : void
      {
         this._currentPageIndex = param1;
         this.checkCurrentPage();
      }
      
      public function get nextPage() : HelpReference
      {
         if(this._helpPages.length > this._currentPageIndex + 2)
         {
            return this.getHelpPage(this._helpPages[this._currentPageIndex + 2]);
         }
         return this.getHelpPage(this._helpPages[this._currentPageIndex]);
      }
      
      public function get prevPage() : HelpReference
      {
         if(0 <= this._currentPageIndex - 2)
         {
            return this.getHelpPage(this._helpPages[this._currentPageIndex - 2]);
         }
         return this.getHelpPage(this._helpPages[this._currentPageIndex]);
      }
      
      public function checkCurrentPage() : void
      {
         if(0 == this._currentPageIndex)
         {
            this.helpScreen.disableLeftButton();
         }
         else
         {
            this.helpScreen.enableLeftButton();
         }
         if(this._helpPages.length <= this._currentPageIndex + 2)
         {
            this.helpScreen.disableRightButton();
         }
         else
         {
            this.helpScreen.enableRightButton();
         }
         this.loader = ResourceLoaderURL.getInstance().load(this.helpScreen);
      }
      
      private function sortByPriority(param1:HelpReference, param2:HelpReference) : int
      {
         if(param1.sortOrder == param2.sortOrder)
         {
            return 0;
         }
         if(param1.sortOrder < param2.sortOrder)
         {
            return -1;
         }
         return 1;
      }
      
      public function get pictureURL() : String
      {
         return (this._helpPages[this._currentPageIndex + 1] as HelpReference).picture;
      }
   }
}

