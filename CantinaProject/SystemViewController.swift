//
//  SystemViewController.swift
//  
//
//  Created by Michael Crotty on 6/5/18.
//
import Foundation

/* Top view of the JSON*/
struct SingleView {
    let identifier: String?
    let subviews: [Dictionary<String,Any>]?
    
    init(json: Dictionary<String, Any>) {
        identifier = json["identifier"] as? String ?? nil
        subviews = json["subviews"] as? [Dictionary<String,Any>] ?? nil
    }
    
    func toJSON() -> String? {
        var jsonString = ["identifier": self.identifier as Any, "subviews": self.subviews as Any] as [String: Any]
        if( identifier == nil ){
            jsonString.removeValue(forKey: "identifier")
        }
        if( subviews == nil ){
            jsonString.removeValue(forKey: "subviews")
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonString,
                                                                      options: .prettyPrinted)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        } catch let error {
            print("error converting to json: \(error)")
            return nil
        }
    }
}

/* Subview of the JSON*/
struct Subview {
    let viewClass: String?
    let classNames: [String]?
    let identifier: String?
    let label: Dictionary<String,Any>?
    let control: Dictionary<String,Any>?
    let contentView: Dictionary<String,Any>?
    let subviews: [Dictionary<String,Any>]?
    let title: Dictionary<String,Any>?
    
    init(json: Dictionary<String,Any>) {
        viewClass = json["class"] as? String ?? nil
        classNames = json["classNames"] as? [String] ?? nil
        identifier = json["identifier"] as? String ?? nil
        label = json["label"] as? Dictionary<String,Any> ?? nil
        control = json["control"] as? Dictionary<String,Any> ?? nil
        contentView = json["contentView"] as? Dictionary<String,Any> ?? nil
        subviews = json["subviews"] as? [Dictionary<String,Any>] ?? nil
        title = json["title"] as? Dictionary<String,Any> ?? nil
    }
    
    func toJSON() -> String? {
        var jsonString = ["class": self.viewClass as Any, "classNames": self.classNames as Any, "identifier": self.identifier as Any, "label": self.label as Any, "control": self.control as Any, "contentView": self.contentView as Any, "subviews": self.subviews as Any, "title": self.title as Any ] as [String: Any]
        if( viewClass == nil ){
            jsonString.removeValue(forKey: "class")
        }
        if( classNames == nil ){
            jsonString.removeValue(forKey: "classNames")
        }
        if( identifier == nil ){
            jsonString.removeValue(forKey: "identifier")
        }
        if( label == nil ){
            jsonString.removeValue(forKey: "label")
        }
        if( control == nil ){
            jsonString.removeValue(forKey: "control")
        }
        if( contentView == nil ){
            jsonString.removeValue(forKey: "contentView")
        }
        if( subviews == nil ){
            jsonString.removeValue(forKey: "subviews")
        }
        if( title == nil ){
            jsonString.removeValue(forKey: "title")
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonString,
                                                      options: .prettyPrinted)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        } catch let error {
            print("error converting to json: \(error)")
            return nil
        }
    }
}

/* Content view of the JSON*/
struct ContentView {
    let subviews: [Dictionary<String,Any>]?
    
    init(json: Dictionary<String,Any>) {
        subviews = json["subviews"] as? [Dictionary<String,Any>] ?? nil
    }
}

/* Control view of the JSON*/
struct ControlView {
    let viewClass: String?
    let identifier: String?
    let viewVar: String?
    let min: Float?
    let max: Int?
    let step: Int?
    let expectedStringValue: Bool?
    
    init(json: Dictionary<String,Any>) {
        viewClass = json["class"] as? String ?? nil
        identifier = json["identifier"] as? String ?? nil
        viewVar = json["var"] as? String ?? nil
        min = json["min"] as? Float ?? nil
        max = json["max"] as? Int ?? nil
        step = json["step"] as? Int ?? nil
        expectedStringValue = json["expectedStringValue"] as? Bool ?? nil
    }
    
    func toJSON() -> String? {
        var jsonString = ["class": self.viewClass as Any, "identifier": self.identifier as Any, "var": self.viewVar as Any, "min": self.min as Any, "max": self.max as Any, "step": self.step as Any, "expectedStringValue": self.expectedStringValue as Any ] as [String: Any]
        if( viewClass == nil ){
            jsonString.removeValue(forKey: "class")
        }
        if( identifier == nil ){
            jsonString.removeValue(forKey: "identifier")
        }
        if( viewVar == nil ){
            jsonString.removeValue(forKey: "var")
        }
        if( min == nil ){
            jsonString.removeValue(forKey: "min")
        }
        if( max == nil ){
            jsonString.removeValue(forKey: "max")
        }
        if( step == nil ){
            jsonString.removeValue(forKey: "step")
        }
        if( expectedStringValue == nil ){
            jsonString.removeValue(forKey: "expectedStringValue")
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonString,
                                                      options: .prettyPrinted)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        } catch let error {
            print("error converting to json: \(error)")
            return nil
        }
    }
}

/* Label view of the JSON*/
struct LabelView {
    let text: Dictionary<String,Any>?
    
    init(json: Dictionary<String,Any>) {
        text = json["text"] as? Dictionary<String,Any> ?? nil
    }
}

/* Text view of the JSON*/
struct TextView {
    let text: String?
    
    init(json: Dictionary<String,Any>) {
        text = json["text"] as? String ?? nil
    }
}

print("Enter File Name")
var file = readLine(strippingNewline: true)
if( file == "" ) {
    file = "NA"
}
let fileManager = FileManager.default
let directory = fileManager.currentDirectoryPath
var path = directory + "/" + file!

while( !fileManager.fileExists(atPath: path) ) {
    print("File does not exist. Enter File Name")
    file = readLine(strippingNewline: true)
    if( file == "" )
    {
        file = "NA"
    }
    path = directory + "/" + file!
}

var singleViewArray = [SingleView]()
var subviewArray = [Subview]()
var controlViewArray = [ControlView]()

/* Parse the JSON file into different searchable View Arrays. This will allow us
 to find the specific views to print later.*/
func ParseJSON() {
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        
        if let json = json as? Dictionary<String, Any> {
            let singleView = SingleView( json: json )
            singleViewArray.append( singleView )
            
            for s in singleView.subviews! {
                let subviews1 = Subview( json: s )
                subviewArray.append( subviews1 )
                
                for s1 in subviews1.subviews! {
                    let subviews2 = Subview( json: s1 )
                    subviewArray.append( subviews2 )
                    
                    for s2 in subviews2.subviews! {
                        let subviews3 = Subview( json: s2 )
                        subviewArray.append( subviews3 )
                        if( subviews3.subviews != nil ) {
                            
                            for s3 in subviews3.subviews! {
                                let subviews4 = Subview( json: s3 )
                                subviewArray.append( subviews4 )
                                if( subviews4.contentView != nil ) {
                                    let contentView1 = ContentView( json: subviews4.contentView! )
                                    
                                    for s4 in contentView1.subviews! {
                                        let subviews5 = Subview( json: s4 )
                                        subviewArray.append( subviews5 )
                                        let control1 = ControlView( json: subviews5.control! )
                                        controlViewArray.append( control1 )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    } catch {
        print( "Error Deserializing JSON" )
    }
}
ParseJSON()

/* Find/print the View that contains the class that is being searched for. */
func FindClass( sel: String ) {
    for s in subviewArray {
        if( s.viewClass != nil ) {
            if( s.viewClass == sel ) {
                print( s.toJSON()! )
            }
        }
    }
    for c in controlViewArray {
        if( c.viewClass != nil ) {
            if( c.viewClass == sel ) {
                print( c.toJSON()! )
            }
        }
    }
}

/* Find/print the View that contains the class name that is being searched for. */
func FindClassNames ( sel: String ) {
    for s in subviewArray {
        if( s.classNames != nil ) {
            for n in s.classNames! {
                if( n == sel ) {
                    print( s.toJSON()! )
                    break
                }
            }
        }
    }
}

/* Find/print the View that contains the identifier that is being searched for. */
func FindIdentifier( sel: String ) {
    for s in singleViewArray {
        if( s.identifier != nil ) {
            if( s.identifier == sel ) {
                print( s.toJSON()! )
            }
        }
    }
    for c in controlViewArray {
        if( c.identifier != nil ) {
            if( c.identifier == sel ) {
                print( c.toJSON()! )
            }
        }
    }
    for s in subviewArray {
        if( s.identifier != nil ) {
            
            if( s.identifier == sel ) {
                print( s.toJSON()! )
            }
        }
    }
}

print("Enter Selector or Type \"Q\" to Quit")
var selector = readLine(strippingNewline: true)
var index = selector?.startIndex

while( selector != "Q" ) {
    if( selector != "" )
    {
        //Use FindClassNames when input starts with a "."
        if( selector![index!] == "." ) {
            selector!.remove(at: (selector?.startIndex)!)
            FindClassNames( sel: selector! )
        }
            //Use FindIdentifier when input starts with a "#"
        else if( selector![index!] == "#" ){
            selector!.remove(at: (selector?.startIndex)!)
            FindIdentifier( sel: selector! )
        }
            //Use FindClass when input is normal
        else {
            FindClass( sel: selector! )
        }
    }
    
    print("Enter Selector or Type \"Q\" to Quit")
    selector = readLine(strippingNewline: true)
    index = selector?.startIndex
}

