# Concrete Compressive Strength & Sustainability Predictor

<a href="https://youtu.be/_iSXXStC28M" target="_blank">
  <img src="https://img.youtube.com/vi/_iSXXStC28M/maxresdefault.jpg" alt="Watch the Live Demo" width="100%" style="border-radius:12px; box-shadow: 0 8px 25px rgba(0,0,0,0.4);"/>
</a>

<p align="center">
  <a href="https://youtu.be/_iSXXStC28M" target="_blank"><h2>Watch Live Demo Video (Click the image above)</h2></a>
</p>

**Predicts concrete compressive strength + sustainability metrics (CO₂, energy, resource depletion) from mix design inputs.**  
Trained Random Forest model deployed as a public FastAPI endpoint.  
Instant real-time predictions via a beautiful Flutter mobile app.  
Helps engineers create stronger, greener concrete — fast and sustainably.

### Dataset
- Source: Kaggle (extended with sustainability features)  
- Link: https://www.kaggle.com/datasets/pritamdas/concrete-compressive-strength-data  
- 1,030 samples | 9 input features | Preprocessed & standardized

### Best Model
Random Forest Regressor → `best_model.pkl`

### Public API
- Base URL: https://regression-analysis.onrender.com  
- Predict: https://regression-analysis.onrender.com/predict  
- Swagger UI: https://regression-analysis.onrender.com/docs  
(No auth • CORS enabled • Pydantic validation)

### Flutter Mobile App
```bash
git clone https://github.com/Glorycodess/linear_regression_model.git
cd linear_regression_model/summative/FlutterApp
flutter pub get
flutter run