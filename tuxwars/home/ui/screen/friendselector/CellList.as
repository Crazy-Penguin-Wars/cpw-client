package tuxwars.home.ui.screen.friendselector
{
   public class CellList
   {
      private var mListIndex:uint = 0;
      
      private var mPanelList:Vector.<CellPanel> = new Vector.<CellPanel>();
      
      private var mDataList:Vector.<Object> = new Vector.<Object>();
      
      private var mOutputList:Vector.<Object> = new Vector.<Object>();
      
      private var init:Boolean = false;
      
      public function CellList()
      {
         super();
      }
      
      public static function checkIndex(param1:int, param2:int, param3:int, param4:Boolean = false) : int
      {
         if(param1 > param2)
         {
            if(!param4)
            {
               param1 = param2;
            }
            else
            {
               param1 = param3;
            }
         }
         else if(param1 < param3)
         {
            if(!param4)
            {
               param1 = param3;
            }
            else
            {
               param1 = param2;
            }
         }
         return param1;
      }
      
      public function set setDataList(param1:Vector.<Object>) : void
      {
         if(param1 != null)
         {
            this.mDataList = new Vector.<Object>();
            this.mOutputList = new Vector.<Object>();
            this.mDataList = param1;
            this.mOutputList = param1;
         }
      }
      
      public function get dataList() : Vector.<Object>
      {
         return this.mDataList;
      }
      
      public function set dataList(param1:Vector.<Object>) : void
      {
         this.mDataList = param1;
      }
      
      public function get panelList() : Vector.<CellPanel>
      {
         return this.mPanelList;
      }
      
      public function set listIndex(param1:uint) : void
      {
         var _loc2_:int = Math.ceil(this.mOutputList.length - this.mPanelList.length);
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         this.mListIndex = checkIndex(param1,_loc2_,0);
      }
      
      public function get listIndex() : uint
      {
         return this.mListIndex;
      }
      
      public function get currentLength() : uint
      {
         return this.mOutputList.length;
      }
      
      public function addPanel(param1:CellPanel) : void
      {
         if(param1)
         {
            this.mPanelList.push(param1);
         }
      }
      
      public function removePanel(param1:CellPanel) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < this.mPanelList.length)
            {
               if(this.mPanelList[_loc2_].id == param1.id)
               {
                  this.mPanelList.splice(_loc2_,1);
               }
               _loc2_++;
            }
         }
      }
      
      public function empty() : void
      {
         this.mDataList = new Vector.<Object>();
      }
      
      public function updateFromIndex(param1:int, param2:Vector.<Object> = null) : void
      {
         var _loc3_:CellPanel = null;
         var _loc4_:Object = null;
         this.mOutputList = new Vector.<Object>();
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         if(param2 != null && param2.length > 0)
         {
            this.mOutputList = this.mDataList.concat();
            _loc6_ = 0;
            while(_loc6_ < param2.length)
            {
               FriendsSelectorBase.removeFromList(param2[_loc6_].id,this.mOutputList);
               _loc6_++;
            }
         }
         else
         {
            this.mOutputList = this.mDataList.concat();
         }
         var _loc7_:uint = 0;
         var _loc8_:* = param1;
         var _loc9_:uint = 0;
         if(this.mListIndex != param1 || !this.init)
         {
            if(this.mOutputList != null && this.mOutputList.length < param1 + this.mPanelList.length && this.mOutputList.length > this.panelList.length)
            {
               param1--;
            }
            if(param1 > -1)
            {
               this.mListIndex = param1;
               _loc7_ = 0;
               while(_loc7_ < this.mPanelList.length)
               {
                  if(this.mPanelList.length > _loc7_ && Boolean(this.mPanelList[_loc7_]))
                  {
                     _loc3_ = this.mPanelList[_loc7_] as CellPanel;
                     if(this.mOutputList != null && this.mOutputList.length > param1)
                     {
                        _loc4_ = this.mOutputList[param1] as Object;
                        _loc3_.setData(_loc4_);
                        param1++;
                     }
                     else
                     {
                        _loc3_.setData(null);
                     }
                  }
                  _loc7_++;
               }
            }
         }
      }
      
      public function clean() : void
      {
         this.mPanelList = null;
         this.mDataList = null;
         this.mOutputList = null;
      }
   }
}

