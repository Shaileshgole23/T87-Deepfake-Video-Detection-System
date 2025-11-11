<<<<<<< HEAD
# Deepfake detection using Deep Learning (ResNext and LSTM)


## 1. Introduction
This projects aims in detection of video deepfakes using deep learning techniques like ResNext and LSTM. We have achived deepfake detection by using transfer learning where the pretrained ResNext CNN is used to obtain a feature vector, further the LSTM layer is trained using the features. 


## 2. Directory Structure
For ease of understanding the project is structured in below format
```
Deepfake_detection_using_deep_learning
    |
    |--- Django Application
    |--- Model Creation
    |--- Documentaion
```
1. Django Application 
   - This directory consists of the django made application of our work. Where a user can upload the video and submit it to the model for prediction. The trained model performs the prediction and the result is displayed on the screen.
2. Model Creation
   - This directory consists of the step by step process of creating and training a deepfake detection model using our approach.
3. Documentation
   - This directory consists of all the documentation done during the project

## 3. Our Results

| Model Name | No of videos | No of Frames | Accuracy |
|------------|--------------|--------------|----------|
|model_84_acc_10_frames_final_data.pt |6000 |10 |84.21461|
|model_87_acc_20_frames_final_data.pt | 6000 |20 |87.79160|
|model_89_acc_40_frames_final_data.pt | 6000| 40 |89.34681|
|model_90_acc_60_frames_final_data.pt | 6000| 60 |90.59097 |
|model_91_acc_80_frames_final_data.pt | 6000 | 80 | 91.49818 |
|model_93_acc_100_frames_final_data.pt| 6000 | 100 | 93.58794|



## 4. We welcome Open Source Contribution. 
### Below are the some changes that can be applied to the project. New Ideas will be appreciated.
- [ ] Deploying the applications in free cloud 
- [ ] Creating open source API for detection
- [ ] Batch processing of entire video instead of processing first 'x' frames.
- [ ] Optimizing the code for faster execution.
#### Completed 
- [X] Dockerizing the app
- [X] Enabling working of project on Non Cuda Computers. i.e on normal or AMD GPUs

# 🚀 Deepfake Video Detection System

---

## ⚠️ Project Overview  
- Addresses the threat of **deepfake technology** undermining information integrity and social trust.  
- Deepfakes manipulate faces, voices, or expressions, spreading misinformation and fraud.  
- Example: Fake videos of public figures like Narendra Modi singing.

---

## 🎯 Goal  
- Build a system to classify videos as **Real** or **Fake**.  
- Utilizes a **hybrid deep learning** model: CNN + RNN + ANN.

---

## 📋 Scope & Features  
- Video input preprocessing with **OpenCV**.  
- Face extraction via **MTCNN** and **Haar Cascade**.  
- Spatial features extracted by **XceptionNet (CNN)**.  
- Temporal analysis with **RNN (LSTM/GRU)**.  
- Final classification by **ANN** with confidence scoring.  
- User-friendly web interface: **HTML, CSS, JS + Flask/FastAPI backend**.  
- Focus: Video deepfake detection; excludes audio detection and big social media integration in v1.

---

## ⚙️ Assumptions & Constraints  
- Dataset from **Kaggle Deepfake Detection Challenge**.  
- GPU-enabled environment for training.  
- Supports short video uploads (≤1 min).  
- 10-week development time, newcomer frontend/backend skills.

---

## ✅ Acceptance Criteria  
- Predicts Real or Fake with ≥ **80% confidence**.  
- Achieves ≥ **85% accuracy** on the test set.

---

## 👫 Team & Roles  
- **Shailesh Gole:** Team Lead, Data Scientist (Model design, training).  
- **Saumya Singh:** Frontend Developer (UI design).  
- **Urvashi Agrawal:** Backend Lead (API, model integration).

---

## 📅 Development Plan  
- Weeks 1-8: From dataset prep → CNN → RNN → ANN → Backend API → Frontend UI → Testing & Demo.  
- Final delivery targeted: **October 26, 2025**.

---

## 👥 Users & UX  
- Target users: Researchers, Students.  
- Simple workflow: Upload video → System processes → Detects → Displays result + confidence.  
- Emphasis on fast results within **1 minute**.

---

## 🏆 Competitors & Differentiators  
| Competitor              | Strengths               | Weaknesses              | Our Advantage                |
|------------------------|------------------------|------------------------|------------------------------|
| Microsoft Video Authenticator | Industry backing, Real-time | Paid, Limited access      | Open educational access      |
| Deepware Scanner          | Browser-based, Accessible | Limited accuracy          | Customizable & focused       |
| Intel FakeCatcher         | High accuracy, Research focus | Not public                 | Educational & open platform  |

---

## 📊 Architecture  
- Frontend: **HTML, CSS, JavaScript**  
- Backend: **Flask/FastAPI**  
- Model: **CNN, RNN, ANN**  
- Database: SQLite/MySQL for logs  
- Libraries: TensorFlow/Keras, OpenCV

---

## 🛠️ Testing & Quality  
- Accuracy goal: 85%  
- Unit testing for model & preprocessing  
- API testing with Postman  
- Manual UI testing

---

## ⚠️ Risks & Mitigation  
- GPU unavailability → Use Kaggle/Colab GPUs  
- Overfitting → Data augmentation, dropout  
- Slow inference → Optimize preprocessing

---

## 🚀 Delivery Plan  
- Demo release: October 26, 2025  
- CICD via GitHub  
- Weekly standups & mentor feedback

