# Delphi FMX REST Client with Async Image Loading

This project demonstrates how to build a **Delphi FMX application** that consumes a REST API, displays book information in a grid, and downloads book cover thumbnails asynchronously in the background.

The thumbnails are downloaded using `THTTPClient` in a background `TTask`, with thread-safe callbacks (`TThread.Queue`) to update the UI. A `TProgressBar` is shown during downloads to indicate progress.

---

## 📺 Credits & Inspiration

This code is **based on the excellent tutorial by Patrick Prémartin**:  
👉 [YouTube video](https://www.youtube.com/watch?v=UAO2wHyDDEg)

and the sample code available on GitHub:  
👉 [LearnToCodeSummerCamp2021 / Day-2 / 03-APIDelphiBooks](https://github.com/DeveloppeurPascal/LearnToCodeSummerCamp2021/tree/main/Day-2/03-APIDelphiBooks)

Big thanks to Patrick ([@DeveloppeurPascal](https://github.com/DeveloppeurPascal)) for sharing these resources with the Delphi community 🙌

---

## 🚀 Features

- **REST Client** using `TRESTClient`, `TRESTRequest`, and `TRESTResponse`.
- **FireDAC in-memory dataset** (`TFDMemTable`) bound to a `TGrid`.
- **Asynchronous image downloads** using `THTTPClient` inside a `TTask`.
- **Thread-safe UI updates** with `TThread.Queue`.
- **Progress bar feedback** while downloading thumbnails.
- **Decoupled design**: `TdmRest` DataModule knows nothing about the UI, it just raises events.

---

## 🛠 How it works

- `TdmRest` executes the REST request and fills `fdMemT_Books`.
- When the current record changes (`AfterScroll`), the `thumb` field URL is used to start an async download.
- The DataModule fires two events:
  - `OnThumbProgress(BytesRead, TotalBytes)` → allows the UI to show progress.
  - `OnThumbLoaded(Stream)` → provides the downloaded image stream once ready.
- In `Main.View`, these events are handled to:
  - Update a `TProgressBar` during download.
  - Load the downloaded image into an `TImage` (`ImgBook`) once complete.

---

## 📷 ScreenVideo (example)



https://github.com/user-attachments/assets/e27464bd-0b11-43f5-ae28-a75b23bd1ee4



---

## ⚙️ Requirements

- Delphi XE8 or newer (tested with Delphi 12 Athens) -> (because of [THTTPClient Categories: API Documentation XE8](https://docwiki.embarcadero.com/Libraries/Athens/en/System.Net.HttpClient.THTTPClient.OnReceiveData))  
- FMX framework (tested on Windows target)  
- Internet connection (for REST API + image URLs)

---

## 📂 Project Structure
/dm.Rest.pas // DataModule with REST logic, async download, events  
/Main.View.pas // Main form with grid, image, and progress bar  

---

## 🙌 Acknowledgements

Thanks again to **Patrick Prémartin** for the inspiration and open-source resources!  
Check out his channel and repositories for more Delphi learning content.


