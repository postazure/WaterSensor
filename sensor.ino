int sensorPin = A0;
int waterLevelVal = 0;
int waterLevel;

void setup() {
  pinMode(sensorPin, INPUT);
  Particle.variable("WATER_LEVEL", waterLevel);
  Particle.variable("RAW", waterLevelVal);
}

void loop() {
  waterLevelVal = analogRead(sensorPin);
  waterLevel = getPercentForLevel(waterLevelVal);
  delay(100);
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
