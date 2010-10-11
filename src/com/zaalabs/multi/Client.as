/*******************************************************************************
 * ZaaMulti
 * Copyright (c) 2010 ZaaLabs, Ltd.
 * For more information see http://www.zaalabs.com
 *
 * This file is licensed under the terms of the MIT license, which is included
 * in the license.txt file at the root directory of this library.
 ******************************************************************************/
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