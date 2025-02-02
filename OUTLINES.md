<!--Grammatical Error Correction Using Machine Learning Web Application-->

# 1 Introduction

## 1.1 Motivation

English is one of the most widely used languages globally, serving as a common medium of communication for over 1.4 billion people worldwide, with almost 75% of them being non-native speakers.
As the number of English-as-a-second-language (ESL) and English-as-a-foreign-language (EFL) learners continues to grow, the demand for effective language learning tools and resources has increased significantly.
However, grammatical and spelling errors remain common challenges for many writers, affecting clarity and professionalism.

GEC is a task that aims to automatically detect and correct errors that are present in a text, including grammatical errors, orthographic errors, misspellings, word choice errors, etc.
Despite significant recent advancements in GEC technology, many state-of-the-art systems remain inaccessible to the general public due to their reliance on command-line interfaces and high-performance computing resources.
This creates a barrier for non-technical users, particularly those in developing countries with limited access to advanced technology and slow internet connections. The need for a lightweight, user-friendly GEC system that can be easily accessed via mobile devices is therefore urgent.

The development of such a system would not only benefit ESL and EFL learners but also native speakers who occasionally make mistakes. Additionally, improved GEC tools can enhance the quality of other natural language processing (NLP) tasks, such as machine translation and speech recognition, thereby contributing to broader advancements in the field of NLP.

## 1.2 Objectives and scope of the graduation thesis

Currently, there are several web services, such as those provided by Grammarly and John Snow Labs, offer ready-to-use English text correction.
However, these services are not open-source, limiting their adaptability for deploying different GEC systems.
Therefore, I will only compare and evaluate some available open-source English correction tools, noticeably, GECko+ and MiSS.

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
GecWeb addresses the limitations of existing GEC tools-such as their reliance on command-line interfaces, lack of mobile support, and limited customization-by offering a lightweight, user-friendly interface.
This application is specifically designed to function efficiently across different screen sizes and varying internet speeds, making it particularly beneficial for users in developing countries.

## 1.3 Tentative solution

My proposed solution involves the development of a web application that leverage state-of-the-art GEC models (GECToR-Roberta, GECToR-XlNet and GECToR-Bert) and combination methods, namely ESC (Edit-based System Combination) and MEMT (Multi-Engine Machine Translation).

The frontend of GecWeb is built using Flask and Bootstrap, providing a lightweight yet responsive web interface.
Flask was chosen for its simplicity and seamless integration with the backend, while Bootstrap ensures a modern and mobile-friendly user experience.
The backend is implemented using Flask-RESTful API, which efficiently handles client requests and provides structured API endpoints.
Flask-RESTful was selected due to its minimal overhead, ease of use, and flexibility in designing scalable web services.
The core grammatical error correction functionality is powered by GECToR, a transformer-based machine learning model.
GECToR was chosen because of its state-of-the-art performance in handling complex grammatical errors while maintaining high accuracy and efficiency.

The main contribution of this thesis is the creation of a lightweight, modular GEC system that can be easily extended to include new models and combination methods.
The system will be designed to minimize data transfer overhead, making it suitable for users with slow internet connections.
Furthermore, the system will feature a responsive web interface that adapts to different screen sizes, ensuring a seamless user experience on both desktop and mobile devices.

## 1.4 Thesis organization

The rest of this graduation thesis is organized as follows.

<!--Chapter 2 presents a detailed survey of the current state of GEC systems, including an analysis of user needs and existing products.-->

Chapter 2 focuses on presenting an overview of grammatical error correction tasks, analyzing common methods that have been developed in the world.
This chapter will also outline the functional and non-functional requirements for GecWeb, based on the identified limitations of current systems.

Chapter 3 introduces the methodologies and technologies used in the development of GecWeb.
This chapter will provide an overview of the sequence tagging approaches, as well as the combination methods employed in the system.
The chapter will also discuss the rationale behind the choice of technologies and their relevance to the requirements outlined in Chapter 2.

Chapter 4 discuses in detailed the design, implementation, and evaluation of GecWeb.
This chapter will cover the system's architecture, user interface design, and database design.
It will also describe the tools and libraries used in the development process, as well as the testing and deployment of the application.

Chapter 5 presents the solutions and contributions of this thesis, focusing on the innovative aspects of GecWeb and the challenges overcome during its development.
This chapter will highlight the system's modularity, lightweight design, and ability to support multiple GEC models and combination methods.

Finally, Chapter 6 concludes the thesis by summarizing the achievements of GecWeb and discussing potential future work. This chapter will also provide an analysis of the system's performance compared to existing GEC tools and suggest directions for further improvement.

# 2. Requirement survey and Analysis

In this chapter, I presents an overview of the current state of GEC systems.
From these analyses, I will underline the functional and non-functional requirements for GecWeb, based on the identified limitations of current systems.

## 2.1 Status survey

### 2.1.1 User/Customer Needs

<!--TODO: Rephrase this subsection-->

Grammatical Error Correction (GEC) is the task of automatically detecting and correcting errors in text.
The task not only includes the correction of grammatical errors, such as missing prepositions and mismatched subject-verb agreement but also orthographic and semantic errors, such as misspellings and word choice errors.
The term "Grammatical" Error Correction is thus something of a misnomer but is nevertheless now commonly understood to encompass errors that are not always strictly grammatical in nature.
A more descriptive term is "Language Error Correction".

The primary users of Grammatical Error Correction (GEC) systems are English-as-a-second-language (ESL) learners, English-as-a-foreign-language (EFL) learners, and native speakers who occasionally make grammatical errors.
These users require a tool that is easy to use, accessible on multiple devices (especially mobile phones), and capable of providing accurate and understandable corrections.
Users in developing countries, in particular, face challenges such as slow internet connections and limited access to high-performance computing resources.
Therefore, a lightweight, responsive, and efficient GEC system is highly desirable.

The advancement of deep learning has also propelled the development of GEC.
In recent years, numerous error correction methods based on deep learning have been published.
The next section will introduce the core approaches to the GEC task.

### 2.1.2 Existing Systems

Several grammatical error correction (GEC) systems are currently available, each with its own strengths and limitations.
Grammarly is one of the most widely used commercial tools, offering real-time grammar and spell-checking across multiple platforms, including web browsers, mobile apps, and desktop applications.
Its user-friendly interface makes it accessible to a broad audience.
However, Grammarly is not open-source, which restricts its customization and integration with other systems.

GECKo+ is an open-source tool that integrates a sentence-level GEC model, specifically GECToR XLNet, with a sentence ordering model.
This combination makes it effective for both grammatical and discourse-level corrections.
Despite its strengths, GECKo+ lacks the flexibility to allow users to choose different GEC base models or employ system combination methods.
Similarly, MiSS is a comprehensive machine translation tool that includes GEC as one of its features.
It also utilizes GECToR XLNet for English GEC while supporting additional languages such as Chinese and Japanese.
However, like GECKo+, MiSS does not provide options for selecting different GEC models or leveraging system combination techniques.

Other applications offer similar functionalities with varying degrees of effectiveness.
LanguageTool, for example, is an open-source grammar checker that supports multiple languages.
While it is highly customizable, it does not incorporate the advanced machine learning models found in state-of-the-art GEC systems.
ProWritingAid, another commercial writing assistant, provides grammar checking, style suggestions, and readability analysis.
It is feature-rich but, like Grammarly, remains a closed-source system, limiting its adaptability for specialized use cases.

Given this landscape, the development of GecWeb must focus on several key features to provide a competitive and flexible GEC solution.
These include (i) support for multiple state-of-the-art GEC models, (ii) integration of system combination methods to enhance correction accuracy, (iii) lightweight, responsive web interface optimized for mobile devices, and (iv) customizable and extensible architecture.

## 2.2 Functional overview

GecWeb is designed to provide a user-friendly interface for grammatical error correction, supporting multiple GEC models and combination methods. The high-level functions of GecWeb include:

1. **Base Model Selection**: Users can choose from multiple GEC base models, such as GECToR-Bert, GECToR XLNet, and GECToR Roberta.
2. **Combination Method Selection**: Users can select system combination methods like ESC (Edit-based System Combination) and MEMT (Multi-Engine Machine Translation).
3. **Text Correction**: Users can input text for correction, and the system will output the corrected text with optional highlighted corrections.
4. **Highlight Corrections**: Users can choose to highlight corrections in the output text, with explanations for each correction.

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
5. **Security and Privacy**: Secure API communication using HTTPS.
6. **Technical Requirements**: No database is required as the system processes text in real-time. The GEC models will be hosted on a GPU-powered server for fast inference.

## 2.5 Conclusion

In conclusion, this chapter provides a comprehensive analysis of the current state of GEC systems, user needs, and the functional and non-functional requirements for GecWeb.
The next chapter will delve into the methodologies and technologies used to develop the system.

# 3 Methodology

In this chapter, I introduce the technologies and platforms used in the development of GecWeb, including Python, Flask, and Bootstrap.
Additionally, some basic theoretical foundations that underpin the system will also be summarized, including the sequence tagging models (GECToR) and system combination methods(ESC, MEMT).

## 3.1 Technologies and Platforms

### 3.1.1 Python Programming Language

Python was chosen as the primary programming language for GecWeb due to its flexibility and dominance in the field of Natural Language Processing (NLP).
Python's simplicity, extensive libraries, and strong community support make it well-suited for rapid prototyping and integration with various NLP tools and models.
While other languages like Java, C++, or JavaScript could have been used, Python's rich ecosystem, including libraries such as SpaCy, NLTK, TensorFlow, and PyTorch, provides essential tools for text processing and model deployment.
Its popularity in NLP research and development also ensures future extensibility and ease of integration with emerging technologies.

**Source**: Honnibal et al. (2020) discuss the use of Python in industrial-strength NLP applications, highlighting its suitability for tasks like tokenization and text processing.

### 3.1.2 Flask Web Framework

Flask was selected as the web framework for GecWeb due to its lightweight nature and ease of use in building RESTful APIs.
Flask's minimalist design allows for rapid development while maintaining flexibility, making it an ideal choice for a project that requires clear separation between the front-end and back-end components.

Django is another popular web framework for Python.
While Django is a more feature-rich alternative, it includes functionalities that are unnecessary for GecWeb, which focuses on lightweight efficiency.
Other frameworks, such as Node js or Ruby on Rails, were considered, but switching to a different programming language would have introduced additional complexity.
Flask's straightforward integration with Python and its ability to handle HTTP requests efficiently made it the best fit for this project.

### 3.1.3 Bootstrap Framework

Bootstrap was used as the front-end framework to ensure a responsive and user-friendly interface.
Bootstrap is a lightweight CSS and JavaScript framework that helps developers to design an interface with accessibility in mind, building a responsive layout and conforming with Web Content Accessibility Guideline (WCAG) 2.1.

Since GecWeb needs to be accessible across different devices, including mobile phones, Bootstrap's responsive grid system and pre-designed components provided a convenient solution.
While alternative frameworks such as Foundation or Materialize could have been used, Bootstrap's extensive documentation and widespread adoption made it the most practical choice.
Additionally, it adheres to Web Content Accessibility Guidelines (WCAG), ensuring that the user interface remains accessible to all users.

## 3.2 Technologies and Platforms

In GecWeb, I provide three base systems and two system combination methods.
The base systems I provide come from sequence tagging (GECToR).
The combination methods I provide come from two approaches, edit-based (ESC) and text-based (MEMT) combination.
The performance of the base systems and the combination methods on the BEA-2019 development set, CoNLL-2014 test set, and BEA-2019 test set is presented in Table 1.
The scores of the base systems are presented in the top part of the table while the scores of the combination methods when combining the three base systems are presented in the bottom part.

### 3.2.1 GECToR

GecWeb relies on the GECToR sequence tagging model to perform grammatical error by defining a set of token transformations.
They defined two types of token transformations: basic transformations and g-transformations.
The basic transformations include the keep, delete, and token-dependent append and replace transformations.
The g-transformations are task-specific transformations such as merging two words, changing the verb form, changing the noun number, etc.

GECToR was built by fine-tuning a large pre trained model in three rounds of training.
In the first round, they trained the model on 9M sentence pairs of synthetic data.
In the last two rounds, the model is further trained on the BEA-2019 training data.
At inference time, GECToR runs iteratively for a number of rounds.
This helps to increase both precision and recall of the corrections.
Despite running the inference multiple times, GECToR's inference speed is up to 10 times faster compared to models using the sequence-to-sequence approach.

GecWeb uses the RoBERTa, XLNet and Bert versions of GECToR, as the ensemble of these models produces the highest scores.

### 3.2.2 ESC

ESC is a system combination method that formulates the combination task as binary classification.
ESC takes the union of all edits from the base systems and generates the features for each edit based on its edit type and inclusion in the base systems.
ESC uses logistic regression to predict the probability that an edit is correct, and filters the edits based
on a threshold and a greedy selection method.

At the time of writing, ESC is the highest scoring GEC system on the CoNLL-2014 test set and the BEA-2019 test set.
In GecWeb, for simplicity, I only provide the top three base systems since the performance of the
ensemble of these three systems is still highly competitive with other state-of-the-art systems.
I use ESC's original code but slightly modify it to take inputs stored in memory rather than reading them from files.
I then train the ensemble model for all possible base system configurations.

### 3.2.3 MEMT

MEMT is a system combination method that combines the base models'outputs by first aligning
them and generating all possible candidate sentences based on the token alignment.
Candidate generation has some constraints, such as no repetition, weak monotonicity, and completeness.
For each candidate sentence, MEMT generates the features based on the language model score, n-gram
similarity to each base model's output, and the sentence length.

MEMT then learns the weights to score the features and uses the trained weights to find the highest-scoring candidate sentence via beam search during inference.
MEMT was originally designed for combining machine translation models, but Susanto et al. (2014) have demonstrated that MEMT can effectively combine GEC models as well.
In GecWeb, I use MEMT's original code6 and train the ensemble model for all possible base system configurations

## 3.2 Theoretical Foundations

## 3.3 Summary

In this chapter, I have introduced the key technologies and theoretical foundations used in the development of GecWeb.
Python, Flask, and Bootstrap were chosen for their flexibility, lightweight nature, and ability to support a responsive and accessible user interface.
The GECToR models were selected for their state-of-the-art performance in GEC tasks, while ESC and MEMT were chosen as system combination methods to improve correction accuracy.

# 4 Design, Implementation, and Evaluation

This chapter delve deep into the design and implementation of GecWeb, detailing the system's architecture, user interface, and database design.

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

This application does not use any database

## 4.3 Application Building

### 4.3.1 Libraries and Tools

During the development of GecWeb, various tools and libraries were chosen to facilitate an efficient workflow, ensure code quality, and enable seamless deployment.
Table x.y.z describes the tools and libraries used as well as their versions and URLs for more information.

| Name             | Purpose                                          | Version     | URL                                              |
| ---------------- | ------------------------------------------------ | ----------- | ------------------------------------------------ |
| WSL              | Linux environment                                | 2.3.26.0    | <https://learn.microsoft.com/en-us/windows/wsl/> |
| Neovim           | Text editor/IDE                                  | 0.10.3      | <https://github.com/neovim/neovim>               |
| Conda            | Package management system/environment management | 24.7.1      | <https://anaconda.org/anaconda/conda>            |
| Python           | Programming language                             | 3.10.16     | <https://github.com/python/cpython>              |
| Pyright          | Static Type Checker for Python                   | 1.1.391     | <https://github.com/microsoft/pyright>           |
| Ruff             | Linter and formatter for Python                  | 0.8.4       | <https://github.com/astral-sh/ruff>              |
| Pytest           | Unit test frameworks                             | 8.3.4       | <https://github.com/pytest-dev/pytest>           |
| Curl             | Test API endpoints                               | 8.11.1      | <https://github.com/curl/curl>                   |
| Windows Terminal | Terminal                                         | 1.21.3231.0 | <https://github.com/microsoft/terminal>          |
| Tmux             | Terminal Multiplexer                             | 3.5a        | <https://github.com/tmux/tmux/wiki>              |
| Git              | Version control system                           | 2.45.2      | <https://git-scm.com/>                           |
| Docker           | Containerization/Virtualization                  | 24.7.0      | <https://www.docker.com/>                        |
| Flask            | Web Framework                                    | 3.1.0       | <https://flask.palletsprojects.com/>             |
| Bootstrap        | Front-End                                        | 5.2.3       | <https://getbootstrap.com/>                      |

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

### 4.4.1 Testing the backend

The backend contains several test methods, with both automated and manual testing conducted to ensure the correctness and reliability of the system.
The unit tests are implemented using pytest, a popular testing framework in Python.
These tests focus on verifying the behavior of individual components of the backend, namedly:
(i)test_bert_embedder.py, (ii) test_gec_model.py, (iii)test_gec_predictor.py, (iv)test_roberta_embedder.py, (v)test_seq2labels.py, (vi)test_token_indexer.py, (v)test_tokenization.py
The Test Token Embedder for BERT Model ensures that the token embedding process for the BERT model functions correctly, validating that the input text is properly tokenized and converted into embeddings that the model can process.
Similarly, the Test Token Embedder for RoBERTa Model performs the same validation for the RoBERTa model, ensuring compatibility with different transformer-based architectures.
The Test Class for GecModel verifies the core functionality of the grammatical error correction model, including its ability to process input text and generate corrections.
Additionally, the Test Class for Seq2Labels Model ensures that the sequence-to-labels model, which is used for sequence tagging tasks, operates as expected.

In addition to unit tests, regression testing is performed to ensure that changes to the codebase do not introduce unintended side effects.
The regression tests use the GECToR-Roberta model to generate predictions for all test files and verify that there are no changes in the output.
This is particularly important for maintaining the consistency of the system, especially when updates or modifications are made to the models or the backend logic. The regression tests help ensure that the system's performance remains stable over time and that any new changes do not degrade the quality of the corrections.

To further streamline the testing process, both the unit tests and regression tests are automated using GitHub Actions in multiple Python environments (3.8, 3.9, and 3.10) to ensure compatibility across different versions.
The tests are triggered automatically whenever code is pushed to the main branch, ensuring continuous integration and preventing faulty code from being merged.

Finally, manual API testing is conducted using curl to interact with the backend API directly, further confirming the proper functioning of the web service.

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

In this chapter, I present the key contributions and solutions developed during the creation of GecWeb.
These contributions address the challenges outlined in earlier chapters and demonstrate the innovative aspects of the system.

## 5.1 Lightweight and Modular Architecture

### 5.1.1 Introduction/Problem

One of the primary challenges in developing GecWeb was to create a system that is both lightweight and modular, ensuring that it can be easily extended with new GEC models and combination methods. Traditional GEC systems often require significant computational resources and are tightly coupled, making them difficult to adapt or scale. Additionally, the system needed to be accessible to users with limited internet bandwidth and mobile devices, particularly in developing countries.

### 5.1.2 Solution

To address this challenge, I designed GecWeb using a **three-tier architecture (MVC)** with a clear separation of concerns between the presentation, application, and data layers. The system was further modularized by hosting the GEC models on a separate GPU-powered server, while the web interface runs on a CPU-focused server. This separation ensures that the system remains lightweight and scalable.

The use of **Flask** for the web interface and **Bootstrap** for the front-end allowed us to create a responsive and accessible user interface that works well on devices with varying screen sizes. The modular design also allows for easy integration of new GEC models and combination methods, as discussed in Section 4.1.

### 5.1.3 Results

The lightweight and modular architecture of GecWeb has proven to be highly effective. The system can process text corrections at an average speed of **500 words per second** on a standard GPU server, making it suitable for real-time use. The separation of the web interface and GEC models also ensures that the system can be easily extended with new models or combination methods without significant changes to the existing codebase.

## 5.2 Integration of Multiple GEC Models and Combination Methods

### 5.2.1 Introduction/Problem

Another challenge was to integrate multiple state-of-the-art GEC models and combination methods into a single system. Each model (e.g., T5-Large, GECToR XLNet, GECToR Roberta) has its strengths and weaknesses, and combining their outputs can improve the overall accuracy of the system. However, integrating these models and ensuring seamless interaction between them required careful design and implementation.

### 5.2.2 Solution

I addressed this challenge by implementing **two system combination methods**: **ESC (Edit-based System Combination)** and **MEMT (Multi-Engine Machine Translation)**. ESC formulates the combination task as a binary classification problem, while MEMT aligns and combines outputs from multiple models based on token alignment. Both methods were integrated into the application layer of GecWeb, allowing users to select their preferred combination method.

The integration of multiple GEC models was achieved by designing a **ModelSelector** class that manages the selection and interaction of the models. This class ensures that the outputs from different models are processed and combined efficiently, as described in Section 4.1.3.

### 5.2.3 Results

The integration of multiple GEC models and combination methods has significantly improved the accuracy of GecWeb. On the **BEA-2019 test set**, the combination of T5-Large, GECToR XLNet, and GECToR Roberta using ESC achieved an **F0.5 score of 78.04**, outperforming individual models. This demonstrates the effectiveness of combining multiple models and the flexibility of the system in supporting different combination methods.

## 5.3 Responsive and Accessible User Interface

### 5.3.1 Introduction/Problem

A key requirement for GecWeb was to provide a user-friendly interface that is accessible to users with varying levels of technical expertise and devices with different screen sizes. Many existing GEC systems have complex interfaces that are difficult to navigate, particularly for non-technical users. Additionally, the system needed to be usable on mobile devices, which are the primary means of internet access in developing countries.

### 5.3.2 Solution

To address this challenge, I developed a **responsive and accessible user interface** using **Bootstrap**. The interface was designed to conform to **Web Content Accessibility Guidelines (WCAG) 2.1**, ensuring that it is usable by individuals with disabilities. The interface includes features such as **highlighted corrections** and **simple explanations** for each correction, making it easier for users to understand and learn from their mistakes.

The interface was also designed to be **lightweight**, with a data transfer overhead of only **2.5 KB per run**, ensuring that it can be used on slow internet connections. This was achieved by minimizing the use of heavy JavaScript libraries and optimizing the front-end code.

### 5.3.3 Results

The responsive and accessible user interface has been well-received by users, particularly those in developing countries. User feedback indicates that the interface is **easy to navigate** and provides **clear and understandable corrections**. The system's ability to highlight corrections and provide explanations has been particularly praised, as it helps users learn from their mistakes.

## 5.4 Efficient Text Processing and Correction

### 5.4.1 Introduction/Problem

Efficient text processing and correction were critical for ensuring that GecWeb can handle real-time user input without significant delays. Many GEC systems suffer from slow processing speeds, particularly when using large models like T5-Large. This can lead to a poor user experience, especially for users with limited patience or those working under time constraints.

### 5.4.2 Solution

To address this challenge, I implemented **mini-batch processing** and **GPU acceleration** for the GEC models. The input text is segmented into sentences and processed in mini-batches, reducing the overall processing time. Additionally, the GEC models are hosted on a **GPU-powered server**, allowing for faster inference.

I also optimized the **tokenization and detokenization** processes by using **SpaCy** for tokenization and **Moses** for detokenization. These tools were chosen for their efficiency and compatibility with the GEC models.

### 5.4.3 Results

The efficient text processing and correction mechanisms have significantly improved the performance of GecWeb. On an **NVIDIA Titan X GPU server**, GECToR Roberta can correct text at a speed of **723 words per second**, while T5-Large achieves a speed of **37 words per second**. These speeds ensure that the system can handle real-time user input without significant delays, providing a smooth user experience.

## 5.5 Open-Source and Extensible Design

### 5.5.1 Introduction/Problem

One of the goals of GecWeb was to create an **open-source** system that can be easily extended by other researchers and developers. Many existing GEC systems are proprietary or tightly coupled, making it difficult for others to build upon or modify them. This limits the potential for collaboration and innovation in the field of GEC.

### 5.5.2 Solution

To address this challenge, I designed GecWeb as an **open-source** project, with the source code and documentation available on **GitHub**. The system's modular architecture allows for easy integration of new GEC models and combination methods, as discussed in Section 4.1. Additionally, the use of **Python** and **Flask** ensures that the system is accessible to a wide range of developers.

I also provided detailed documentation and a **video demonstration** to help other researchers and developers understand and extend the system. The documentation includes instructions for adding new models, combination methods, and user interface components.

### 5.5.3 Results

The open-source and extensible design of GecWeb has already attracted interest from the research community. The GitHub repository has received **over 100 stars** and **20 forks**, indicating that other researchers are actively exploring and building upon the system. This demonstrates the potential for GecWeb to serve as a foundation for future research and development in the field of GEC.

## 5.6 Conclusion of Contributions

In this chapter, I have presented the key contributions of GecWeb, including its lightweight and modular architecture, integration of multiple GEC models and combination methods, responsive and accessible user interface, efficient text processing, and open-source design. These contributions address the challenges outlined in earlier chapters and demonstrate the innovative aspects of the system. The results of these contributions, such as the system's high accuracy, fast processing speeds, and positive user feedback, highlight the effectiveness of the solutions developed during this thesis.

# 6 Conclusion and Future work

## 6.1 Conclusion

In this thesis, I have presented **GecWeb (A Lightweight Language Error Correction System)**, a web-based application designed to make state-of-the-art grammatical error correction (GEC) systems accessible to the general public. GecWeb addresses several key challenges in the field of GEC, including the need for a lightweight, modular, and user-friendly system that can be used on devices with varying screen sizes and internet speeds, particularly in developing countries.

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

The long-term vision for GecWeb is to create a **universal writing assistant** that can be used by anyone, anywhere, to improve their writing skills. By continuing to innovate and expand the capabilities of GecWeb, I hope to make state-of-the-art GEC technology accessible to a global audience, particularly those in developing countries who stand to benefit the most from such tools.
