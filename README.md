# COLOR-MANIPULATION

A simple desktop application for practicing and demonstrating **COLOR MANIPULATION** in digital image processing. This GUI-based app allows users to load images, apply Color Inversion,Red Gain,HSV,Brightness, and preview results easily.

## 📸 GUI Screenshot

Below is a preview of the application interface:

![GUI Screenshot](GUI/GUI.png)

## ✨ Features

- User-friendly **Graphical User Interface (GUI)**.
- Load and process RGB IMAGE.
- Apply core binary image operations:
  - COLOR INVERSION
  - BRIGHTNESS
  - REDGAIN
  - HSV
- Real-time preview: original image & result displayed side-by-side.
- Great tool for students learning digital image processing concepts.

---

## 🔧 Operations Supported

| Operation | Description |
|----------|-------------|
| **COLORINVERSION**  | Inverts each pixel (binary negation) |
| **BRIGHTNESS**  | Combines two images using bitwise AND |
| **REDGAIN**   | Combines two images using bitwise OR |
| **HSV**  | Highlights differences using bitwise XOR |
---

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   https://github.com/sheiza31/COLOR-MANIPULATION.git
````

2. Open the project in **MATLAB**.
3. Run the main GUI file:
   ```
   MANIPULASI_WARNA.m
   ```
4. Use the GUI buttons to load images and apply color manipulation.

---

## 🛠️ Requirements

* MATLAB with GUI support.
---

## 📂 Project Structure

```
CITRA-APP-OPERATION-BINER/
│
├── MANIPULASI_WARNA.m                 — Main MATLAB GUI logic
├── MANIPULASI_WARNA.fig               — GUI layout file
├── GUI/         — Folder containing GUI screenshots
│     └── GUI.png
│
├── LAPORAN PRAKTIKUM OPERASI BINER.pdf
└── README.md
