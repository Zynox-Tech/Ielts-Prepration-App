# Implementation

This chapter discusses implementation details supported by descriptions of algorithms, external APIs, and user interfaces.

## Algorithm

This section outlines the algorithms used in the project to achieve its main features: IELTS Writing Scoring and IELTS Speaking Analysis.

### IELTS Writing Scoring Algorithm

The writing scoring feature uses an on-device Machine Learning model (ONNX) to evaluate essays. The process involves tokenization, inference, and score mapping.

**Natural Language Explanation:**
1.  **Initialization**: The app loads the vocabulary file (`vocab.txt`) and the quantized ONNX model (`model_quantized.onnx`) from assets.
2.  **Input Processing**: The user's essay text is captured.
3.  **Tokenization**:
    *   The text is converted to lowercase.
    *   It is split into words based on whitespace.
    *   Each word is mapped to a corresponding integer ID from the loaded vocabulary.
    *   Special tokens are added: `<s>` (Start) at the beginning and `</s>` (End) at the end.
    *   The sequence is padded with `<pad>` tokens to a fixed length of 512 integers.
4.  **Inference**:
    *   The tokenized sequence (`input_ids`) and an attention mask (indicating valid tokens) are fed into the ONNX Runtime session.
    *   The model predicts raw scores for different criteria.
5.  **Scoring**:
    *   The raw model outputs are processed.
    *   Scores are rounded to the nearest 0.5 to match IELTS Band standards (e.g., 6.0, 6.5, 7.0).
    *   The final result displays scores for Task Response, Coherence & Cohesion, Lexical Resource, Grammatical Range, and Overall Band.

### IELTS Speaking Analysis Algorithm

The speaking analysis feature leverages the Gemini 1.5 Flash multimodal model to analyze audio recordings directly.

**Pseudocode / Logic Flow:**
```text
FUNCTION AnalyzeSpeaking(audioPath, topic):
    IF audioPath does not exist THEN
        RETURN Error("File not found")
    END IF

    audioBytes = ReadFileAsBytes(audioPath)
    
    prompt = "You are an IELTS Speaking examiner. Analyze the audio for topic: " + topic + 
             ". Return JSON with transcript, band score (0-9), fluency, pronunciation, " +
             "grammar, vocabulary scores, feedback, corrected text, and grammar errors."

    model = InitializeGeminiModel("gemini-1.5-flash", API_KEY)
    
    response = model.GenerateContent([Text(prompt), Audio(audioBytes)])
    
    jsonResult = ParseJSON(response.text)
    
    IF jsonResult is Valid THEN
        SaveResultToFirestore(jsonResult)
        DisplayResults(jsonResult)
    ELSE
        RETURN Error("Failed to parse response")
    END IF
END FUNCTION
```

## External APIs

Describe the APIs used in the table 5.1.

Table 5.1 shows that the project relies on several key external services for AI capabilities, backend services, and device features.

**Table 5.1: Details of APIs used in the project**

| Name of API | Description of API | Purpose of usage | Function/Class Name |
| :--- | :--- | :--- | :--- |
| **Google Generative AI (Gemini)** | A multimodal AI model by Google capable of processing text and audio. | Used to transcribe and analyze speaking test audio for Band scores, feedback, and grammar corrections. | `SpeakingScreen._analyzeAudioWithGemini` |
| **Firebase Auth** | A backend service for secure user authentication. | Handles user sign-up, login, and session management. | `AuthController`, `LoginScreen` |
| **Cloud Firestore** | A NoSQL cloud database. | Stores user profiles, speaking test results, and historical data. | `SpeakingScreen._saveResult`, `ProfileScreen` |
| **Flutter ONNX Runtime** | A plugin for running ONNX models locally on the device. | Executes the offline AI model for scoring IELTS writing essays. | `WritingModelTestController._loadModel`, `predict` |
| **Flutter TTS** | A text-to-speech plugin. | Converts text feedback and transcripts into spoken audio for the user. | `ResultsScreen._speak` |
| **Speech to Text** | A library for converting speech to text. | Used for real-time transcription or voice commands (if applicable). | `SpeakingScreen` (via Gemini for final analysis) |

## User Interface

Details about user interface with descriptions.

### Speaking Screen
The **Speaking Screen** is the core interface for the speaking test.
*   **Topic Selection**: Users can select from a list of IELTS topics (e.g., "Describe a memorable holiday").
*   **Recording Interface**: Features a prominent, animated recording button that pulses during recording. It displays a live timer to track duration.
*   **Feedback**: After recording, the screen transitions to a loading state while analyzing, then navigates to the Results Screen.

### Writing Screen
The **Writing Screen** allows users to practice for the writing test.
*   **Essay Input**: A large text area for typing the essay response to a given prompt.
*   **Analysis Control**: A "Predict" or "Analyze" button triggers the on-device ONNX model.
*   **Result Display**: Shows a breakdown of the estimated Band score across four criteria: Task Response, Coherence, Vocabulary, and Grammar.

### Results Screen (Speaking)
The **Results Screen** displays the detailed analysis returned by the AI.
*   **Score Card**: A visually distinct card showing the Overall Band Score (0-9.0).
*   **Metrics Grid**: Displays individual scores for Fluency, Pronunciation, Grammar, and Vocabulary.
*   **Expandable Sections**:
    *   **Transcript**: Shows the exact text of what the user said.
    *   **Corrected Version**: Displays an improved version of the transcript.
*   **Feedback & Errors**: Provides qualitative feedback and a list of specific grammar errors with corrections.
*   **Text-to-Speech**: Floating action button to listen to the feedback or corrected text.
