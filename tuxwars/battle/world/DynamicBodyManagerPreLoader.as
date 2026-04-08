package tuxwars.battle.world
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import flash.events.TimerEvent;
   
   public class DynamicBodyManagerPreLoader
   {
      private static var loaded:Boolean;
      
      private static const TABLE:String = "PhysicsPreLoad";
      
      private static const COLUMN:String = "Column";
      
      private static const managers:Object = {};
      
      private static const loadingFiles:Object = {};
      
      public function DynamicBodyManagerPreLoader()
      {
         super();
         throw new Error("DynamicBodyManagerPreLoader is a static class");
      }
      
      public static function dispose() : void
      {
         DCUtils.deleteProperties(managers);
         DCUtils.deleteProperties(loadingFiles);
         DynamicBodyManagerFactory.getInstance().dispose();
         loaded = false;
      }
      
      public static function preLoad() : void
      {
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:String = null;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc1_:Table = null;
         var _loc2_:Field = null;
         var _loc3_:String = null;
         var _loc4_:Table = null;
         var _loc5_:Field = null;
         var _loc6_:String = null;
         if(!loaded)
         {
            _loc7_ = "PhysicsPreLoad";
            _loc1_ = ProjectManager.findTable(_loc7_);
            if(_loc1_)
            {
               _loc8_ = _loc1_;
               for each(_loc9_ in _loc8_._rows)
               {
                  if(_loc9_)
                  {
                     _loc10_ = "Column";
                     _loc11_ = _loc9_;
                     if(!_loc11_.getCache[_loc10_])
                     {
                        _loc11_.getCache[_loc10_] = DCUtils.find(_loc11_.getFields(),"name",_loc10_);
                     }
                     _loc2_ = _loc11_.getCache[_loc10_];
                     if(_loc2_)
                     {
                        _loc12_ = _loc2_;
                        _loc3_ = _loc12_.overrideValue != null ? _loc12_.overrideValue : _loc12_._value;
                        _loc13_ = _loc9_.id;
                        _loc4_ = ProjectManager.findTable(_loc13_);
                        if(_loc4_)
                        {
                           _loc14_ = _loc4_;
                           for each(_loc15_ in _loc14_._rows)
                           {
                              if(_loc15_)
                              {
                                 _loc16_ = _loc3_;
                                 _loc17_ = _loc15_;
                                 if(!_loc17_.getCache[_loc16_])
                                 {
                                    _loc17_.getCache[_loc16_] = DCUtils.find(_loc17_.getFields(),"name",_loc16_);
                                 }
                                 _loc18_ = _loc5_;
                                 _loc5_ = _loc17_.getCache[_loc16_];
                                 _loc6_ = _loc5_ != null ? (_loc18_.overrideValue != null ? _loc18_.overrideValue : _loc18_._value) : null;
                                 if(_loc6_)
                                 {
                                    if(loadingFiles[_loc6_] == null)
                                    {
                                       loadingFiles[_loc6_] = DynamicBodyManagerFactory.getInstance().createManager(_loc6_,managerLoaded);
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
            loaded = true;
         }
      }
      
      private static function managerLoaded(param1:TimerEvent) : void
      {
         var _loc2_:DynamicBodyManager = DynamicBodyManagerFactory.getInstance().getManager(param1.type);
         managers[_loc2_.getFile()] = _loc2_;
      }
      
      public static function getBodyManager(param1:String) : DynamicBodyManager
      {
         return managers[param1];
      }
   }
}

