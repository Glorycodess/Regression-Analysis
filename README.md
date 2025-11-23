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
git clone https://github.com/Glorycodess/linear_regression_model.git
cd linear_regression_model/summative/FlutterApp
flutter pub get
flutter run
