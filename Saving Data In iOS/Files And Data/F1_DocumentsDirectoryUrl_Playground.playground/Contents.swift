import Foundation

/*
 1st
 //Everything We need is in Foundation Framework for now.
 //Access the Default File Manager
 // The default Filemanager methods are thread safe.
 //One way to find the directory is to use the FileManager's instance method named as "URLs"
 // <#T##FileManager.SearchPathDirectory#> is the first arument and it dictates which directory you want? example = document directory / desktop directory .. etc
 // <#T##FileManager.SearchPathDomainMask#> is the 2nd argument and it asks the user domain mask and that's how you tell the filemenager that the directory belongs to the user.
 //.urls method returns an array of urls but there's only 1 document directory per iOS app, and if you want that single url then subscripting the array;s only valid index , i.e 0 will grab it for you
 
 FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
 then
 
 //.urls method is very lengthy so makes it difficult to access the document directory, as theer is so much use for it, we gotta refactor the code to make it easier so let's add a computed property documentDirectoryURL
 
 var documentDirectoryURL : URL {
 FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
 }
 then
 
 //If you want to use this shortcut across apps its better to add inside the extension of Filemanager
 
 extension FileManager{
     var documentDirectoryURL : URL {
     FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
     }
 }
 then
 
 //Since we don't need a specific instance of file manager to access this, we can make it static
 
 extension FileManager{
     static var documentDirectoryURL : URL {
     FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
     }
 }
 then
 
 //Because default is also a property of the file manager you dont need to use Filemanager in the computed Property anymore.
 //But by removing Filemanager you need to add back case(``) as default is a swift keyword

 
 extension FileManager{
     static var documentDirectoryURL : URL {
     `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
     }
 }
 then
 
 the above code got shifted to the file FileManager.swift
 then
 
 FileManager.documentDirectoryURL throws error 'documentDirectoryURL' is inaccessible due to 'internal' protection level
 so we need to make the extension public.
then
 
 //As you work with file manager and directories you need to see the contents of your directories and data. An easy way to access the document directory is to right click or option click to the file that is shown at the right side of your playground
 
 right click on the url shown at the right side of the playground
 "file:///Users/pritamdash/Library/Developer/XCPGDevices/FD034AD8-FA09-4BAB-9A5F-CDA144EBCA5E/data/Containers/Data/Application/1A3353EB-30C3-4214-9767-12695F375C1D/Documents/"
 then select "Open url"
 and then the playground's document directory opens
 */


//Now you can access the newly created property as so :
FileManager.documentDirectoryURL


//A good place for reusable code in playground is the sources folder.
//Once sources is selected you can type (option + command + n) to make a new folder.
//Then when the new folder is selected type (command + n) to make a new file.
