# Concrete Compressive Strength & Sustainability Predictor

**Description of mission and problem**  
Develop a multivariate regression model to predict concrete compressive strength along with embodied CO₂, energy consumption, and resource depletion from mix design parameters. The model is deployed as a public REST API and consumed by a clean, user-friendly Flutter mobile application for instant predictions.

**Publicly available API endpoint**  
https://regression-analysis.onrender.com  

Test directly here (Swagger UI):  
https://regression-analysis.onrender.com/docs  

Endpoint: `POST /predict`  
(No authentication required – fully public and routable)

**YouTube demo video (≤ 5 minutes)**  
https://youtu.be/XXXXXX  
*(Replace with your actual unlisted/public link after upload)*

**How to run the mobile app**

```bash
# 1. Clone the repo
git clone https://github.com/YOUR_USERNAME/linear_regression_model.git

# 2. Go to the Flutter app folder
cd linear_regression_model/summative/FlutterApp

# 3. Install dependencies
flutter pub get

# 4. Run the app (phone connected or emulator running)
flutter run
