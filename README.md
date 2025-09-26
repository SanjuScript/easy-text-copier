# 📋 Easy Text Copier  

> Extract. Copy. Reuse. – A modern Flutter app for instant text recognition and clipboard management.  

---

## 🚀 Overview  
**Easy Text Copier** is a sleek, lightweight Flutter application that lets you **extract text from images** and **copy it instantly**.  
Whether it's a screenshot, photo, or document, you can grab the text you need and reuse it anywhere.  

No more typing manually — just **share an image to the app**, select or copy all text, and keep a **history** of everything you’ve copied.  

---

## ✨ Features  

- 📸 **Share images/screenshots** directly into the app  
- 🔠 **Extract text (OCR)** using on-device Google ML Kit (Latin script supported)  
- 📋 **Copy all text** at once or select specific text manually  
- 🕘 **Copied text history** – revisit and recopy whenever needed  
- 🧹 **Delete history entries** when you no longer need them  
- ⚡ **Fast, offline, and secure** – works without internet  
- 🎨 **Clean premium UI** with gradient design  

---

## 📱 Screenshots  

| Home Screen | OCR Result | Copy History |
|-------------|------------|--------------|
| ![Home](assets/screenshots/home.png) | ![Result](assets/screenshots/result.png) | ![History](assets/screenshots/history.png) |

---

## 🛠️ Tech Stack  

- **Framework:** [Flutter](https://flutter.dev)  
- **State Management:** Provider  
- **OCR Engine:** [Google ML Kit - Text Recognition](https://pub.dev/packages/google_mlkit_text_recognition)  
- **Clipboard Management:** Custom service layer  

---

## 📦 Installation  

Clone the repo and run the app locally:  

```bash
git clone https://github.com/yourusername/easy-text-copier.git
cd easy-text-copier
flutter pub get
flutter run
