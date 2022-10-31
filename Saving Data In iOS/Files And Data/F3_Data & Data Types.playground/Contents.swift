/*
 Name Data can be a bit overloaded but in Swift you use "Foundation.Data"
 struct Data { }
 A byte array with super powers
 
 Smallest Unit od data = 1 byte (i.e 8 bits)
 BIT = Binary digIT
 
 Integers = whole numbers(signed and unsigned) i.e (+ve and -ve , +ve only)
 UInt8 structure in swift is also used to reperesnt a byte or 8 bits
 With 8 bits the range of value you get per byte is 2^8
 (0 -> 255)
 
 Floats = decimals(Single precision floating point values)
 As with Integers they do have a limit on both the positive and negative end and unlike Int you donot have multiple variants of float.
 
 
 Double = decimals with more precission
 These allow you to store much larger and smaller values with much more precission.
 Double is not exactly twice the size of the floats, it's just derives from the fact that a double precision number uses twixe the bits than a regular single precesion number
 
 
 String = stores Text
 
 Boolean = true / false
 
 */
let age : UInt8 = 32
//How can you tell how much of bytes a data type uses and what are it's max and min values ?
//Use MaymoryLayout enum inorder to find out the amount of bytes a data type uses on your specific hardware or device, it's size method lets you pass in a variable or a constant to get this.
MemoryLayout.size(ofValue: age) // O/p = 1
MemoryLayout<UInt8>.size // O/p = 1
//UInt has handy variables that let you store min and max values in them
UInt8.max // O/p = 255
UInt8.min // O/p = 0

//Case will be different when it becomes a signed integer
let height : Int8 = 72
MemoryLayout.size(ofValue: height) // O/p = 1
MemoryLayout<Int8>.size // O/p = 1
//Int has handy variables that let you store min and max values in them
Int8.max // O/p = 127
Int8.min // O/p = -128
//Still 256 values but range changes and includes +ve and -ve values

//With Int8 you also have with you Int, Int16, Int32, Int64
//With UInt8 you also have with you UInt, UInt16, UInt32, UInt64
//On 64 bits systems , the amount of bytes Int and Int64 use is the same, it's 8 bytes / 64 bits

let weight : Float = 154.8
MemoryLayout.size(ofValue: weight) // O/p = 4
//The amount of bytes a float uses = 4
//You can see the approx min and max value it can hold
Float.leastNormalMagnitude // O/p = 1.175494e-38
Float.greatestFiniteMagnitude // O/p = 3.402823e+38
//Its mentioned approx because the bigger or smaller a float number becomes the more precision you lose.
//The precision depends on what underlying format is used to represent the floating point value.
//Most computer use IEEE floating point format

let earthRadius : Double = 3958.8
MemoryLayout.size(ofValue: earthRadius) // O/p = 8
Double.leastNormalMagnitude// O/p = 2.225073858507201e-308
Double.greatestFiniteMagnitude // O/p = 1.797693134862316e+308


//MARK : BINARY AND HEXADECIMAL
// By default when you use an integer literal in Swift it is in Base 10, a decimal number so you can directly use 0 -> 255. But you can prefix your integer to change your base.
/*
 prefix =  0b ( base 2 literal)
 b is for binary which only uses 0 and 1 for digits
 with decimal it is easier to read every 3 digits but for binary it is better if it is seperated by _ every 4 digits
 A group of 4 bits is known as a nibble and often represented using a base16
 also known as hexadecimal or just hex digit.
 Every nibble in decimal is a value from 0 -> 15. inclusive.
 Past number 9 we use the 1st 6 letters of alpabets for hex literals
 prefix = 0x (hexadecimal iteral)
 */

let ageBinaryUnsigned : UInt8 = 0b0010_0000 // O/p = 32
let ageBinarySigned : Int8 = -0b0010_0000 // O/p = -32
let weightHexaDecimalUnsigned : UInt16 = 0x9B // O/p = 155
let weightHexaDecimalSigned : Int16 = -0x9B // O/p = -155

//They use the same respective sizes just the number representation changed.

let favouriteBytes : [UInt8] = [
    240,            159,            152,            184,
    0b1111_0000,    0b1001_1111,    0b1001_1000,    186,
    0xF0,           0x9F,           0x98,           187
]
//O/p : [240, 159, 152, 184, 240, 159, 152, 186, 240, 159, 152, 187]

MemoryLayout<UInt8>.size * favouriteBytes.count // O/p = 12
//So 12 elements each using 1 byte of memory.

