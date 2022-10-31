import Foundation
//The string components of a url are collectively known as it's path. By acting as a wrap around a string a URL makes it really easy to manipulate that string for what you need.
//If you want to see a URLs path you can use it's path property
//A urls path is a string which is much more informative in a playground.

//FileManager.documentDirectoryUrl.path // shows a long string on the righ side panel

//Document Directory path is always going to be long and hard to read. It's also going to be different for every playground and for every iOS app. So you don't memorize it just ask the file manager for the right path.

FileManager.documentDirectoryUrl
/*
 O/p :
 file:///Users/pritamdash/Library/Developer/XCPGDevices/FD034AD8-FA09-4BAB-9A5F-CDA144EBCA5E/data/Containers/Data/Application/DA7B7840-68CD-4712-BD17-75667BBDBFC4/Documents/
 */
// right clicking on the url will open the finder and show that the document directory of this playground is empty.
//So now lets create a file URL and see

//add a constant url path called Reminders Data URL and initialse it with the arguments label "fileURLWithPath" and "relativeTo"
//fileURLWithPath is the name of the new path
// relativeTo - can be said as the file will be put inside the "relativeTo" folder.
let remindersDataURL = URL(fileURLWithPath: "Reminders", relativeTo: FileManager.documentDirectoryUrl)
/*
 O/p :
    Reminders -- file:///Users/pritamdash/Library/Developer/XCPGDevices/FD034AD8-FA09-4BAB-9A5F-CDA144EBCA5E/data/Containers/Data/Application/DA7B7840-68CD-4712-BD17-75667BBDBFC4/Documents/
 */

//Along with the reminders data we will also be going to save a string, will be doing that at stringURL and this time you will construct it not with a url initialiser but a couple of instance methods that return a modified URLs
// appendingPathComponent allows you add a fileName to a directory

let stringURL = FileManager.documentDirectoryUrl.appendingPathComponent("String").appendingPathExtension("txt")
//This method is also available if you want to do add a new file to the document directory
/*
 O/p :
 file:///Users/pritamdash/Library/Developer/XCPGDevices/FD034AD8-FA09-4BAB-9A5F-CDA144EBCA5E/data/Containers/Data/Application/DA7B7840-68CD-4712-BD17-75667BBDBFC4/Documents/String.txt
*/

stringURL.path
//this path contains a "/String.txt" at the end as expected.

/*
CHALLENGE :
Make your own string and a url to save it to. Store the string in the challengeString constant
Use the challengeStringURL to store the url
Add the .txt file extension
*/


let challengeString : String = "Hello World"
let challengeStringUrl = URL(fileURLWithPath: challengeString, relativeTo: FileManager.documentDirectoryUrl).appendingPathExtension("txt")
print(challengeStringUrl)
/*
 O/p :
 Hello%20World.txt -- file:///Users/pritamdash/Library/Developer/XCPGDevices/FD034AD8-FA09-4BAB-9A5F-CDA144EBCA5E/data/Containers/Data/Application/DA7B7840-68CD-4712-BD17-75667BBDBFC4/Documents/
 */

print(challengeStringUrl.path)
/*
 O/p  :
 /Users/pritamdash/Library/Developer/XCPGDevices/FD034AD8-FA09-4BAB-9A5F-CDA144EBCA5E/data/Containers/Data/Application/DA7B7840-68CD-4712-BD17-75667BBDBFC4/Documents/Hello World.txt
 */

//A handy property to get the file name and extension from a URL as long as ot represents a file : lastPathComponent
print(challengeStringUrl.lastPathComponent)
// O/p : Hello World.txt
