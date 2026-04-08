package tuxwars.net.objects
{
   public class JavaScriptCRMObject extends JavaScriptObject
   {
      private var _group:String;
      
      private var _crm_event_type:String;
      
      private var _type:int;
      
      private var _product:String;
      
      private var _product_detail:String;
      
      private var _order_info:Object;
      
      private var _action:String;
      
      private var _ref_p_id:String;
      
      private var _ref_p_uid:String;
      
      private var _ref_app_id:String;
      
      private var _ref_app_uid:String;
      
      private var _platform_req_type_id:String;
      
      private var _exclude_ids:String;
      
      public function JavaScriptCRMObject(param1:String, param2:Array, param3:Array, param4:String, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function toString() : String
      {
         return super.toString() + ",\ngroup: " + this.group + ",\ncrm_event_type :" + this.crm_event_type + ",\ntype: " + this.type + ",\nproduct: " + this.product + ",\nproduct_detail: " + this.product_detail + ",\norder_info: " + this.order_info + ",\naction: " + this.action + ",\nref_p_id: " + this.ref_p_id + ",\nref_p_uid: " + this.ref_p_uid + ",\nref_app_id: " + this.ref_app_id + ",\nref_app_uid: " + this.ref_app_uid + ",\nplatform_req_type_id: " + this.platform_req_type_id;
      }
      
      public function get group() : String
      {
         return this._group;
      }
      
      public function set group(param1:String) : void
      {
         this._group = param1;
      }
      
      public function get crm_event_type() : String
      {
         return this._crm_event_type;
      }
      
      public function set crm_event_type(param1:String) : void
      {
         this._crm_event_type = param1;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function set type(param1:int) : void
      {
         this._type = param1;
      }
      
      public function get exclude_ids() : String
      {
         return this._exclude_ids;
      }
      
      public function set exclude_ids(param1:String) : void
      {
         this._exclude_ids = param1;
      }
      
      public function get product() : String
      {
         return this._product;
      }
      
      public function set product(param1:String) : void
      {
         this._product = param1;
      }
      
      public function get product_detail() : String
      {
         return this._product_detail;
      }
      
      public function set product_detail(param1:String) : void
      {
         this._product_detail = param1;
      }
      
      public function get order_info() : Object
      {
         return this._order_info;
      }
      
      public function set order_info(param1:Object) : void
      {
         this._order_info = param1;
      }
      
      public function get action() : String
      {
         return this._action;
      }
      
      public function set action(param1:String) : void
      {
         this._action = param1;
      }
      
      public function get ref_p_id() : String
      {
         return this._ref_p_id;
      }
      
      public function set ref_p_id(param1:String) : void
      {
         this._ref_p_id = param1;
      }
      
      public function get ref_p_uid() : String
      {
         return this._ref_p_uid;
      }
      
      public function set ref_p_uid(param1:String) : void
      {
         this._ref_p_uid = param1;
      }
      
      public function get ref_app_id() : String
      {
         return this._ref_app_id;
      }
      
      public function set ref_app_id(param1:String) : void
      {
         this._ref_app_id = param1;
      }
      
      public function get ref_app_uid() : String
      {
         return this._ref_app_uid;
      }
      
      public function set ref_app_uid(param1:String) : void
      {
         this._ref_app_uid = param1;
      }
      
      public function get platform_req_type_id() : String
      {
         return this._platform_req_type_id;
      }
      
      public function set platform_req_type_id(param1:String) : void
      {
         this._platform_req_type_id = param1;
      }
   }
}

