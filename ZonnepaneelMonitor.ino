#include <SPI.h>
#include <Wire.h>
#include <ESP8266WiFi.h>
#include <ESP8266WiFiMulti.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h> 

// Dit aanpassen:
#define WIFI_SSID "Netwerk SSID"
#define WIFI_PASS "Netwerk wachtwoord"
// Let op: pas desgewenst ook het IP-adres van de meteruitlezer (regel 96) aan!

#define LED100  D3
#define LED500  D5
#define LED1KW  D6
#define LED5KW  D7
#define LEDROOD D8

ESP8266WiFiMulti D1Mini;

void setup() {
 Serial.begin(115200);
 Serial.println();
 Serial.println("Start...");
 pinMode(LED100,OUTPUT);
 pinMode(LED500,OUTPUT);
 pinMode(LED1KW,OUTPUT);
 pinMode(LED5KW,OUTPUT);
 pinMode(LEDROOD,OUTPUT);
 
 digitalWrite(LED100,HIGH); 
 digitalWrite(LED500,HIGH);
 digitalWrite(LED1KW,HIGH);
 digitalWrite(LED5KW,HIGH);
 digitalWrite(LEDROOD,HIGH);
 delay(2000);
 
 WiFi.mode(WIFI_STA);
 D1Mini.addAP(WIFI_SSID, WIFI_PASS); 
 Serial.println("Wifi OK");
   
 digitalWrite(LED100,LOW); 
 digitalWrite(LED500,LOW);
 digitalWrite(LED1KW,LOW);
 digitalWrite(LED5KW,LOW);
 digitalWrite(LEDROOD,LOW);
}

void loop() { 
 int w=GetWatt();
 if(w<0) {
  // Teruglevering
  digitalWrite(LEDROOD,LOW);
  w=abs(w);
  if(w>=0) digitalWrite(LED100,HIGH);
  if(w>250) digitalWrite(LED500,HIGH);
  if(w>750) digitalWrite(LED1KW,HIGH);
  if(w>2500) digitalWrite(LED5KW,HIGH);
 }
 else {
  digitalWrite(LEDROOD,HIGH);
  digitalWrite(LED100,LOW);
  digitalWrite(LED500,LOW);
  digitalWrite(LED1KW,LOW);
  digitalWrite(LED5KW,LOW);
 }
 
 delay(30000);
}

bool IsZonnecelOK() {
 float W=0;
 if(D1Mini.run()!=WL_CONNECTED) return false; 
 WiFiClient Wifi;
 HTTPClient http;   
 http.begin(Wifi,"http://192.168.0.27/api/v1/data");   
 int httpCode = http.GET();
 Serial.println("Code="+String(httpCode));
 if(httpCode>0) {
  String s = http.getString();   
  DynamicJsonDocument json(1000);
  deserializeJson(json, s);
  W=json["active_power_l1_w"].as<float>();
  if(W<0) return true;
 }
 http.end();
 
 return false;
}

float GetWatt() {
 int W=0;
 if(D1Mini.run()!=WL_CONNECTED) return false; 
 WiFiClient Wifi;
 HTTPClient http;   
 http.begin(Wifi,"http://192.168.0.27/api/v1/data");   
 int httpCode = http.GET();
 Serial.println("Code="+String(httpCode));
 if(httpCode>0) {
  String s = http.getString();   
  DynamicJsonDocument json(1000);
  deserializeJson(json, s);
  W=json["active_power_w"].as<float>();
 }
 http.end();
 
 return W;
}
