import Foundation

protocol IImageStoreManager {
    func save(_ image: ImageModel)
    func fetchAll() -> [ImageModel]
    func getAmount() -> Int
    func delete(_ image: ImageModel)
    func clearAll()
}

class ImageStoreManager: IImageStoreManager {
    
    private let key = "savedImageModels"
    private let defaults = UserDefaults.standard
    
    // MARK: - Public methods
    func save(_ image: ImageModel) {
        guard let _ = image.image else {
            print("imageModel with no image, save haven't been completed")
            return
        }
        var items = fetchAll()
        
        items.append(image)
        persist(items)
    }
    
    func fetchAll() -> [ImageModel] {
        guard let data = defaults.data(forKey: key) else { return [ImageModel()] }
        
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .base64
        
        do {
            let decoded = try decoder.decode([ImageModel].self, from: data)
            return decoded
        } catch {
            print("❌ Decode error:", error)
            return []
        }
    }
    
    func getAmount() -> Int {
        fetchAll().count
    }
    
    func delete(_ image: ImageModel) {
        var items = fetchAll()
        if let index = items.firstIndex(of: image) {
            items.remove(at: index)
            persist(items)
        }
    }
    
    func clearAll() {
        defaults.removeObject(forKey: key)
    }
    
    // MARK: - Private methods
    private func persist(_ items: [ImageModel]) {
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .base64
        
        do {
            let data = try encoder.encode(items)
            
            // debug print JSON для проверки
            if let jsonString = String(data: data, encoding: .utf8) {
                print("✅ Persisted JSON:", jsonString)
            }
            
            defaults.set(data, forKey: key)
        } catch {
            print("❌ Encode error:", error)
        }
    }
}
