package tuxwars.states.tutorial
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.*;
   import com.dchoc.utils.*;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.homestate.*;
   import tuxwars.net.*;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.*;
   import tuxwars.utils.*;
   
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
      
      public function TuxTutorialSubState(param1:TuxWarsGame, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1);
         this.tid = param2;
         this.showButton = param3;
         this.finishTutorial = param4;
      }
      
      override public function enter() : void
      {
         super.enter();
         this.movieClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_bubble");
         this.textField.setTextField(this.movieClip.Text);
         this.textField.setText(ProjectManager.getText(this.tid));
         this.button = TuxUiUtils.createButton(UIButton,this.movieClip,"Button_Ready",this.buttonPressed,"TUTORIAL_BUTTON_TEXT");
         this.button.setVisible(this.showButton);
         this.movieClip.x = DCGame.getStage().stageWidth;
         this.movieClip.y = DCGame.getStage().stageHeight;
         this.movieClip.visible = this.tid != null;
         this.movieClip.mouseChildren = false;
         this.movieClip.mouseEnabled = false;
         DCGame.getMainMovieClip().addChild(this.movieClip);
         this.closeTutorial();
      }
      
      override public function exit() : void
      {
         this.removeTutorialArrow();
         this.removeMovieClip();
         super.exit();
      }
      
      private function closeTutorial() : void
      {
         if(this.finishTutorial)
         {
            CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","EndOfTutorial","Close Tutorial Pop Up");
            Tutorial.setTutorial(false);
            Tutorial.saveTutorialStep("TutorialEnd");
            MessageCenter.sendMessage("TutorialEnd");
         }
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         DCUtils.bringToFront(this.movieClip.parent,this.movieClip);
      }
      
      protected function setText(param1:String) : void
      {
         this.textField.setText(param1);
         this.movieClip.visible = param1 != null;
      }
      
      protected function addTutorialArrow(param1:String, param2:DisplayObjectContainer) : void
      {
         this.tutorialArrow = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_arrow_" + param1);
         this.tutorialArrow.mouseEnabled = false;
         DCUtils.setBitmapSmoothing(true,this.tutorialArrow);
         param2.addChild(this.tutorialArrow);
      }
      
      protected function addTutorialArrowAt(param1:String, param2:Point) : void
      {
         this.tutorialArrow = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_arrow_" + param1);
         this.tutorialArrow.mouseEnabled = false;
         DCUtils.setBitmapSmoothing(true,this.tutorialArrow);
         this.tutorialArrow.x = param2.x;
         this.tutorialArrow.y = param2.y;
         DCGame.getMainMovieClip().addChild(this.tutorialArrow);
      }
      
      protected function removeTutorialArrow() : void
      {
         if(this.tutorialArrow)
         {
            if(Boolean(this.tutorialArrow.parent) && Boolean(this.tutorialArrow.parent.contains(this.tutorialArrow)))
            {
               this.tutorialArrow.parent.removeChild(this.tutorialArrow);
            }
            this.tutorialArrow = null;
         }
      }
      
      private function buttonPressed(param1:MouseEvent) : void
      {
         tuxGame.changeState(new HomeState(tuxGame));
      }
      
      private function removeMovieClip() : void
      {
         if(this.movieClip)
         {
            DCGame.getMainMovieClip().removeChild(this.movieClip);
            this.button.dispose();
            this.button = null;
            this.movieClip = null;
         }
      }
   }
}

