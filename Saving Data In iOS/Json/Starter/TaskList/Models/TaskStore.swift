/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Combine
import Foundation
class TaskStore: ObservableObject {
    let tasksJsonURL = URL(fileURLWithPath: "PrioritizedTasks", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    //getting a url to the file Task.Json and storing it withing the document directory.
    
    
    // class that stores and manages my data, this is how the app will interface with my data.
    // store contains an array of prioritized tasks and a helper method to get the index in the PrioritizedTask array that matches with the priority passed to the methods as a parameter
    @Published var prioritizedTasks : [PrioritizedTasks] = []{
        didSet{
            saveJsonPrioritizedTasks()
            //be sure to have the document directory open in finder of your app and ensure that it's empty and add a new task in the app.
        }
    }
    
    init(){
        loadJsonPrioritizedTasks()
        //Now the data comes from the json(app's bundle)
    }
  
  func getIndex(for priority: Task.Priority) -> Int {
    prioritizedTasks.firstIndex { $0.priority == priority }!
  }
    private func loadJsonPrioritizedTasks() {
        //loadJsonPrioritizedTasks should be called in the intializer for task store
        //get the urls for each json file , for that we use bundles url for resource with extension method
        //Bundle is a representation of the app, it's code and resources,all the files that you pack under xcode project are collectively a part of bundle
        //main represents the current executable in this case your app.
        
        //print statement to show your bundle folder
        print(Bundle.main.bundleURL)
        /*
         o/p :
         file:///Users/pritamdash/Library/Developer/CoreSimulator/Devices/7082FBC3-7F5A-429C-BE3C-A8ED02216BF4/data/Containers/Bundle/Application/614AD0DA-5FEC-4E21-8A1A-6CB37B6C9787/TaskList.app/
         
         copy "/Users/pritamdash/Library/Developer/CoreSimulator/Devices/7082FBC3-7F5A-429C-BE3C-A8ED02216BF4/data/Containers/Bundle/Application/614AD0DA-5FEC-4E21-8A1A-6CB37B6C9787/TaskList.app/"
         then go to finder and click command + shift + g and go to the bundle folder (finder takes you 1 step before so right click on your app name and click on show package content. [That is the bundle folder, contains all the resources for your app]
         
         */
        
        // print statemenr for you users document directory url(app specific doc directory)
        print(FileManager.documentsDirectoryURL)
        /*
         o/p :
         file:///Users/pritamdash/Library/Developer/CoreSimulator/Devices/7082FBC3-7F5A-429C-BE3C-A8ED02216BF4/data/Containers/Data/Application/9A70E2FF-23D5-4842-9F18-812F89CCBA42/Documents/
         
         copy "/Users/pritamdash/Library/Developer/CoreSimulator/Devices/7082FBC3-7F5A-429C-BE3C-A8ED02216BF4/data/Containers/Data/Application/9A70E2FF-23D5-4842-9F18-812F89CCBA42/Documents/" and follow the same steps above.
         
         now this is the app's sandbox document directory(currently empty as we haven't stored anything to read back).
         The document directory is outside the app bundle in a seperate location within iOS that keeps your user data on a per app level compartmentalised.
         
         */
        
        let temporaryDirectoryURL = FileManager.default.temporaryDirectory
        print(temporaryDirectoryURL)
        
        /*
         o/p:
         file:///Users/pritamdash/Library/Developer/CoreSimulator/Devices/7082FBC3-7F5A-429C-BE3C-A8ED02216BF4/data/Containers/Data/Application/7530C82F-5CEA-47F6-A226-44E0996FF905/tmp/

         /tmp/ is a temporary directory if you want to store a temporary data, cache any file, images, etc that you don't need to ensure they are permanently persisted.
         storing the encoded tasks in the tmp folder, can cause you loss of data anytime, so the tasks, priorities and statuses need to be stored in a more parmanent data storage i.e the document directory
         
         */
//        guard let tasksJsonUrl = Bundle.main.url(forResource: "PrioritizedTasks", withExtension: "json")
//        else{ return }
        
        /*
         let prioritizedTasksJsonUrl = URL(fileURLWithPath: "PrioritizedTasks", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
         //was here earlier now moved to the top of the class so that now the url is available to use when you save the array of prioritized tasks.
         */
        
        //FileManager also provides you with a handy method : contentsOfDirectoryAtPath, to acquire a string array of the contents of a particular directory which will be perfect for knowing the files that are available in your different sandbpx directories
        print((try? FileManager.default.contentsOfDirectory(atPath: FileManager.documentsDirectoryURL.path)) ?? [])
        //contentsOfDirectory can return an error so we put try upfront, and also it returns an optional array so we provide a default value
        //O/p : ["PrioritizedTasks.json"]
        
        //after fetching the urls, you decode these json using jsonDecoder object(helps to decode json into instances of given data types, here the types are Task and PrioritizedTask.
        let decoder = JSONDecoder()
        
        //load the contents of the json files as swift data and then decode these data into your types.
        //Data(contentsOf: taskJsonUrl) can throw an error so we wrap it in do try catch block
        
        do {
            let tasksData = try Data(contentsOf: tasksJsonURL)
            prioritizedTasks = try decoder.decode([PrioritizedTasks].self, from: tasksData)
            print("*******\n",prioritizedTasks)
            /*
             o/p :
             *******
              [TaskList.TaskStore.PrioritizedTasks(priority: TaskList.Task.Priority.high, tasks: [TaskList.Task(id: F3FD192D-7C51-4E9D-BA1D-A58C586583CE, name: "Code a SwiftUI app", completed: false), TaskList.Task(id: 73E6F987-94FA-49ED-BC8D-A093BB66D78C, name: "Book an escape room", completed: false), TaskList.Task(id: 5D2F7D4A-095F-453F-8BD7-9497D1976DE5, name: "Walk the cat", completed: false), TaskList.Task(id: 6C7B5BA5-DBC6-4876-820F-977B4204855E, name: "Pick up heavy things and put them down", completed: false)]), TaskList.TaskStore.PrioritizedTasks(priority: TaskList.Task.Priority.medium, tasks: [TaskList.Task(id: 9F215E92-8220-4A19-B596-77A7941F17D2, name: "Make karaoke playlist", completed: false), TaskList.Task(id: 86DFB5DA-674F-43A8-ACB5-4CF093EB0382, name: "Present at iOS meetup group", completed: false)]), TaskList.TaskStore.PrioritizedTasks(priority: TaskList.Task.Priority.low, tasks: [TaskList.Task(id: A9E200FF-9F8F-4033-BF3C-FDBE2CF91A15, name: "Climb El Capitan", completed: false)]), TaskList.TaskStore.PrioritizedTasks(priority: TaskList.Task.Priority.no, tasks: [TaskList.Task(id: 686F73F1-965A-49D3-B6D1-7B317F0F7BD7, name: "Learn to make baklava", completed: false), TaskList.Task(id: 2F614F51-7882-4286-842E-4321800BB5D1, name: "Play disc golf in every state", completed: true), TaskList.Task(id: 9BA60D21-714A-46D2-BC83-C823AFC1F9B2, name: "100 movie reboot marathon", completed: false)])]
             
             Now we are able to load the json data from inside of the document directory into data model, this gets us half the way to loading and decoding your serialized prioritized tasks data. The other half is saving the dsta to your file and persisting that data when you make edits and across app launches.
             
             */
        }
        catch let error{
            print(error)
        }
    }
    
    private func saveJsonPrioritizedTasks(){
        //Encode your swift type to swift data then acquire your old route url for where to store your data and then save your file with the info to your device storage.
        //Encodable automatically handles writing in to your file in the correct format, so you'll be able to see how the things are stored in the document directory in a plain json file.
        //While loading and using Json Decoder , you have json encoder available to you
        //Add a json encoder at the beginning of the method
        let encoder = JSONEncoder()
        // you can tell this encoder that you want a pretty formatted Json generated not that clammed up version.
        encoder.outputFormatting = .prettyPrinted
        do {
            let tasksData = try encoder.encode(prioritizedTasks)
            //only parameter it takes is the swift object that conforms to the encodable protocol, when you added the CODABLE protocol informants to a few of your models, you adhered to encodable and decodable.
            //For the object to encode you're just getting a single task out of a prioritized task object in your aaray, as always, start small and expand from there. If writing a single task succeeds, then you can proceed to wite an arraay of prioritized tasks.
            //Encoding can throw an error so try is used.
            
            //Final step = write your encoded object in the json file
            
            try tasksData.write(to: tasksJsonURL, options: .atomic)
            //.write can throw an exception and you are asking your encoded file to be written to the data at a specified url.
            //.atomic write = fancy way of saying that data be saved to a separate file first and once that succeeds it gets exchanged for the final file, the one that is specified in url. This ensures that if some crash happens or something goes wrong, the original json file Tasks.Json doesnot get damaged or corrupted.
            
            
            //where to call this method ? - inside the didSet of the prioritized task property.
            //every time you modify your tasks , it is likely to save your changes to a file, this will make sure that all the changes mad eby the user is imideatly persisted and not lost.
            
        }
        catch let error{
            print(error)
        }
    }
}

private extension TaskStore.PrioritizedTasks {
    //extensioon of another model, the PrioritizedTasks structure to help with it's initialization
    
  init(priority: Task.Priority, names: [String]) {
    self.init(
      priority: priority,
      tasks: names.map { Task(name: $0) }
    )
  }
}
