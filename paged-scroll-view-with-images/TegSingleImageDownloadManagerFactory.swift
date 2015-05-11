//
// Creates an instance of TegSingleImageDownloadManager.
// The only purpose of this class is make code that download images testable.
// In tests a subclass of this class is used to create a fake image downloader.
//

public class TegSingleImageDownloadManagerFactory {
  public init() { }

  public func create() -> TegSingleImageDownloadManager {
    return TegSingleImageDownloadManager()
  }
}