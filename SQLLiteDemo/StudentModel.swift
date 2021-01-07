

//
//  StudentModel.swift
//  SQLLiteDemo
//
//  Created by Ashwini on 06/01/21.
//  Copyright © 2021 Ashwini. All rights reserved.
//

import Foundation

struct Student {
    var id : Int = 0
    var name : String = ""
    var dob : String = ""
    var standard : String = ""
    
    init(id:Int,name:String,dob:String,standard:String) {
        self.id = id
        self.name = name
        self.dob = dob
        self.standard = standard
    }
}
