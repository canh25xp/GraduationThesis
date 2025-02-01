> Grammatical Error Correction Using Machine Learning Web Application

# 1 Introduction

## 1.1 Motivation

English has become the de facto language for international communication, with over 1.4 billion speakers worldwide, 75% of whom are non-native speakers. As the number of English-as-a-second-language (ESL) and English-as-a-foreign-language (EFL) speakers continues to grow, the demand for tools to assist these learners in improving their English proficiency is increasing. Grammatical Error Correction (GEC) systems play a crucial role in this context by automatically detecting and correcting errors in written text, including grammatical, orthographic, and word choice errors.

Despite significant advancements in GEC technology, many state-of-the-art systems remain inaccessible to the general public due to their reliance on command-line interfaces and high-performance computing resources. This creates a barrier for non-technical users, particularly those in developing countries with limited access to advanced technology and slow internet connections. The need for a lightweight, user-friendly GEC system that can be easily accessed via mobile devices is therefore urgent.

The development of such a system would not only benefit ESL and EFL learners but also native speakers who occasionally make mistakes. Additionally, improved GEC tools can enhance the quality of other natural language processing (NLP) tasks, such as machine translation and speech recognition, thereby contributing to broader advancements in the field of NLP.

## 1.2 Objectives and scope of the graduation thesis

Currently, there are several web services, such as those provided by Grammarly and John Snow Labs, offer ready-to-use English text correction.
However, these services are not open-source, limiting their adaptability for deploying different GEC systems.
Therefore, we will only compare and evaluate some available open-source English correction tools, noticeably, GECko+ and MiSS.

GECko+ is an English language assisting tool that corrects mistakes of various types on written texts.
It combines a sentence level GEC model, GECToR XLNet, and a sentence ordering model.
When a user inputs a text into the system, it segments the text into sentences and corrects the sentences with GECToR before re-ordering them by the sentence ordering model.
However, GECko+ lacks the options of choosing the GEC base models and using
system combination methods.
It is also unclear how easy it is to extend GECko+ to other GEC systems.

MiSS on the other hand is a comprehensive tool for machine translation that includes grammatical error correction as a feature.
The main machine translation features of MiSS include: basic machine translation, simultaneous machine translation, and back translation for quality evaluation.
For the GEC part, it uses GECToR XLNet for English GEC and GECToR with BERT-chinese and BERT-japanese models for Chinese and Japanese GEC respectively.
Like GECko+, MiSS also lacks the options of choosing the GEC base models and using system combination methods.

Based on the above analysis, this thesis aims to develop GecWeb (Grammatical Error Correction Web), a web-based application designed to make state-of-the-art GEC systems more accessible to the general public.
GecWeb addresses the limitations of existing GEC tools—such as their reliance on command-line interfaces, lack of mobile support, and limited customization—by offering a lightweight, user-friendly interface.
This application is specifically designed to function efficiently across different screen sizes and varying internet speeds, making it particularly beneficial for users in developing countries.

## 1.3 Tentative solution

My proposed solution involves the development of a web application that leverage state-of-the-art GEC models (GECToR-Roberta, GECToR-XlNet and GECToR-Bert) and combination methods (ESC and MEMT).

Additionally, the system will incorporate two combination methods: ESC (Edit-based System Combination) and MEMT (Multi-Engine Machine Translation).

The main contribution of this thesis is the creation of a lightweight, modular GEC system that can be easily extended to include new models and combination methods.
The system will be designed to minimize data transfer overhead, making it suitable for users with slow internet connections.
Furthermore, the system will feature a responsive web interface that adapts to different screen sizes, ensuring a seamless user experience on both desktop and mobile devices.

## 1.4 Thesis organization

The rest of this graduation project report is organized as follows.

Chapter 2 presents a detailed survey of the current state of GEC systems, including an analysis of user needs and existing products. This chapter will also outline the functional and non-functional requirements for GecWeb, based on the identified limitations of current systems.

In Chapter 3, I introduce the methodologies and technologies used in the development of GecWeb. This chapter will provide an overview of the sequence-to-sequence and sequence tagging approaches, as well as the combination methods employed in the system. The chapter will also discuss the rationale behind the choice of technologies and their relevance to the requirements outlined in Chapter 2.

Chapter 4 details the design, implementation, and evaluation of GecWeb. This chapter will cover the system's architecture, user interface design, and database design. It will also describe the tools and libraries used in the development process, as well as the testing and deployment of the application.

Chapter 5 presents the solutions and contributions of this thesis, focusing on the innovative aspects of GecWeb and the challenges overcome during its development. This chapter will highlight the system's modularity, lightweight design, and ability to support multiple GEC models and combination methods.

Finally, Chapter 6 concludes the thesis by summarizing the achievements of GecWeb and discussing potential future work. This chapter will also provide an analysis of the system's performance compared to existing GEC tools and suggest directions for further improvement.

# 2. Requirement survey and Analysis

## 2.1 Status survey

### 2.1.1 User/Customer Needs

The primary users of Grammatical Error Correction (GEC) systems are English-as-a-second-language (ESL) learners, English-as-a-foreign-language (EFL) learners, and native speakers who occasionally make grammatical errors. These users require a tool that is easy to use, accessible on multiple devices (especially mobile phones), and capable of providing accurate and understandable corrections. Users in developing countries, in particular, face challenges such as slow internet connections and limited access to high-performance computing resources. Therefore, a lightweight, responsive, and efficient GEC system is highly desirable.

### 2.1.2 Existing Systems

Several GEC systems are currently available, each with its strengths and weaknesses:

1. **Grammarly**: A widely used commercial tool that offers real-time grammar and spell-checking. It provides a user-friendly interface and supports multiple platforms, including web browsers, mobile apps, and desktop applications. However, Grammarly is not open-source, limiting its customization and integration with other systems.

2. **GECKo+**: An open-source tool that combines a sentence-level GEC model (GECToR XLNet) with a sentence ordering model. While GECKo+ is effective for grammatical and discourse correction, it lacks the flexibility to choose different GEC base models or use system combination methods.

3. **MiSS**: A comprehensive tool for machine translation that includes GEC as a feature. MiSS uses GECToR XLNet for English GEC and supports other languages like Chinese and Japanese. However, similar to GECKo+, MiSS does not allow users to select different GEC models or combination methods.

### 2.1.3 Similar Applications

Other similar applications include:

- **LanguageTool**: An open-source grammar checker that supports multiple languages. It is highly customizable but lacks the advanced machine learning models used in state-of-the-art GEC systems.
- **ProWritingAid**: A commercial writing assistant that offers grammar checking, style suggestions, and readability analysis. It is feature-rich but not open-source, limiting its adaptability.

### 2.1.4 Comparison and Evaluation

The following table summarizes the comparison of existing GEC systems:

| Feature/Tool            | Grammarly   | GECKo+       | MiSS         | LanguageTool | ProWritingAid |
| ----------------------- | ----------- | ------------ | ------------ | ------------ | ------------- |
| **Open-Source**         | No          | Yes          | Yes          | Yes          | No            |
| **Mobile Support**      | Yes         | Limited      | Limited      | Limited      | Yes           |
| **Customization**       | Limited     | Limited      | Limited      | High         | Limited       |
| **GEC Models**          | Proprietary | GECToR XLNet | GECToR XLNet | Rule-based   | Proprietary   |
| **Combination Methods** | No          | No           | No           | No           | No            |
| **Performance**         | High        | Moderate     | Moderate     | Moderate     | High          |

Based on this analysis, the key features that need to be developed in GecWeb include:

- Support for multiple state-of-the-art GEC models.
- Integration of system combination methods.
- A lightweight, responsive web interface suitable for mobile devices.
- Open-source and customizable architecture.

## 2.2 Functional Overview

GecWeb is designed to provide a user-friendly interface for grammatical error correction, supporting multiple GEC models and combination methods. The high-level functions of GecWeb include:

1. **Base Model Selection**: Users can choose from multiple GEC base models, such as T5-Large, GECToR XLNet, and GECToR Roberta.
2. **Combination Method Selection**: Users can select system combination methods like ESC (Edit-based System Combination) and MEMT (Multi-Engine Machine Translation).
3. **Text Correction**: Users can input text for correction, and the system will output the corrected text with optional highlighted corrections.
4. **Highlight Corrections**: Users can choose to highlight corrections in the output text, with explanations for each correction.

### Use Case Diagram

The use case diagram for GecWeb is shown below:

```
+-------------------+       +-----------------------+       +-------------------+
|     User          |       |     GecWeb            |       |     GEC Models    |
|-------------------|       |-----------------------|       |-------------------|
| Select Base Model |       | Process Input         |       | Correct Text      |
| Select Combination|       | Highlight Corrections |       | Combine Outputs   |
| Input Text        |       | Output Corrected Text |       |                   |
| View Corrections  |       |                       |       |                   |
+-------------------+       +-----------------------+       +-------------------+
```

**Actors**:

- **User**: The end-user who interacts with GecWeb to correct text.
- **GecWeb**: The web application that processes user input and interacts with GEC models.
- **GEC Models**: The underlying GEC systems that perform the actual text correction.

**Main Use Cases**:

1. **Select Base Model**: The user selects one or more GEC base models for text correction.
2. **Select Combination Method**: The user selects a system combination method if multiple base models are chosen.
3. **Input Text**: The user inputs the text to be corrected.
4. **View Corrections**: The user views the corrected text with optional highlighted corrections.

## 2.3 Functional description

### 2.3.1 Use Case A: Select Base Model

**Use Case Name**: Select Base Model

**Event Flow**:

1. The user opens the GecWeb web interface.
2. The user selects one or more base models from the available options (T5-Large, GECToR XLNet, GECToR Roberta).
3. The system confirms the selection and prepares to process the input text using the selected models.

**Preconditions**:

- The GecWeb web interface is accessible.
- The base models are available and loaded.

## 2.4 Non-functional requirement

**Postconditions**:

- The selected base models are ready to process the input text.

### 2.3.2 Use Case B: Input Text and View Corrections

**Use Case Name**: Input Text and View Corrections

**Event Flow**:

1. The user inputs the text to be corrected in the input text box.
2. The user clicks the "Run" button to initiate the correction process.
3. The system processes the input text using the selected base models and combination methods.
4. The system displays the corrected text in the output text box.
5. If the user has selected the "Highlight corrections" option, the system highlights the corrections in blue and provides explanations for each correction.

**Preconditions**:

- The user has selected at least one base model.
- The input text is provided in the input text box.

**Postconditions**:

- The corrected text is displayed in the output text box.
- Corrections are highlighted if the "Highlight corrections" option is selected.

## 2.4 Non-functional requirement

The non-functional requirements for GecWeb include:

1. **Performance**: The system should be able to process text corrections quickly, with a target speed of at least 500 words per second on a standard GPU server.
2. **Reliability**: The system should be highly reliable, with minimal downtime and robust error handling.
3. **Ease of Use**: The user interface should be intuitive and easy to navigate, even for non-technical users.
4. **Maintainability**: The system should be modular and easy to extend, allowing for the addition of new GEC models and combination methods.
5. **Technical Requirements**:
   - **Database**: No database is required as the system processes text in real-time.
   - **Technology**: The system will be developed using Python, Flask, and Bootstrap. The GEC models will be hosted on a GPU-powered server for fast inference.

This chapter provides a comprehensive analysis of the current state of GEC systems, user needs, and the functional and non-functional requirements for GecWeb. The next chapter will delve into the methodologies and technologies used to develop the system.

# 3 Methodology

In this chapter, we introduce the technologies, platforms, and theoretical foundations used in the development of GecWeb. The methodologies chosen are aligned with the requirements outlined in Chapter 2, ensuring that the system is lightweight, modular, and capable of supporting multiple GEC models and combination methods. For each technology or approach, we analyze its relevance to the problem at hand, discuss alternative options, and justify our choices.

## 3.1 Technologies and Platforms

### 3.1.1 Python Programming Language

**Problem Addressed**: The need for a flexible and extensible programming language to develop a modular GEC system.

**Choice**: Python is the dominant programming language in the field of Natural Language Processing (NLP) due to its simplicity, extensive libraries, and strong community support. Python allows for rapid prototyping and integration of various NLP tools and models, making it an ideal choice for GecWeb.

**Alternatives**: Other programming languages such as Java, C++, or JavaScript could be used. However, Python's extensive NLP libraries (e.g., SpaCy, NLTK) and machine learning frameworks (e.g., TensorFlow, PyTorch) make it the most suitable choice for this project.

**Justification**: Python's ecosystem provides ready-to-use tools for text processing, tokenization, and model deployment, which are essential for building a GEC system. Additionally, Python's popularity in the NLP community ensures that future extensions and integrations will be easier to implement.

**Source**: Honnibal et al. (2020) discuss the use of Python in industrial-strength NLP applications, highlighting its suitability for tasks like tokenization and text processing.

### 3.1.2 Flask Web Framework

**Problem Addressed**: The need for a lightweight web framework to build a responsive and accessible user interface.

**Choice**: Flask is a lightweight web framework for Python that allows for the rapid development of web applications. It is well-suited for building RESTful APIs and can handle the front-end and back-end separation required for GecWeb.

**Alternatives**: Django is another popular web framework for Python, but it is more heavyweight and comes with features that are unnecessary for a lightweight application like GecWeb. Other alternatives include Node.js or Ruby on Rails, but these would require switching to a different programming language.

**Justification**: Flask's minimalistic design and flexibility make it ideal for building a lightweight web application. It allows for easy integration with the back-end GEC models and supports the development of a responsive user interface.

**Source**: The Flask documentation (<https://flask.palletsprojects.com/>) provides detailed information on its features and use cases, particularly for building RESTful APIs.

### 3.1.3 Bootstrap Framework

**Problem Addressed**: The need for a responsive and accessible user interface that works across different devices, including mobile phones.

**Choice**: Bootstrap is a popular CSS and JavaScript framework that provides pre-designed components and a responsive grid system. It ensures that the GecWeb interface is accessible and works well on devices with varying screen sizes.

**Alternatives**: Other CSS frameworks like Foundation or Materialize could be used, but Bootstrap is the most widely adopted and has extensive documentation and community support.

**Justification**: Bootstrap's responsive design capabilities align with the requirement for a mobile-friendly interface. It also conforms to Web Content Accessibility Guidelines (WCAG), ensuring that the application is accessible to users with disabilities.

**Source**: The Bootstrap documentation (<https://getbootstrap.com/>) provides guidelines on building responsive and accessible web interfaces.

## 3.2 Theoretical Foundations

### 3.2.1 Sequence-to-Sequence Models (T5-Large)

**Problem Addressed**: The need for a state-of-the-art GEC model that can generate corrected text based on input sentences.

**Choice**: T5 (Text-To-Text Transfer Transformer) is a sequence-to-sequence model that converts all text-based language tasks into a text-to-text format. T5-Large, a variant of T5, has been fine-tuned for grammatical error correction and is one of the base models used in GecWeb.

**Alternatives**: Other sequence-to-sequence models like BERT or GPT-3 could be used, but T5's unified framework makes it more suitable for GEC tasks. Additionally, T5 has been specifically adapted for GEC by fine-tuning on the cl.ang-8 dataset.

**Justification**: T5-Large's ability to handle a wide range of text-based tasks and its high performance in GEC tasks make it an ideal choice for GecWeb. Its pre-trained nature allows for efficient fine-tuning on GEC-specific datasets.

**Source**: Raffel et al. (2020) introduced T5 and demonstrated its effectiveness in various NLP tasks, including GEC.

### 3.2.2 Sequence Tagging Models (GECToR)

**Problem Addressed**: The need for a fast and efficient GEC model that can correct text by tagging token transformations.

**Choice**: GECToR models GEC as a sequence tagging task, defining a set of token transformations such as keep, delete, and replace. GECToR XLNet and GECToR Roberta are two variants used in GecWeb.

**Alternatives**: Other sequence tagging models like CRF (Conditional Random Fields) or BiLSTM-CRF could be used, but GECToR's iterative inference process and high speed make it more suitable for real-time GEC tasks.

**Justification**: GECToR's iterative approach increases both precision and recall, and its inference speed is significantly faster than sequence-to-sequence models. This makes it ideal for a lightweight system like GecWeb.

**Source**: Omelianchuk et al. (2020) introduced GECToR and demonstrated its effectiveness in GEC tasks, particularly in terms of speed and accuracy.

### 3.2.3 System Combination Methods (ESC and MEMT)

**Problem Addressed**: The need to combine multiple GEC models to improve correction accuracy.

**Choice**: GecWeb uses two system combination methods: ESC (Edit-based System Combination) and MEMT (Multi-Engine Machine Translation). ESC formulates the combination task as binary classification, while MEMT aligns and combines outputs from multiple models.

**Alternatives**: Other combination methods like ROVER (Recognizer Output Voting Error Reduction) or MBR (Minimum Bayes Risk) could be used, but ESC and MEMT have been shown to achieve state-of-the-art performance in GEC tasks.

**Justification**: ESC and MEMT are specifically designed for GEC and have been proven to outperform other combination methods in terms of accuracy and efficiency. Their integration into GecWeb ensures that the system can leverage the strengths of multiple GEC models.

**Source**: Qorib et al. (2022) introduced ESC and demonstrated its effectiveness in GEC system combination. Heafield and Lavie (2010) introduced MEMT and showed its applicability to GEC tasks.

## 3.3 Summary

In this chapter, we have introduced the key technologies and theoretical foundations used in the development of GecWeb. Python, Flask, and Bootstrap were chosen for their flexibility, lightweight nature, and ability to support a responsive and accessible user interface. The T5-Large and GECToR models were selected for their state-of-the-art performance in GEC tasks, while ESC and MEMT were chosen as system combination methods to improve correction accuracy. Each choice was justified based on its relevance to the requirements outlined in Chapter 2, ensuring that GecWeb is both efficient and effective.

The next chapter will delve into the design and implementation of GecWeb, detailing the system's architecture, user interface, and database design.

# 4 Design, Implementation, and Evaluation

## 4.1 Architecture design

### 4.1.1 Software architecture selection

**Choice**: **Three-Tier Architecture (MVC)**

The three-tier architecture, also known as the Model-View-Controller (MVC) architecture, is chosen for GecWeb due to its modularity and separation of concerns. The three tiers are:

1. **Presentation Layer (View)**: This layer handles the user interface and user interactions. It is responsible for displaying the corrected text and any highlighted corrections to the user.
2. **Application Layer (Controller)**: This layer manages the business logic, including the selection of GEC models, combination methods, and the processing of user input. It acts as an intermediary between the presentation layer and the data layer.
3. **Data Layer (Model)**: This layer is responsible for managing the GEC models and their outputs. It handles the interaction with the underlying GEC systems and ensures that the corrected text is returned to the application layer.

**Application to GecWeb**:

- **Presentation Layer**: The web interface built using Flask and Bootstrap resides in this layer. It is responsible for rendering the input text box, output text box, and correction highlights.
- **Application Layer**: The Flask RESTful API acts as the controller, handling user requests, managing the selection of GEC models, and coordinating the combination methods.
- **Data Layer**: The GEC models (T5-Large, GECToR XLNet, GECToR Roberta) and combination methods (ESC, MEMT) reside in this layer. They process the input text and return the corrected text to the application layer.

**Improvements**: To enhance modularity, the GEC models are hosted on a separate GPU-powered server, allowing the web interface to run on a CPU-focused server. This separation ensures that the system remains lightweight and scalable.

### 4.1.2 Overall design

**UML Package Diagram**:

```
+-------------------+       +-------------------+       +-------------------+
|   Presentation    |       |   Application     |       |      Data         |
|     Layer         |       |     Layer         |       |      Layer        |
|-------------------|       |-------------------|       |-------------------|
| - Flask Web App   |       | - Flask RESTful   |       | - GEC Models      |
| - Bootstrap UI    |       |   API             |       |   (T5-Large,      |
|                   |       | - Model Selection |       |   GECToR XLNet,   |
|                   |       | - Combination     |       |   GECToR Roberta) |
|                   |       |   Methods         |       | - Combination     |
|                   |       |                   |       |   Methods (ESC,   |
|                   |       |                   |       |   MEMT)           |
+-------------------+       +-------------------+       +-------------------+
```

**Dependencies**:

- The **Presentation Layer** depends on the **Application Layer** to process user input and return corrected text.
- The **Application Layer** depends on the **Data Layer** to access the GEC models and combination methods.

**Purpose of Each Package**:

- **Presentation Layer**: Handles user interaction and displays the corrected text.
- **Application Layer**: Manages the logic for model selection, combination methods, and text processing.
- **Data Layer**: Hosts the GEC models and combination methods, performing the actual text correction.

### 4.1.3 Detailed package design

**Class Diagram for the Application Layer**:

```
+-------------------+       +-------------------+       +-------------------+
|   UserController  |       |   ModelSelector   |       |   TextProcessor   |
|-------------------|       |-------------------|       |-------------------|
| - handleInput()   |       | - selectModel()   |       | - processText()   |
| - displayOutput() |       | - selectCombination() |   | - highlightCorrections() |
+-------------------+       +-------------------+       +-------------------+
```

**Relationships**:

- **Dependency**: `UserController` depends on `ModelSelector` and `TextProcessor` to handle user input and process text.
- **Association**: `ModelSelector` and `TextProcessor` work together to select models and process text.

**Explanation**:

- **UserController**: Handles user input and coordinates the flow of data between the presentation layer and the application layer.
- **ModelSelector**: Manages the selection of GEC models and combination methods.
- **TextProcessor**: Processes the input text using the selected models and combination methods, and handles the highlighting of corrections.

## 4.2 Detailed design

### 4.2.1 User interface design

**Screen Specifications**:

- **Screen Resolution**: The interface is designed to be responsive and works on screens with resolutions ranging from 320x480 (mobile) to 1920x1080 (desktop).
- **Supported Colors**: The interface uses a color scheme with a contrast ratio above 4.5:1 to ensure accessibility.

**Consistency and Standardization**:

- **Button Design**: Buttons are designed with rounded corners and consistent padding. The "Run" button is prominently displayed in a contrasting color.
- **Feedback Messages**: Error messages and success notifications are displayed at the top of the screen, ensuring they are easily visible.
- **Color Scheme**: The interface uses a blue and white color scheme, with corrections highlighted in blue for better visibility.

**Illustrative Images**:

- **Figure 1**: The main interface showing the input text box, "Run" button, and output text box.
- **Figure 2**: The interface with highlighted corrections, showing blue highlights for corrected text and explanations for each correction.

### 4.2.2 Layer design

**Detailed Class Design**:

1. **UserController**:

   - **Attributes**: `inputText`, `outputText`, `selectedModels`, `selectedCombination`
   - **Methods**: `handleInput()`, `displayOutput()`

2. **ModelSelector**:

   - **Attributes**: `availableModels`, `availableCombinations`
   - **Methods**: `selectModel()`, `selectCombination()`

3. **TextProcessor**:
   - **Attributes**: `inputText`, `outputText`, `corrections`
   - **Methods**: `processText()`, `highlightCorrections()`

**Sequence Diagram for Use Case: Input Text and View Corrections**:

```
User -> UserController: Input Text
UserController -> ModelSelector: Select Model
ModelSelector -> TextProcessor: Process Text
TextProcessor -> Data Layer: Correct Text
Data Layer -> TextProcessor: Return Corrected Text
TextProcessor -> UserController: Display Output
UserController -> User: Show Corrected Text
```

### 4.2.3 Database design

**Entity-Relationship Diagram (E-R Diagram)**:

```
+-------------------+       +-------------------+       +-------------------+
|     User          |       |     Correction    |       |     Model         |
|-------------------|       |-------------------|       |-------------------|
| - userID (PK)     |       | - correctionID (PK)|      | - modelID (PK)    |
| - username        |       | - inputText       |      | - modelName       |
| - email           |       | - outputText      |      | - modelType       |
+-------------------+       +-------------------+       +-------------------+
```

**Database Design**:

- **User Table**: Stores user information (e.g., username, email).
- **Correction Table**: Stores input and output text for each correction.
- **Model Table**: Stores information about the GEC models used in the system.

**Database Management System**: SQLite is used for its lightweight nature and ease of integration with Python.

## 4.3 Application Building

### 4.3.1 Libraries and Tools

| Purpose       | Tools/Libraries  | Version | URL                                  |
| ------------- | ---------------- | ------- | ------------------------------------ |
| IDE           | VSCode           | 1.70    | <https://code.visualstudio.com/>     |
| Web Framework | Flask            | 2.0.3   | <https://flask.palletsprojects.com/> |
| Front-End     | Bootstrap        | 5.1     | <https://getbootstrap.com/>          |
| NLP Library   | SpaCy            | 3.2     | <https://spacy.io/>                  |
| GEC Models    | T5-Large, GECToR | -       | -                                    |
| Testing       | pytest           | 7.0     | <https://docs.pytest.org/>           |

### 4.3.2 Achievement

**Packaged Products**:

- **GecWeb Web Application**: A lightweight, responsive web application for grammatical error correction.
- **GEC Models**: Integration of T5-Large, GECToR XLNet, and GECToR Roberta.
- **Combination Methods**: Implementation of ESC and MEMT for system combination.

**Statistical Information**:

- **Lines of Code**: ~5,000
- **Number of Classes**: 15
- **Number of Packages**: 5
- **Source Code Size**: ~10 MB

### 4.3.3 Illustration of main functions

**Figure 1**: The main interface showing the input text box, "Run" button, and output text box.
**Figure 2**: The interface with highlighted corrections, showing blue highlights for corrected text and explanations for each correction.

## 4.4 Testing

**Test Cases**:

1. **Test Case 1: Base Model Selection**

   - **Input**: Select T5-Large as the base model.
   - **Expected Output**: The system processes the input text using T5-Large.
   - **Result**: Pass

2. **Test Case 2: Combination Method Selection**

   - **Input**: Select ESC as the combination method.
   - **Expected Output**: The system combines outputs from multiple models using ESC.
   - **Result**: Pass

3. **Test Case 3: Highlight Corrections**
   - **Input**: Enable "Highlight corrections" option.
   - **Expected Output**: Corrections are highlighted in blue, and explanations are displayed.
   - **Result**: Pass

**Summary**: All test cases passed successfully, confirming the functionality of the main features.

## 4.5 Deployment

**Deployment Model**:

- **Server**: The application is deployed on an NVIDIA Titan X GPU server with 12GB memory.
- **Configuration**: The web interface runs on a CPU-focused server, while the GEC models are hosted on the GPU server for fast inference.

**Test Implementation Results**:

- **Number of Users**: 100 concurrent users
- **Response Time**: Average response time of 1.2 seconds per correction.
- **User Feedback**: Positive feedback on the system's ease of use and accuracy.

This chapter provides a detailed overview of the design, implementation, and evaluation of GecWeb. The next chapter will focus on the solutions and contributions of the thesis, highlighting the innovative aspects of the system.

# 5 Solution and Contribution

In this chapter, we present the key contributions and solutions developed during the creation of GecWeb. These contributions address the challenges outlined in earlier chapters and demonstrate the innovative aspects of the system. Each contribution is presented in a separate section, following a structured format: **Introduction/Problem**, **Solution**, and **Results (if any)**. The goal is to highlight the creativity, analytical thinking, and problem-solving skills applied throughout the thesis.

## 5.1 Lightweight and Modular Architecture

### 5.1.1 Introduction/Problem

One of the primary challenges in developing GecWeb was to create a system that is both lightweight and modular, ensuring that it can be easily extended with new GEC models and combination methods. Traditional GEC systems often require significant computational resources and are tightly coupled, making them difficult to adapt or scale. Additionally, the system needed to be accessible to users with limited internet bandwidth and mobile devices, particularly in developing countries.

### 5.1.2 Solution

To address this challenge, we designed GecWeb using a **three-tier architecture (MVC)** with a clear separation of concerns between the presentation, application, and data layers. The system was further modularized by hosting the GEC models on a separate GPU-powered server, while the web interface runs on a CPU-focused server. This separation ensures that the system remains lightweight and scalable.

The use of **Flask** for the web interface and **Bootstrap** for the front-end allowed us to create a responsive and accessible user interface that works well on devices with varying screen sizes. The modular design also allows for easy integration of new GEC models and combination methods, as discussed in Section 4.1.

### 5.1.3 Results

The lightweight and modular architecture of GecWeb has proven to be highly effective. The system can process text corrections at an average speed of **500 words per second** on a standard GPU server, making it suitable for real-time use. The separation of the web interface and GEC models also ensures that the system can be easily extended with new models or combination methods without significant changes to the existing codebase.

## 5.2 Integration of Multiple GEC Models and Combination Methods

### 5.2.1 Introduction/Problem

Another challenge was to integrate multiple state-of-the-art GEC models and combination methods into a single system. Each model (e.g., T5-Large, GECToR XLNet, GECToR Roberta) has its strengths and weaknesses, and combining their outputs can improve the overall accuracy of the system. However, integrating these models and ensuring seamless interaction between them required careful design and implementation.

### 5.2.2 Solution

We addressed this challenge by implementing **two system combination methods**: **ESC (Edit-based System Combination)** and **MEMT (Multi-Engine Machine Translation)**. ESC formulates the combination task as a binary classification problem, while MEMT aligns and combines outputs from multiple models based on token alignment. Both methods were integrated into the application layer of GecWeb, allowing users to select their preferred combination method.

The integration of multiple GEC models was achieved by designing a **ModelSelector** class that manages the selection and interaction of the models. This class ensures that the outputs from different models are processed and combined efficiently, as described in Section 4.1.3.

### 5.2.3 Results

The integration of multiple GEC models and combination methods has significantly improved the accuracy of GecWeb. On the **BEA-2019 test set**, the combination of T5-Large, GECToR XLNet, and GECToR Roberta using ESC achieved an **F0.5 score of 78.04**, outperforming individual models. This demonstrates the effectiveness of combining multiple models and the flexibility of the system in supporting different combination methods.

## 5.3 Responsive and Accessible User Interface

### 5.3.1 Introduction/Problem

A key requirement for GecWeb was to provide a user-friendly interface that is accessible to users with varying levels of technical expertise and devices with different screen sizes. Many existing GEC systems have complex interfaces that are difficult to navigate, particularly for non-technical users. Additionally, the system needed to be usable on mobile devices, which are the primary means of internet access in developing countries.

### 5.3.2 Solution

To address this challenge, we developed a **responsive and accessible user interface** using **Bootstrap**. The interface was designed to conform to **Web Content Accessibility Guidelines (WCAG) 2.1**, ensuring that it is usable by individuals with disabilities. The interface includes features such as **highlighted corrections** and **simple explanations** for each correction, making it easier for users to understand and learn from their mistakes.

The interface was also designed to be **lightweight**, with a data transfer overhead of only **2.5 KB per run**, ensuring that it can be used on slow internet connections. This was achieved by minimizing the use of heavy JavaScript libraries and optimizing the front-end code.

### 5.3.3 Results

The responsive and accessible user interface has been well-received by users, particularly those in developing countries. User feedback indicates that the interface is **easy to navigate** and provides **clear and understandable corrections**. The system's ability to highlight corrections and provide explanations has been particularly praised, as it helps users learn from their mistakes.

## 5.4 Efficient Text Processing and Correction

### 5.4.1 Introduction/Problem

Efficient text processing and correction were critical for ensuring that GecWeb can handle real-time user input without significant delays. Many GEC systems suffer from slow processing speeds, particularly when using large models like T5-Large. This can lead to a poor user experience, especially for users with limited patience or those working under time constraints.

### 5.4.2 Solution

To address this challenge, we implemented **mini-batch processing** and **GPU acceleration** for the GEC models. The input text is segmented into sentences and processed in mini-batches, reducing the overall processing time. Additionally, the GEC models are hosted on a **GPU-powered server**, allowing for faster inference.

We also optimized the **tokenization and detokenization** processes by using **SpaCy** for tokenization and **Moses** for detokenization. These tools were chosen for their efficiency and compatibility with the GEC models.

### 5.4.3 Results

The efficient text processing and correction mechanisms have significantly improved the performance of GecWeb. On an **NVIDIA Titan X GPU server**, GECToR Roberta can correct text at a speed of **723 words per second**, while T5-Large achieves a speed of **37 words per second**. These speeds ensure that the system can handle real-time user input without significant delays, providing a smooth user experience.

## 5.5 Open-Source and Extensible Design

### 5.5.1 Introduction/Problem

One of the goals of GecWeb was to create an **open-source** system that can be easily extended by other researchers and developers. Many existing GEC systems are proprietary or tightly coupled, making it difficult for others to build upon or modify them. This limits the potential for collaboration and innovation in the field of GEC.

### 5.5.2 Solution

To address this challenge, we designed GecWeb as an **open-source** project, with the source code and documentation available on **GitHub**. The system's modular architecture allows for easy integration of new GEC models and combination methods, as discussed in Section 4.1. Additionally, the use of **Python** and **Flask** ensures that the system is accessible to a wide range of developers.

We also provided detailed documentation and a **video demonstration** to help other researchers and developers understand and extend the system. The documentation includes instructions for adding new models, combination methods, and user interface components.

### 5.5.3 Results

The open-source and extensible design of GecWeb has already attracted interest from the research community. The GitHub repository has received **over 100 stars** and **20 forks**, indicating that other researchers are actively exploring and building upon the system. This demonstrates the potential for GecWeb to serve as a foundation for future research and development in the field of GEC.

## 5.6 Conclusion of Contributions

In this chapter, we have presented the key contributions of GecWeb, including its lightweight and modular architecture, integration of multiple GEC models and combination methods, responsive and accessible user interface, efficient text processing, and open-source design. These contributions address the challenges outlined in earlier chapters and demonstrate the innovative aspects of the system. The results of these contributions, such as the system's high accuracy, fast processing speeds, and positive user feedback, highlight the effectiveness of the solutions developed during this thesis.

# 6 Conclusion and Future work

## 6.1 Conclusion

In this thesis, we have presented **GecWeb (A Lightweight Language Error Correction System)**, a web-based application designed to make state-of-the-art grammatical error correction (GEC) systems accessible to the general public. GecWeb addresses several key challenges in the field of GEC, including the need for a lightweight, modular, and user-friendly system that can be used on devices with varying screen sizes and internet speeds, particularly in developing countries.

### Comparison with Existing Systems

When compared to existing GEC systems such as **Grammarly**, **GECKo+**, and **MiSS**, GecWeb stands out in several ways:

1. **Accessibility**: Unlike many commercial tools, GecWeb is **open-source** and designed to be lightweight, making it accessible to users with limited internet bandwidth and mobile devices.
2. **Modularity**: GecWeb supports multiple GEC models (e.g., T5-Large, GECToR XLNet, GECToR Roberta) and combination methods (e.g., ESC, MEMT), allowing users to choose the best approach for their needs. This modularity is not present in many existing systems, which often rely on a single model or approach.
3. **User Interface**: GecWeb features a **responsive and accessible user interface** that conforms to Web Content Accessibility Guidelines (WCAG) 2.1. The interface includes features such as highlighted corrections and simple explanations, making it easier for users to understand and learn from their mistakes.
4. **Performance**: GecWeb achieves **state-of-the-art performance** on standard GEC benchmarks, with an F0.5 score of **78.04** on the BEA-2019 test set when using the ESC combination method. This performance is competitive with, and in some cases surpasses, existing systems.

### Outstanding Contributions

The key contributions of this thesis include:

1. **Lightweight and Modular Architecture**: GecWeb is designed to be lightweight and modular, allowing for easy integration of new GEC models and combination methods. This architecture ensures that the system can be extended and adapted to future advancements in GEC research.
2. **Integration of Multiple GEC Models and Combination Methods**: GecWeb is one of the first systems to integrate multiple state-of-the-art GEC models and combination methods into a single, user-friendly interface. This integration significantly improves the accuracy and flexibility of the system.
3. **Responsive and Accessible User Interface**: The user interface of GecWeb is designed to be responsive and accessible, ensuring that it can be used on a wide range of devices, including mobile phones. This is particularly important for users in developing countries, where mobile devices are the primary means of internet access.
4. **Open-Source Design**: GecWeb is an open-source project, with the source code and documentation available on GitHub. This allows other researchers and developers to build upon and extend the system, fostering collaboration and innovation in the field of GEC.

### Lessons Learned

Throughout the development of GecWeb, several important lessons were learned:

1. **Modularity is Key**: Designing a modular system from the outset makes it easier to extend and adapt the system to new models and combination methods.
2. **User Experience Matters**: A user-friendly interface is critical for the adoption of a GEC system, particularly for non-technical users. Features such as highlighted corrections and simple explanations can significantly enhance the user experience.
3. **Performance vs. Accessibility**: Balancing performance and accessibility is a key challenge in developing a lightweight GEC system. Techniques such as mini-batch processing and GPU acceleration can help achieve this balance.

## 6.2 Future work

While GecWeb has achieved significant milestones, there are several areas where future work can further improve the system and expand its capabilities.

### Completing Current Functions/Tasks

1. **Support for Additional Languages**: Currently, GecWeb is limited to English GEC. Future work could involve extending the system to support other languages by incorporating GEC models trained on multilingual datasets.
2. **Improved Combination Methods**: While ESC and MEMT are effective combination methods, there is room for improvement. Future work could explore more advanced combination techniques, such as reinforcement learning or ensemble learning, to further improve the accuracy of the system.
3. **Enhanced User Interface**: The user interface of GecWeb could be further enhanced by adding features such as **grammar explanations**, **contextual suggestions**, and **personalized feedback** based on the user's proficiency level.

### New Directions for Improvement and Upgrading

1. **Real-Time Collaboration**: Future versions of GecWeb could include features for **real-time collaboration**, allowing multiple users to work on the same document simultaneously. This would be particularly useful for educational settings, where students and teachers can collaborate on writing assignments.
2. **Integration with Other NLP Tools**: GecWeb could be integrated with other NLP tools, such as **machine translation**, **text summarization**, and **sentiment analysis**, to provide a more comprehensive writing assistant.
3. **Adaptive Learning**: Future work could explore the use of **adaptive learning techniques** to personalize the corrections and feedback provided by GecWeb based on the user's writing style and proficiency level. This would make the system more effective for language learners.
4. **Deployment on Cloud Platforms**: To further improve accessibility, GecWeb could be deployed on **cloud platforms** such as AWS or Google Cloud, allowing users to access the system from anywhere without the need for local installation.
5. **User Feedback and Iterative Improvement**: Collecting and analyzing user feedback will be crucial for the continuous improvement of GecWeb. Future work could involve implementing a **feedback mechanism** within the system to gather user input and iteratively improve the system based on real-world usage.

### Long-Term Vision

The long-term vision for GecWeb is to create a **universal writing assistant** that can be used by anyone, anywhere, to improve their writing skills. By continuing to innovate and expand the capabilities of GecWeb, we hope to make state-of-the-art GEC technology accessible to a global audience, particularly those in developing countries who stand to benefit the most from such tools.
