package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.home.ui.logic.dailynews.AddData;
   import tuxwars.net.CRMService;
   
   public class AddSlot implements IResourceLoaderURL
   {
      
      private static const DEFAULT_IMAGE_URL:String = Config.getDataDir() + "flash/ui/png/daily_news/default.png";
       
      
      private const header:UIAutoTextField = new UIAutoTextField();
      
      private const text:UIAutoTextField = new UIAutoTextField();
      
      private var leftButton:UIButton;
      
      private var rightButton:UIButton;
      
      private var addDatas:Vector.<AddData>;
      
      private var currentAddIndex:int;
      
      private var design:MovieClip;
      
      private var loader:URLResourceLoader;
      
      public function AddSlot(design:MovieClip, addDatas:Vector.<AddData>)
      {
         super();
         this.design = design;
         this.addDatas = addDatas;
         header.setTextField(design.Text_Banner_Header);
         text.setTextField(design.Text_Message);
         showAdd();
      }
      
      public function dispose() : void
      {
         UIButton;
         UIButton;
         Vector.<AddData>;
         design = null;
         URLResourceLoader;
      }
      
      public function getResourceUrl() : String
      {
         if(addDatas.length > 0)
         {
            return !!addDatas[currentAddIndex].pictureURL ? addDatas[currentAddIndex].pictureURL : DEFAULT_IMAGE_URL;
         }
         return DEFAULT_IMAGE_URL;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return imageContainer;
      }
      
      private function showAdd() : void
      {
         var _loc1_:* = null;
         if(addDatas.length > 0)
         {
            _loc1_ = addDatas[currentAddIndex];
            header.setText(_loc1_.header);
            text.setText(_loc1_.text);
         }
         else
         {
            header.setText(ProjectManager.getText("DAILY_NEWS_DEFAULT_HEADER"));
            text.setText(ProjectManager.getText("DAILY_NEWS_DEFAULT_TEXT"));
         }
         loader = ResourceLoaderURL.getInstance().load(this);
      }
      
      private function leftPressed(event:MouseEvent) : void
      {
         currentAddIndex--;
         if(currentAddIndex < 0)
         {
            currentAddIndex = addDatas.length - 1;
         }
         showAdd();
         CRMService.sendEvent("Game","Cpw_news","Clicked","ScrollLeft");
      }
      
      private function rightPressed(event:MouseEvent) : void
      {
         currentAddIndex++;
         if(currentAddIndex > addDatas.length - 1)
         {
            currentAddIndex = 0;
         }
         showAdd();
         CRMService.sendEvent("Game","Cpw_news","Clicked","ScrollRight");
      }
      
      private function get imageContainer() : MovieClip
      {
         return design.getChildByName("Container_Image") as MovieClip;
      }
   }
}
