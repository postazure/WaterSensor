int sensorPin = A0;
int waterLevelVal = 0;
int waterLevel = 0;
int prevWaterLevel = 0;

void setup() {
  pinMode(sensorPin, INPUT);
}

void loop() {
  waterLevelVal = analogRead(sensorPin);
  waterLevel = getPercentForLevel(waterLevelVal);

  if (waterLevel < prevWaterLevel) {
    String message;
    message = String("Water level is now ") +  String(waterLevel) + String("%.");
    Particle.publish("water_level", message, PRIVATE);
  }

  prevWaterLevel = waterLevel;
  delay(1000);
}

int getPercentForLevel(int level) {
  if(level < 1000) {
    return 0;
  } else if (level <= 1600) {
    return 25;
  } else if (level <= 1800) {
    return 50;
  } else if (level <= 1950) {
    return 75;
  } else {
    return 100;
  }
}
