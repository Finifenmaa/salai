//
//  TranslateAPI.swift
//  Salaì
//
//  Created by Beniamino Gentile on 04/03/24.
//

import SwiftUI
import MLKitTranslate

class TranslateAPI{
    
    let italianEnglishTranslator: Translator

    init() {
        
        // Create an Italian-English translator:
        let options = TranslatorOptions(sourceLanguage: .italian, targetLanguage: .english)
        italianEnglishTranslator = Translator.translator(options: options)
        
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )
        italianEnglishTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }
            
            // Model downloaded successfully. Okay to start translating.
            print("Model downloaded successfully. Okay to start translating.")
        }
    }
}
