package tuxwars.battle.gameobjects.player
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MathUtils;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   
   public class AvatarGameObject extends PhysicsGameObject
   {
      
      private static const IDLE_CHANCE:int = 70;
      
      private static const IDLE_SOUND_CHANCE:int = 60;
       
      
      private const _container:Sprite = new Sprite();
      
      private var _avatar:TuxAvatar;
      
      private var _idleMode:Boolean;
      
      private var _playIdleAnim:Boolean;
      
      public function AvatarGameObject(def:AvatarGameObjectDef, game:TuxWarsGame)
      {
         super(def,game);
         allowGraphicsFlipping = true;
         allowDisplayObjectRotation = false;
         _container.mouseChildren = false;
         _container.mouseEnabled = false;
         _avatar = new TuxAvatar(def.animationAssets,this);
         _container.addChild(_avatar);
         var _loc3_:DCGame = DCGame;
         direction = this._displayObject.x <= Number(com.dchoc.game.DCGame._stage.stageWidth) * 0.5 ? 1 : 0;
         idleMode = true;
         _playIdleAnim = true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _avatar.dispose();
         _avatar = null;
      }
      
      public function get container() : Sprite
      {
         return _container;
      }
      
      public function get avatar() : TuxAvatar
      {
         return _avatar;
      }
      
      public function get idleMode() : Boolean
      {
         return _idleMode;
      }
      
      public function set idleMode(value:Boolean) : void
      {
         if(_idleMode != value)
         {
            LogUtils.log(this._id + " changing idle mode to: " + value,this,1,"Player",false,false,false);
            _idleMode = value;
            idleCallback();
         }
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(_avatar)
         {
            _avatar.logicUpdate(deltaTime);
         }
      }
      
      override public function applyColorTransform(colorTransform:ColorTransform) : void
      {
         if(_avatar)
         {
            _avatar.transform.colorTransform = colorTransform;
         }
      }
      
      public function changeAnimation(animName:String, loop:Boolean = true, callback:Function = null) : Boolean
      {
         return avatar.animate(new AvatarAnimation(animName,loop,callback));
      }
      
      public function isIdleAnimation(anim:AvatarAnimation) : Boolean
      {
         if(anim.classDefinitionName == "idle")
         {
            return true;
         }
         if(TuxAvatar.IDLE_ANIMS.indexOf(anim.classDefinitionName) != -1)
         {
            return true;
         }
         return false;
      }
      
      override protected function updateGraphics() : void
      {
         if(body)
         {
            container.x = bodyLocation.x;
            container.y = bodyLocation.y;
         }
      }
      
      override protected function switchDirection() : void
      {
         if(direction == 1)
         {
            _avatar.faceRight();
         }
         else
         {
            _avatar.faceLeft();
         }
      }
      
      private function getIdleAnimation() : String
      {
         var _loc3_:* = null;
         var _loc2_:int = MathUtils.randomNumber(0,100);
         var _loc1_:int = MathUtils.randomNumber(0,100);
         if(_loc2_ < 70)
         {
            return "idle";
         }
         if(_loc1_ < 60)
         {
            _loc3_ = Sounds.getSoundReference("PenguinSounds");
            if(_loc3_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
            }
         }
         return TuxAvatar.IDLE_ANIMS[MathUtils.randomNumber(0,TuxAvatar.IDLE_ANIMS.length - 1)];
      }
      
      private function idleCallback() : void
      {
         if(_idleMode)
         {
            changeAnimation(getIdleAnimation(),false,idleCallback);
            if(!_playIdleAnim)
            {
               avatar.stopAnimation();
            }
         }
      }
      
      public function noMoreIdleAnim() : void
      {
         _playIdleAnim = false;
      }
   }
}
