//
//  DBHelper.swift
//  SQLLiteDemo
//
//  Created by Ashwini on 06/01/21.
//  Copyright © 2021 Ashwini. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper {

    init() {
        
        db = openDatabase()
        createTable()
        
    }
    
    let dbPath: String = "myDb1.sqlite"
    var db:OpaquePointer?
   func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    func createTable(){
        let createTableString = "CREATE TABLE IF NOT EXISTS student(Id INTEGER PRIMARY KEY, name TEXT, dob TEXT, standard TEXT);"
        var createTableStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("student table is created.")
            }else{
                print("studentn table could not be created.")
            }
        }else{
            print("CREATE TABLE statement could not be Prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(id:Int, name:String, dob:String, standard:String){
        let student = read()
        for s in student{
            if s.id == id{
                return
            }
        }
        
        let insertStatementString = "INSERT INTO student (Id, name, dob, standard) VALUES (NULL, ?, ?, ?);"
        var insertStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (dob as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (standard as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
        
    }
    
    func read() -> [Student] {
        
        let queryStatementString = "SELECT * FROM student;"
        var queryStatement : OpaquePointer? = nil
        var psns : [Student] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK
        {
            while sqlite3_step(queryStatement) == SQLITE_ROW{
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let dob = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let standard = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                psns.append(Student(id: Int(id), name: name, dob: dob, standard: standard))
                print("Query result :")
                print("\(id) | \(name) | \(dob) | \(standard) |")
            }
        }else{
             print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func deleteByID(id:Int) {
           let deleteStatementStirng = "DELETE FROM student WHERE Id = ?;"
           var deleteStatement: OpaquePointer? = nil
           if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
               sqlite3_bind_int(deleteStatement, 1, Int32(id))
               if sqlite3_step(deleteStatement) == SQLITE_DONE {
                   print("Successfully deleted row.")
               } else {
                   print("Could not delete row.")
               }
           } else {
               print("DELETE statement could not be prepared")
           }
           sqlite3_finalize(deleteStatement)
       }
}

