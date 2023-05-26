package tuxwars.home.ui.logic.help
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.help.HelpScreen;
   import tuxwars.states.TuxState;
   
   public class HelpLogic extends TuxUILogic
   {
       
      
      private const _helpPages:Array = [];
      
      private var _currentPageIndex:int;
      
      private var loader:URLResourceLoader;
      
      public function HelpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
         var aria:Array = [];
         var _loc6_:ProjectManager = ProjectManager;
         var _loc7_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("HelpData");
         for each(var row in _loc7_._rows)
         {
            aria.push(new HelpReference(row));
         }
         aria.sort(sortByPriority);
         for each(var hr in aria)
         {
            _helpPages.push(hr.id);
            _helpPages.push(hr);
         }
      }
      
      private function get helpScreen() : HelpScreen
      {
         return screen;
      }
      
      public function getHelpPage(ID:String) : HelpReference
      {
         _currentPageIndex = _helpPages.indexOf(ID);
         checkCurrentPage();
         return _helpPages[_helpPages.indexOf(ID) + 1];
      }
      
      public function setHelpPage(setPage:int) : void
      {
         _currentPageIndex = setPage;
         checkCurrentPage();
      }
      
      public function get nextPage() : HelpReference
      {
         if(_helpPages.length > _currentPageIndex + 2)
         {
            return getHelpPage(_helpPages[_currentPageIndex + 2]);
         }
         return getHelpPage(_helpPages[_currentPageIndex]);
      }
      
      public function get prevPage() : HelpReference
      {
         if(0 <= _currentPageIndex - 2)
         {
            return getHelpPage(_helpPages[_currentPageIndex - 2]);
         }
         return getHelpPage(_helpPages[_currentPageIndex]);
      }
      
      public function checkCurrentPage() : void
      {
         if(0 == _currentPageIndex)
         {
            helpScreen.disableLeftButton();
         }
         else
         {
            helpScreen.enableLeftButton();
         }
         if(_helpPages.length <= _currentPageIndex + 2)
         {
            helpScreen.disableRightButton();
         }
         else
         {
            helpScreen.enableRightButton();
         }
         loader = ResourceLoaderURL.getInstance().load(helpScreen);
      }
      
      private function sortByPriority(a:HelpReference, b:HelpReference) : int
      {
         if(a.sortOrder == b.sortOrder)
         {
            return 0;
         }
         if(a.sortOrder < b.sortOrder)
         {
            return -1;
         }
         return 1;
      }
      
      public function get pictureURL() : String
      {
         return (_helpPages[_currentPageIndex + 1] as HelpReference).picture;
      }
   }
}
