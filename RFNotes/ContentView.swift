//
//  ContentView.swift
//  RFNotes
//
//  Created by Vasu Rastogi on 02/02/26.
//

import SwiftUI
import AVFoundation

struct ContentView: View {

    @State private var recorder: AVAudioRecorder?
    @State private var isRecording = false

    var body: some View {
        VStack(spacing: 20) {
            Button(isRecording ? "Stop Recording" : "Start Recording") {
                isRecording ? stopRecording() : startRecording()
            }
        }
        .frame(width: 300, height: 200)
        .padding()
    }

    func startRecording() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        let timestamp = formatter.string(from: Date())
        let filename = "Recording_\(timestamp).m4a"
        
        let fileURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)

        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            recorder = try AVAudioRecorder(url: fileURL, settings: settings)
            recorder?.record()
            isRecording = true
            print("Recording started 🎙️")
        } catch {
            print("Failed to start recording:", error)
        }
    }

    func stopRecording() {
        recorder?.stop()
        recorder = nil
        isRecording = false
        print("Recording stopped 🛑")
    }
}



#Preview {
    ContentView()
}
