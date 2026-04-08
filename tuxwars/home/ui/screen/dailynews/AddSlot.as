package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.home.ui.logic.dailynews.*;
   import tuxwars.net.*;
   
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
      
      public function AddSlot(param1:MovieClip, param2:Vector.<AddData>)
      {
         super();
         this.design = param1;
         this.addDatas = param2;
         this.header.setTextField(param1.Text_Banner_Header);
         this.text.setTextField(param1.Text_Message);
         this.showAdd();
      }
      
      public function dispose() : void
      {
         this.design = null;
         Vector.<AddData>;
      }
      
      public function getResourceUrl() : String
      {
         if(this.addDatas.length > 0)
         {
            return !!this.addDatas[this.currentAddIndex].pictureURL ? this.addDatas[this.currentAddIndex].pictureURL : DEFAULT_IMAGE_URL;
         }
         return DEFAULT_IMAGE_URL;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return this.imageContainer;
      }
      
      private function showAdd() : void
      {
         var _loc1_:AddData = null;
         if(this.addDatas.length > 0)
         {
            _loc1_ = this.addDatas[this.currentAddIndex];
            this.header.setText(_loc1_.header);
            this.text.setText(_loc1_.text);
         }
         else
         {
            this.header.setText(ProjectManager.getText("DAILY_NEWS_DEFAULT_HEADER"));
            this.text.setText(ProjectManager.getText("DAILY_NEWS_DEFAULT_TEXT"));
         }
         this.loader = ResourceLoaderURL.getInstance().load(this);
      }
      
      private function leftPressed(param1:MouseEvent) : void
      {
         --this.currentAddIndex;
         if(this.currentAddIndex < 0)
         {
            this.currentAddIndex = this.addDatas.length - 1;
         }
         this.showAdd();
         CRMService.sendEvent("Game","Cpw_news","Clicked","ScrollLeft");
      }
      
      private function rightPressed(param1:MouseEvent) : void
      {
         ++this.currentAddIndex;
         if(this.currentAddIndex > this.addDatas.length - 1)
         {
            this.currentAddIndex = 0;
         }
         this.showAdd();
         CRMService.sendEvent("Game","Cpw_news","Clicked","ScrollRight");
      }
      
      private function get imageContainer() : MovieClip
      {
         return this.design.getChildByName("Container_Image") as MovieClip;
      }
   }
}

