package tuxwars.states.tutorial
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.net.CRMService;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.utils.TuxUiUtils;
   
   public class TuxTutorialSubState extends TuxState
   {
      
      private static const BUBBLE_EXPORT:String = "tutorial_bubble";
      
      private static const READY_BUTTON:String = "Button_Ready";
      
      public static const ARROW_TOP:String = "top";
      
      public static const ARROW_BOTTOM:String = "bottom";
      
      public static const ARROW_RIGHT:String = "right";
      
      public static const ARROW_LEFT:String = "left";
       
      
      private const textField:UIAutoTextField = new UIAutoTextField();
      
      private var movieClip:MovieClip;
      
      private var button:UIButton;
      
      private var tid:String;
      
      private var showButton:Boolean;
      
      private var finishTutorial:Boolean;
      
      private var tutorialArrow:MovieClip;
      
      public function TuxTutorialSubState(game:TuxWarsGame, tid:String, showButton:Boolean = false, finishTutorial:Boolean = false)
      {
         super(game);
         this.tid = tid;
         this.showButton = showButton;
         this.finishTutorial = finishTutorial;
      }
      
      override public function enter() : void
      {
         super.enter();
         movieClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_bubble");
         textField.setTextField(movieClip.Text);
         textField.setText(ProjectManager.getText(tid));
         button = TuxUiUtils.createButton(UIButton,movieClip,"Button_Ready",buttonPressed,"TUTORIAL_BUTTON_TEXT");
         button.setVisible(showButton);
         var _loc1_:DCGame = DCGame;
         movieClip.x = com.dchoc.game.DCGame._stage.stageWidth;
         var _loc2_:DCGame = DCGame;
         movieClip.y = com.dchoc.game.DCGame._stage.stageHeight;
         movieClip.visible = tid != null;
         movieClip.mouseChildren = false;
         movieClip.mouseEnabled = false;
         DCGame.getMainMovieClip().addChild(movieClip);
         closeTutorial();
      }
      
      override public function exit() : void
      {
         removeTutorialArrow();
         removeMovieClip();
         super.exit();
      }
      
      private function closeTutorial() : void
      {
         if(finishTutorial)
         {
            CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","EndOfTutorial","Close Tutorial Pop Up");
            Tutorial.setTutorial(false);
            Tutorial.saveTutorialStep("TutorialEnd");
            MessageCenter.sendMessage("TutorialEnd");
         }
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         DCUtils.bringToFront(movieClip.parent,movieClip);
      }
      
      protected function setText(text:String) : void
      {
         textField.setText(text);
         movieClip.visible = text != null;
      }
      
      protected function addTutorialArrow(arrow:String, parent:DisplayObjectContainer) : void
      {
         tutorialArrow = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_arrow_" + arrow);
         tutorialArrow.mouseEnabled = false;
         DCUtils.setBitmapSmoothing(true,tutorialArrow);
         parent.addChild(tutorialArrow);
      }
      
      protected function addTutorialArrowAt(arrow:String, location:Point) : void
      {
         tutorialArrow = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_arrow_" + arrow);
         tutorialArrow.mouseEnabled = false;
         DCUtils.setBitmapSmoothing(true,tutorialArrow);
         tutorialArrow.x = location.x;
         tutorialArrow.y = location.y;
         DCGame.getMainMovieClip().addChild(tutorialArrow);
      }
      
      protected function removeTutorialArrow() : void
      {
         if(tutorialArrow)
         {
            if(tutorialArrow.parent && tutorialArrow.parent.contains(tutorialArrow))
            {
               tutorialArrow.parent.removeChild(tutorialArrow);
            }
            tutorialArrow = null;
         }
      }
      
      private function buttonPressed(event:MouseEvent) : void
      {
         tuxGame.changeState(new HomeState(tuxGame));
      }
      
      private function removeMovieClip() : void
      {
         if(movieClip)
         {
            DCGame.getMainMovieClip().removeChild(movieClip);
            button.dispose();
            button = null;
            movieClip = null;
         }
      }
   }
}
