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

---

> *Made with ❤️ by Team T-87 from GLA University*


