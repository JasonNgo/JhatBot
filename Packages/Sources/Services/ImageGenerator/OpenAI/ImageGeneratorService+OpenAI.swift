import OpenAI
import Foundation

extension ImageGeneratorService {

    fileprivate static let openAIClient = OpenAI(apiToken: "")

    /// A concrete implementation of `ImageGeneratorService` using OpenAI's API
    public static let openAI = Self(
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
                throw ImageGeneratorServiceError.unableToGenerateImage
            }

            return data
        }
    )

}
