//
//  ParsingManager.swift
//  AppNet
//
//  Created by Luis Perez on 12/17/15.
//  Copyright © 2015 Luis Perez. All rights reserved.
//

import UIKit

let DATA_KEY = "ISBN:"
let TITULO_KEY = "title"
let AUTORES_KEY = "authors"
let AUTOR_NOMBRE_KEY = "name"
let COVER_KEY = "cover"
let IMAGEN_KEY = "large"


protocol ParsingManagerDelegate {
    func parsingManager(parsingManager: ParsingManager, didParseBook book: Book);
}

class ParsingManager: NSObject {
    
    var delegate : ParsingManagerDelegate?
    
    func parse(isbn: String, data: NSData) {
        let book = Book()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                if let data = jsonData[DATA_KEY+isbn] as?
                    NSDictionary {
                    
                    var imagen = UIImage()
                    var autoresNombres = String()
                    
                    let titulo = data[TITULO_KEY] as! String
                    
                    let autores = data[AUTORES_KEY] as! NSArray
                    for i in 0...autores.count-1 {
                        autoresNombres += autores[i][AUTOR_NOMBRE_KEY] as! String
                        if i != autores.count-1 {
                            autoresNombres += ", "
                        }
                    }
                    
                    if let portada = data[COVER_KEY] as? NSDictionary {
                        
                        let url = NSURL(string: portada[IMAGEN_KEY] as! String)
                        let data = NSData(contentsOfURL: url!)
                        imagen = UIImage(data: data!)!
                    } else {
                        imagen = UIImage(named: "imageNotFound")!
                    }
                    
                    book.titulo = titulo
                    book.autores = autoresNombres
                    book.portada = imagen
                        
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.delegate?.parsingManager(self, didParseBook: book)
                })
                
            } catch {
                // Handle exception
            }
        });
    }
    
}
