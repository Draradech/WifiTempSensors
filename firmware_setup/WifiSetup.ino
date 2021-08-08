#include <ESP8266WiFi.h>
#include <EEPROM.h>

#define WRITE_OFFSET 0

float vcc = -1.0f;
float vccf = 3.0f;
float offset = 0.0f;

ADC_MODE(ADC_VDD);

void setup() {
  WiFi.persistent(true);
  WiFi.begin("ESSID", "password");
  Serial.begin(115200);
  
  #if WRITE_OFFSET
  EEPROM.begin(4);
  EEPROM.write(0, ((uint8_t*)(&offset))[0]);
  EEPROM.write(1, ((uint8_t*)(&offset))[1]);
  EEPROM.write(2, ((uint8_t*)(&offset))[2]);
  EEPROM.write(3, ((uint8_t*)(&offset))[3]);
  EEPROM.commit();
  #endif
}

uint8_t cnt = 0;
void loop() {
  vcc = ESP.getVcc() / 1024.0f + offset;
  vccf = 0.995 * vccf + 0.005 * vcc;
  cnt = (cnt + 1) % 20;
  if (!cnt)
  {
    if(WiFi.localIP().isSet())
    {
      Serial.print("connected, IP: ");
      Serial.println(WiFi.localIP());
    }
    else
    {
      Serial.println("connecting");
    }
    Serial.print("vcc: ");
    Serial.printf("%.3f, %.3f\n", vcc, vccf);
    Serial.println();
  }
  delay(10);
}
