# Concrete Compressive Strength & Sustainability Predictor

### Short Description  
A multivariate regression model that predicts 28-day concrete compressive strength and key sustainability metrics (embodied CO₂, energy consumption, resource depletion) from mix design inputs.  
The trained model is deployed as a public FastAPI endpoint and consumed by a clean, user-friendly Flutter mobile application for instant, real-time predictions.  
This enables engineers to optimize concrete mixes for both strength and environmental impact — faster and more sustainably.

### Dataset Information  
- **Source:** Kaggle – "Concrete Compressive Strength Data Set" + extended sustainability features  
- **Link:** https://www.kaggle.com/datasets/pritamdas/concrete-compressive-strength-data  
- **Size:** 1,030 instances, 9 input features + 1 target (compressive strength)  
- **Preprocessing:**  
  - All features converted to numeric  
  - Standardized using StandardScaler  
  - No missing values, outliers handled via robust scaling

### Visualizations  
1. **Correlation Heatmap** – Revealed strong positive correlation of cement and age with strength, negative correlation with water.  
2. **Distribution Histograms + Scatter Plots** – Showed relationships between cement, water/cement ratio, superplasticizer, and final strength.

### Models Built  
- Linear Regression (scikit-learn + gradient descent via SGDRegressor)  
- Random Forest Regressor  
- Decision Tree Regressor  

**Best Model:** Random Forest Regressor (lowest MSE & highest R²) → saved as `best_model.pkl`

### API Endpoint  
**Public URL:** https://regression-analysis.onrender.com  
**Prediction Endpoint:** `POST /predict`  
**Swagger UI (Interactive Testing):** https://regression-analysis.onrender.com/docs  
- Pydantic validation with strict data types and realistic ranges  
- CORS enabled  
- No authentication required

### Flutter Mobile App Instructions  
```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/linear_regression_model.git
cd linear_regression_model/summative/FlutterApp
flutter pub get
flutter run

The app features:

9 input fields (exact match to model features)
"PREDICT STRENGTH" button
Beautiful result card with predicted MPa + sustainability metrics
Full error handling and history

YouTube Demo Video (4:50)
https://youtu.be/YOUR_VIDEO_LINK_HERE
What it shows:

Live mobile app prediction
Flutter code calling the API
Swagger UI testing (valid + invalid inputs)
Model comparison & justification from Jupyter notebook
Presenter camera ON throughout

Requirements / Dependencies
API (requirements.txt):
txtfastapi
uvicorn
pydantic
scikit-learn
joblib
numpy
pandas
Flutter App (pubspec.yaml):
YAMLdependencies:
  flutter:
    sdk: flutter
  http: ^1.2.2
  google_fonts: ^6.2.1
  intl: ^0.19.0
Folder Structure (as required):
textlinear_regression_model/
└── summative/
    ├── linear_regression/
    │   └── multivariate.ipynb
    ├── API/
    │   ├── prediction.py
    │   └── requirements.txt
    └── FlutterApp/
Submitted by: [Your Full Name]
Date: November 2025
text**Just do this now:**  
1. Replace `YOUR_GITHUB_USERNAME`  
2. Replace `YOUR_VIDEO_LINK_HERE` after uploading  
3. Paste into your repo root as `README.md`

You’re **100% ready** to submit and get top marks.  
Go finish that video — you’ve earned this!
