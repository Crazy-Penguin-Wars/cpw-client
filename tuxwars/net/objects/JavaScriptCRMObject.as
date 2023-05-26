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
      
      public function JavaScriptCRMObject(method:String, to:Array, filters:Array, toPlatform:String, forcedRequest:Boolean = false)
      {
         super(method,to,filters,toPlatform,forcedRequest);
      }
      
      override public function toString() : String
      {
         return super.toString() + ",\ngroup: " + group + ",\ncrm_event_type :" + crm_event_type + ",\ntype: " + type + ",\nproduct: " + product + ",\nproduct_detail: " + product_detail + ",\norder_info: " + order_info + ",\naction: " + action + ",\nref_p_id: " + ref_p_id + ",\nref_p_uid: " + ref_p_uid + ",\nref_app_id: " + ref_app_id + ",\nref_app_uid: " + ref_app_uid + ",\nplatform_req_type_id: " + platform_req_type_id;
      }
      
      public function get group() : String
      {
         return _group;
      }
      
      public function set group(value:String) : void
      {
         _group = value;
      }
      
      public function get crm_event_type() : String
      {
         return _crm_event_type;
      }
      
      public function set crm_event_type(value:String) : void
      {
         _crm_event_type = value;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      public function get exclude_ids() : String
      {
         return _exclude_ids;
      }
      
      public function set exclude_ids(value:String) : void
      {
         _exclude_ids = value;
      }
      
      public function get product() : String
      {
         return _product;
      }
      
      public function set product(value:String) : void
      {
         _product = value;
      }
      
      public function get product_detail() : String
      {
         return _product_detail;
      }
      
      public function set product_detail(value:String) : void
      {
         _product_detail = value;
      }
      
      public function get order_info() : Object
      {
         return _order_info;
      }
      
      public function set order_info(value:Object) : void
      {
         _order_info = value;
      }
      
      public function get action() : String
      {
         return _action;
      }
      
      public function set action(value:String) : void
      {
         _action = value;
      }
      
      public function get ref_p_id() : String
      {
         return _ref_p_id;
      }
      
      public function set ref_p_id(value:String) : void
      {
         _ref_p_id = value;
      }
      
      public function get ref_p_uid() : String
      {
         return _ref_p_uid;
      }
      
      public function set ref_p_uid(value:String) : void
      {
         _ref_p_uid = value;
      }
      
      public function get ref_app_id() : String
      {
         return _ref_app_id;
      }
      
      public function set ref_app_id(value:String) : void
      {
         _ref_app_id = value;
      }
      
      public function get ref_app_uid() : String
      {
         return _ref_app_uid;
      }
      
      public function set ref_app_uid(value:String) : void
      {
         _ref_app_uid = value;
      }
      
      public function get platform_req_type_id() : String
      {
         return _platform_req_type_id;
      }
      
      public function set platform_req_type_id(value:String) : void
      {
         _platform_req_type_id = value;
      }
   }
}
