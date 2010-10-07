package com.zaalabs.multi
{
    public class Message
    {
        public var type:String;
        public var data:Object;
        
        public function Message(type:String="", data:Object=null)
        {
            this.type = type;
            this.data = data;
        }
        
        public function toString():String
        {
            return "["+type+"] "+data;
        }
    }
}