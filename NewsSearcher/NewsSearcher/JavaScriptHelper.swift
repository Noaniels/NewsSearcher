//
//  JavaScriptHelper.swift
//  NewsSearcher
//
//  Created by Shohei Michiwaki on 2014/11/02.
//  Copyright (c) 2014年 Shohei Michiwaki. All rights reserved.
//

import Foundation
import JavaScriptCore


public class JavaScriptHelper : NSObject{
    
    public override init() {
    }
    
    func Sample()
    {
        let ctx = JSContext()
        let ary = [0, 1, 2, 3]
        var jsv = ctx.evaluateScript(
            "\(ary).map(function(n){return n*n})"
        )
        println(jsv)
        var a = jsv.toArray()
        println(a)
    }
}

