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