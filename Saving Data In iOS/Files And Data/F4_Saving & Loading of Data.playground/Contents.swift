import Foundation
let favouriteBytes : [UInt8] = [
    240,            159,            152,            184,
    0b1111_0000,    0b1001_1111,    0b1001_1000,    186,
    0xF0,           0x9F,           0x98,           187
]

//Saving the data to documents directory of this playground
//Create an instance of Data

var favouriteBytesData = Data(favouriteBytes)
//we need to know where this Data gets stored, so create a URL

var favouritesByteURL = URL(fileURLWithPath:"Favourite Bytes", relativeTo: FileManager.documentDirectoryUrl)

//Data had a "writes" method that takes a url


//favouriteBytesData.write(to : favouritesByteURL) here the .write() will throw an error if it doesnot succeed. So you need a try before hand
try favouriteBytesData.write(to : favouritesByteURL)
//this adds a file inside the document directory with the name "Favourite Bytes"

//Now inorder to read the contents of that url Data has an initializer for that.
//You will store the data as " Saved favourite bytes data"

//Data(contentsOf: favouritesByteURL) will throw an error if there is no content to read from that url so we need to add try.
//And also the error could happen if the url represnts a directory instead of a file.

let savedFavouriteBytesData = try Data(contentsOf: favouritesByteURL) //Output = 12 bytes
//similar to the previous chapters MemoryLayout.size() for favouriteBytes

//To get your numbers back , you can use an array initialiser which accepts a data instance.
let savedFavouriteBytes = Array(savedFavouriteBytesData)
//o/p = [240, 159, 152, 184, 240, 159, 152, 186, 240, 159, 152, 187]

//let swift verify that the saved favourite bytes is equal to the original favorite bytes declared above

savedFavouriteBytes == favouriteBytes // o/p = true

//you can treat data as an array of bytes so you can equate them directly
favouriteBytesData == savedFavouriteBytesData // o/p = true



//*********************************


//MARK : CHAPTER 7 STRINGS

//what exactly is stored in the favouriteBytes ? time to write their data agin but this time with a file extension

try favouriteBytesData.write(to: favouritesByteURL.appendingPathExtension("txt"))
//click on the favouriteBytesUrl to open in finder to see that the Favorite bytes.txt file can open but contains 3 cat emojis, using 12 bytes of data
//the txt file extension lets the finder know that the file you wrote just represents a string , the same data without an extension will not open in finder because finder doesnot know what to show to you.

//lets read back the saved cats in swift
// you can tell swift that you are working with a string, by using a string initialiser and a string encoding
let string = String(data : savedFavouriteBytesData, encoding : .utf8)!
// O/p : "😸😺😻"
// The mystery bytes represnt the happy cat string using the utf8 encoding
//Also the String() initialiser is failable, but as we know it will work, we can force unwrap it.

//Now the favourite data makes sense, each one of the 3 rows, makes 1 cat face, so every cat face requires 4 bytes of data. So as the total bytes consumed are 12, there are 3 cat faces.
//But how did the playground know that these 4 particular elements combined will result in cat face ? That's where the unicode standard comes to play.
//Unicode = Universal Coded Character Set is a standard that specifies the representation of texts.
//utf = Unicode Transformation Format is a set of standards for encoding a unicode character set into bits of data.
//utf8 = Unicode Transformation Format 8 bit is one of the encodings available. It is a variable in encoing that can be used to represent all charcters in the unicode character set.
//utf8 can use 1 -> 4  8bit bytes or 1 -> 4 Octates.
//There are other utfs to use like utf16 and utf32
/*
 utf8 is more reliable as
 1. it's backward compatible with ascii character set and
 2. it uses fewer bytes of data when storing things in memory or to a file
 3. you don't need to specify the byte order when using utf8

 */


//What happens when you save a string with it's write method ?

//make a url to write the string file into
var catsURL = URL(fileURLWithPath: "Cats.txt", relativeTo: FileManager.documentDirectoryUrl)

/*O/p :
 Cats.txt -- file:///Users/pritamdash/Library/Developer/XCPGDevices/FD034AD8-FA09-4BAB-9A5F-CDA144EBCA5E/data/Containers/Data/Application/15F56A01-4F77-4740-9908-6012D11AD82B/Documents/
*/
//atomically allows you to write to a url while avoiding potential file correuption
try string.write(to: catsURL, atomically: true, encoding: .utf8)
// output : you get to see the cats.txt file in the doument directory of the playground and you see the cat emojies saved in it.
// Now to read this :
let catsChallengeString = try String(contentsOf : catsURL)
//O/p : "😸😺😻"
