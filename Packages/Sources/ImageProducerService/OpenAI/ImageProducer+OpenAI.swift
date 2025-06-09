//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-27.
//

import OpenAI
import Foundation

public extension ImageProducer {

    fileprivate static let openAIClient = OpenAI(apiToken: "")

    static let openAI = Self(
        generateImage: { input in
            let query = ImagesQuery(
                prompt: input,
                model: .gpt4_1_mini,
                n: 1,
                quality: .hd,
                responseFormat: .b64_json,
                size: ._512,
                style: .natural,
                user: nil
            )

            let result = try await openAIClient.images(query: query)

            guard
                let b64json = result.data.first?.b64Json,
                let data = Data(base64Encoded: b64json)
            else {
                throw ImageProducerError.unableToGenerateImage
            }

            return data
        }
    )

}
