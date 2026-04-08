package tuxwars.battle.gameobjects.player
{
   import com.dchoc.avatar.*;
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.geom.ColorTransform;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.*;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.data.*;
   
   public class AvatarGameObject extends PhysicsGameObject
   {
      private static const IDLE_CHANCE:int = 70;
      
      private static const IDLE_SOUND_CHANCE:int = 60;
      
      private const _container:Sprite = new Sprite();
      
      private var _avatar:TuxAvatar;
      
      private var _idleMode:Boolean;
      
      private var _playIdleAnim:Boolean;
      
      public function AvatarGameObject(param1:AvatarGameObjectDef, param2:TuxWarsGame)
      {
         super(param1,param2);
         allowGraphicsFlipping = true;
         allowDisplayObjectRotation = false;
         this._container.mouseChildren = false;
         this._container.mouseEnabled = false;
         this._avatar = new TuxAvatar(param1.animationAssets,this);
         this._container.addChild(this._avatar);
         direction = this._displayObject.x <= DCGame.getStage().stageWidth * 0.5 ? 1 : 0;
         this.idleMode = true;
         this._playIdleAnim = true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._avatar.dispose();
         this._avatar = null;
      }
      
      public function get container() : Sprite
      {
         return this._container;
      }
      
      public function get avatar() : TuxAvatar
      {
         return this._avatar;
      }
      
      public function get idleMode() : Boolean
      {
         return this._idleMode;
      }
      
      public function set idleMode(param1:Boolean) : void
      {
         if(this._idleMode != param1)
         {
            LogUtils.log(this._id + " changing idle mode to: " + param1,this,1,"Player",false,false,false);
            this._idleMode = param1;
            this.idleCallback();
         }
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(this._avatar)
         {
            this._avatar.logicUpdate(param1);
         }
      }
      
      override public function applyColorTransform(param1:ColorTransform) : void
      {
         if(this._avatar)
         {
            this._avatar.transform.colorTransform = param1;
         }
      }
      
      public function changeAnimation(param1:String, param2:Boolean = true, param3:Function = null) : Boolean
      {
         return this.avatar.animate(new AvatarAnimation(param1,param2,param3));
      }
      
      public function isIdleAnimation(param1:AvatarAnimation) : Boolean
      {
         if(param1.classDefinitionName == "idle")
         {
            return true;
         }
         if(TuxAvatar.IDLE_ANIMS.indexOf(param1.classDefinitionName) != -1)
         {
            return true;
         }
         return false;
      }
      
      override protected function updateGraphics() : void
      {
         if(body)
         {
            this.container.x = bodyLocation.x;
            this.container.y = bodyLocation.y;
         }
      }
      
      override protected function switchDirection() : void
      {
         if(direction == 1)
         {
            this._avatar.faceRight();
         }
         else
         {
            this._avatar.faceLeft();
         }
      }
      
      private function getIdleAnimation() : String
      {
         var _loc1_:SoundReference = null;
         var _loc2_:int = int(MathUtils.randomNumber(0,100));
         var _loc3_:int = int(MathUtils.randomNumber(0,100));
         if(_loc2_ < 70)
         {
            return "idle";
         }
         if(_loc3_ < 60)
         {
            _loc1_ = Sounds.getSoundReference("PenguinSounds");
            if(_loc1_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            }
         }
         return TuxAvatar.IDLE_ANIMS[MathUtils.randomNumber(0,TuxAvatar.IDLE_ANIMS.length - 1)];
      }
      
      private function idleCallback() : void
      {
         if(this._idleMode)
         {
            this.changeAnimation(this.getIdleAnimation(),false,this.idleCallback);
            if(!this._playIdleAnim)
            {
               this.avatar.stopAnimation();
            }
         }
      }
      
      public function noMoreIdleAnim() : void
      {
         this._playIdleAnim = false;
      }
   }
}

