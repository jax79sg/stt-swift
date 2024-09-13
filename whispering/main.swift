//
//  main.swift
//  whispering
//
//  Created by jax on 10/9/24.
//

import Foundation
import WhisperKit

func transcribeme(filename: String) async -> String {
   let pipe = try? await WhisperKit(model: "large-v2_949MB")
   print("Model loaded, transcribing " + filename)
    do {
         let result = try await pipe!.transcribe(audioPath:filename)?.text ?? "NIL"
        return result
    }
    catch
    {
        print("Transribe of " + filename + " failed")
        print("Unexpected error: \(error).")
    }
    return "NIL"
}

func getFilenamesInFolder(atPath: String) -> [String] {
    let fileManager = FileManager.default
    do {
        let filenames = try fileManager.contentsOfDirectory(atPath: atPath)
        return filenames
    } catch {
        print("Error reading directory: \(error)")
        return []
    }
}



// Usage example

let runtranscibe = Task
{
    let folderPath = "/Users/jax/Documents/TOTRANSCRIBE"
    let transcribeFolder="TOTRANSCRIBE"
    let fileNames = getFilenamesInFolder(atPath: folderPath)
    for filename in fileNames {
        let fullpath = URL.init(string: folderPath+"/"+filename)
        let fullpathtxt = URL.init(string: folderPath+"/"+filename+".txt")
        let fullpathstring=(fullpath?.absoluteString ??  "NIL")
        let fullpathtxtstring=(fullpathtxt?.absoluteString ??  "NIL")
        print("Processing " + fullpathstring)
//        let transcript = await transcribeme(filename: fullpathstring)
        let transcript="NOTON"
        print("Transcript of " + fullpathstring + " ready.\n Saving it now \n" + transcript)
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent("TOTRANSCRIBE/"+filename+".txt")
            do {
                try transcript.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("write of " + fullpathstring + " failed")
                print("Unexpected error: \(error).")
            }
        }
        
        
    }
}

//print(await transcribeme.value)
//
//let filename = getDocumentsDirectory().appendingPathComponent("output.txt")
//
//do {
//    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
//} catch {
//    // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
//}


await runtranscibe.value
