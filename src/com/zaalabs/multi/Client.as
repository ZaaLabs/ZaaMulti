package com.zaalabs.multi
{
    import flash.net.Socket;
 
    public class Client
    {
		[Bindable]
        public var name:String;
        public var socket:Socket;
        
        public function Client(name:String, socket:Socket)
        {
            this.name = name;
            this.socket = socket;
        }
    }
}