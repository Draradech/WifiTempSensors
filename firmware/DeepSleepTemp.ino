#include <DallasTemperature.h>

#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <EEPROM.h>

#define SERIAL_DEBUG 1

#define seconds * 1e6
#define minutes * 60e6

const char * udpAddress = "192.168.0.188";
const int udpPort = 5505;
const int sleepDelay = 300;

WiFiUDP udp;
OneWire oneWire(12);
DallasTemperature temperature(&oneWire);

unsigned long start;
unsigned long connected = 0;
unsigned long sent = 0;

float vcc = -1.0f;
float offset = 0.0f;

ADC_MODE(ADC_VDD);

void setup()
{
  start = millis();
  temperature.begin();
  temperature.setResolution(12);
  temperature.setWaitForConversion(false);
  temperature.requestTemperatures();
  WiFi.begin();
  #if SERIAL_DEBUG
  Serial.begin(115200);
  Serial.println();
  #endif
  EEPROM.begin(4);
  ((uint8_t*)(&offset))[0] = EEPROM.read(0);
  ((uint8_t*)(&offset))[1] = EEPROM.read(1);
  ((uint8_t*)(&offset))[2] = EEPROM.read(2);
  ((uint8_t*)(&offset))[3] = EEPROM.read(3);
}

void loop()
{
  unsigned long now = millis();

  if (now - start > 500 && vcc < 0)
  {
    vcc = ESP.getVcc() / 1024.0f + offset;;
    if (vcc < 3.0)
    {
      #if SERIAL_DEBUG
      Serial.println("\nlow voltage, sleep forever");
      #endif
      ESP.deepSleep(1440 minutes); // note: more than ESP.deepSleepMax(), should lead to sleep "forever"
    }
  }

  if (sent == 0 && WiFi.localIP().isSet() && temperature.isConversionComplete())
  {
    udp.begin(udpPort);
    udp.beginPacket(udpAddress, udpPort);
    #if SERIAL_DEBUG
    Serial.println("\nsending packet");
    #endif

    DeviceAddress deviceAddress;
    oneWire.reset_search();
    while (oneWire.search(deviceAddress))
    {
      if (temperature.validAddress(deviceAddress))
      {
        float temp = temperature.getTempC(deviceAddress);
        udp.printf("%02x%02x%02x%02x%02x%02x", deviceAddress[1], deviceAddress[2], deviceAddress[3], deviceAddress[4], deviceAddress[5], deviceAddress[6]);
        udp.write((const char*)&temp, sizeof(float));
        #if SERIAL_DEBUG
        Serial.printf("%02x%02x%02x%02x%02x%02x: %f\n", deviceAddress[1], deviceAddress[2], deviceAddress[3], deviceAddress[4], deviceAddress[5], deviceAddress[6], temp);
        #endif
      }
    }
    
    uint8_t mac[6];
    wifi_get_macaddr(STATION_IF, mac);

    udp.printf("v_%02x%02x%02x%02x%02x", mac[1], mac[2], mac[3], mac[4], mac[5]);
    udp.write((const char*)&vcc, sizeof(float));
    #if SERIAL_DEBUG
    Serial.printf("v_%02x%02x%02x%02x%02x: %f\n", mac[1], mac[2], mac[3], mac[4], mac[5], vcc);
    #endif

    float channel = WiFi.channel();
    udp.printf("c_%02x%02x%02x%02x%02x", mac[1], mac[2], mac[3], mac[4], mac[5]);
    udp.write((const char*)&channel, sizeof(float));
    #if SERIAL_DEBUG
    Serial.printf("c_%02x%02x%02x%02x%02x: %f\n", mac[1], mac[2], mac[3], mac[4], mac[5], channel);
    #endif

    float rssi = WiFi.RSSI();
    udp.printf("r_%02x%02x%02x%02x%02x", mac[1], mac[2], mac[3], mac[4], mac[5]);
    udp.write((const char*)&rssi, sizeof(float));
    #if SERIAL_DEBUG
    Serial.printf("r_%02x%02x%02x%02x%02x: %f\n", mac[1], mac[2], mac[3], mac[4], mac[5], rssi);
    #endif

    udp.printf("d_%02x%02x%02x%02x%02x", mac[1], mac[2], mac[3], mac[4], mac[5]);
    sent = millis();
    float delay = 0.001f * (sent - start + sleepDelay);
    udp.write((const char*)&delay, sizeof(float));
    #if SERIAL_DEBUG
    Serial.printf("d_%02x%02x%02x%02x%02x: %f\n", mac[1], mac[2], mac[3], mac[4], mac[5], delay);
    #endif

    udp.endPacket();
  }
  else if(sent > 0 && now - sent > sleepDelay)
  {
    #if SERIAL_DEBUG
    Serial.println("sleep");
    #endif
    ESP.deepSleep((vcc < 3.15) ? (10 minutes) : (118 seconds));
  }
  else if(now - start > 10000)
  {
    #if SERIAL_DEBUG
    Serial.println("\ntimeout");
    Serial.println(WiFi.localIP());
    #endif
    ESP.deepSleep(10 minutes);
  }
}